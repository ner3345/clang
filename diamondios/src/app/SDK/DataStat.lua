
local DataStat = class("DataStat")

function DataStat:init(data)
  echoInfo("MobileMM2Sdk init...")
end

function DataStat:stat(paras)
  -- call Java method
  -- print("DataStat",paras.event_name,paras.label_name)
  local javaClassName = "xiguakeji.lovepop.gp.Gp"
  local javaMethodName = "dataStat"
  local javaParams = {
    paras.event_name,
    paras.label_name,
    function(event)
      print("success")
    end
  }
  -- dump(javaParams)
  --local javaMethodSig = "(Ljava/lang/String;Ljava/lang/String;I)V"
  --if luaj ~= nil then
  --  local ok, ret = luaj.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
  --  print(ok,ret)
  --end
end

return DataStat