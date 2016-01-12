local SystemConfirm = import("..views.update")
local Apk_upd = class("Apk_upd")
local M = Apk_upd

local apk_server = UPDARE_APK_SERVER
local apk_List_filename = "apk_flist"

function M:ctor(updateScene, filePath, random)
  ----[[
  self.updateScene = updateScene
  self.curApkListFile = filePath..apk_List_filename
  self.random = random

  self.apkFileList = nil
  
  self.requestCount = 0
  self.dataRecv = nil
  self.requesting = ""
  
  self.newApkListFile = ""

end

function M:updateApk()

  if io.exists(self.curApkListFile) then
    self.apkFileList = dofile(self.curApkListFile)
  end
  if self.apkFileList == nil then
    self.apkFileList = {
      ver = VERSION,
      url = "",
      size = 0,
    }
  end

  self.requestCount = 0
  self.dataRecv = nil
  
  self.requesting = apk_List_filename
  self.newApkListFile = self.curApkListFile..".upd"

  local url = "http://star.xiguakeji.com/server/apkup/zs2015/apk_flist.flist"
  self:requestApkFromServer(url)
  
  self.updateScene:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function()
        self:onEnterFrameInApkVersion() 
  end)
  self.updateScene:scheduleUpdate()

end

function M:requestApkFromServer(url)
  CCLuaLog("down apk url : " .. url)

  local index = self.requestCount
  local filesize = 0
  local request = network.createHTTPRequest(function(event)
    self:onResponse(event, filesize, index)
  end, url, "GET")
  
  if request then
    request:setTimeout(waittime or 10)
    request:start()
  else
    --self.updateScene:endProcess()
  end
end

function M:onResponse(event, filesize, index)
  local request = event.request
  
  if event.name == "completed" then
  
    printf("APK REQUEST %d - getResponseStatusCode() = %d", index, request:getResponseStatusCode())

    if request:getResponseStatusCode() ~= 200 then
      printf("APK REQUEST 200")
      --self.updateScene:endProcess()
      
    else
      self.dataRecv = request:getResponseData()
      
    end
  else
    printf("APK REQUEST %d - getErrorCode() = %d, getErrorMessage() = %s", 
                          index, request:getErrorCode(), request:getErrorMessage())
    --self.updateScene:endProcess()
    
  end

--  print("----------------------------------------")
end

function M:onEnterFrameInApkVersion()
  if not self.dataRecv or self.requesting ~= apk_List_filename then return end

  io.writefile(self.newApkListFile, self.dataRecv)
  self.dataRecv = nil

  self.apkFileListNew = dofile(self.newApkListFile)
  if self.apkFileListNew == nil then
    CCLuaLog(self.newListFile..": Open Error!")
    
    --self.updateScene:updateLua()
    
    return
    
  end

  CCLuaLog("old apk ver : " .. self.apkFileList.ver)
  CCLuaLog("new apk ver : " .. self.apkFileListNew.ver)
  
  if self:getApkVersion(self.apkFileListNew.ver) == self:getApkVersion(self.apkFileList.ver) then
    print("Version===")
    
    return
  end

  local params = {}

  params.listener = function() 
    app:enterLoginScene()
  end
  params.otherListener = function() 
    self:downApkFiles()
  end

  local dialog = SystemConfirm.new(params.otherListener,params.listener)
  local scene = display.getRunningScene()
  scene:addChild(dialog)
end

function M:downApkFiles()
  print("downApkFiles")
  ----[[
  -- call Java method
  local javaClassName = "xiguakeji.lovepop.gp.Local_SDK"
  local javaMethodName = "downLoadApk"
  local javaParams = {self.apkFileListNew.url}


  local javaMethodSig = "(Ljava/lang/String;)V"
  local ok, ret = luaj.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)

  if not ok then
      print("luaj error:", ret)
  else
      print("ret:", 5) -- 输出 ret: 5
  end
  --]]
end

function M:getApkVersion(version)
  local verList = string.split(version, ".")
  -- verList = {"1", "2", "3"}
  return verList[1]
end

return M