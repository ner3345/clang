
local HttpService = class("HttpService")

local NEEDUPDATE   = true
local server       = "http://star.xiguakeji.com/server/" 




local meta = HttpService

INIT_USER_REQ = "INIT_USER_REQ"
GET_NOTICE = "GET_NOTICE"
GET_continueLoginPrize = "GET_continueLoginPrize"
GET_continueLoginPrizeList = "GET_continueLoginPrizeList"
GET_UseCDKey = "GET_UseCDKey"


meta.urlSuffix                              = {}
meta.urlSuffix[INIT_USER_REQ]               = "index.php?m=User&a=init" --username 用户登陆帐号  nickname 用户昵称
meta.urlSuffix[GET_NOTICE]                  = "index.php?m=Notice&a=index&mid="  
meta.urlSuffix[GET_continueLoginPrize]      = "index.php?m=Reward&a=getReward"
meta.urlSuffix[GET_continueLoginPrizeList]  = "index.php?m=Reward&a=rewardList"
meta.urlSuffix[GET_UseCDKey]                = "index.php?m=Index&a=cdkey"

function meta:sendRequest(cmd, params, callback,isshowerror)
    local url = server..meta.urlSuffix[cmd]
    local _callback
    if callback ~= nil then
        _callback = callback
    else
        _callback = handler(self, self.onCallBack)
    end
    local postdata = self:http_build_query(params)
    self:requestFromServer(url, postdata, _callback,isshowerror)
end

function HttpService:requestFromServer(url, postdata, callbcak,isshowerror)
    local request = network.createHTTPRequest(function(event)
        self:onResponse(event, callbcak,isshowerror)
    end, url, "POST") --"POST" "GET"
    if request then
        --print(postdata)
        request:setPOSTData(postdata)
        request:setTimeout(30)
        request:start()
    else
        printf("requestFromServer REQUEST ERROR")
    end
end

function HttpService:onResponse(event, callbcak,isshowerror)
    local request = event.request
    --printf("REQUEST - event.name = %s", event.name)
    if event.name == "completed" then
        printf("REQUEST - getResponseStatusCode() = %d", request:getResponseStatusCode())
        --printf("REQUEST %d - getResponseHeadersString() =\n%s", index, request:getResponseHeadersString())

        if request:getResponseStatusCode() ~= 200 then
            print(isshowerror)
            print("ERROR REQUEST "..request:getResponseStatusCode())
            if isshowerror == true then
                callbcak(404)
            end
        else
            printf("REQUEST - getResponseDataLength() = %d", request:getResponseDataLength())
            if dumpResponse then
                printf("REQUEST - getResponseString() =\n%s", request:getResponseString())
            end
            self.dataRecv = request:getResponseData()
            if self.dataRecv then
                local data = json.decode(self.dataRecv)
                --dump(data)
                if data then
                    callbcak(data)
                else
                    printf("ERROR REQUEST - json.decode = %s", self.dataRecv)
                end
            end
        end
        
    elseif event.name == "inprogress" then 
            
    else
        printf("ERROR REQUEST - getErrorCode() = %d, getErrorMessage() = %s", request:getErrorCode(), request:getErrorMessage())
        if isshowerror == true then
            callbcak(404)
        end
    end

--    print("----------------------------------------")
end

function HttpService:onCallBack(data)
    dump(data)
end

function HttpService:down(url, filename, path, callback)
  
    --echoInfo("down.... url[%s] ", url)

    local request = network.createHTTPRequest(function(event)
        self:onDownResponse(event, filename, path, callback)
    end, url, "GET")
    if request then
        --request:setAcceptEncoding(kCCHTTPRequestAcceptEncodingGzip)
        request:setTimeout(30)
        request:start()
 
    end
end

function HttpService:onDownResponse(event, filename, path, callback)
  local request = event.request

  --echoInfo("onResponse.... name[%s] file[%s] code[%s] ", 
              --event.name, path .. filename, request:getResponseStatusCode())

  if event.name == "completed" and request:getResponseStatusCode() == 200 then
    local dataRecv = request:getResponseData()
    if dataRecv then
      local filePathName = path .. filename;
      
      --echoInfo("onResponse.... file[%s] ", filePathName)

      File:writeFile(filePathName, dataRecv)
      --io.writefile(filePathName, dataRecv)
      callback(filePathName)

    end
  
  end

end

function HttpService:http_build_query(data)
    if type(data) ~= "table" then
        return ""
    end
    local strData = {}
    for k, v in pairs(data) do
        table.insert(strData, k .. "=" .. self:urlencode(v))
    end

    return table.concat(strData, "&")
end

function HttpService:urlencode(str)
    local function urlencodeChar(c)
        return "%" .. string.format("%02X", string.byte(c))
    end

    -- convert line endings
    str = string.gsub(tostring(str), "\n", "\r\n")
    -- escape all characters but alphanumeric, '.' and '-'
    str = string.gsub(str, "([^%w%.%- ])", urlencodeChar)
    -- convert spaces to "+" symbols
    return string.gsub(str, " ", "+")
end

return HttpService
