import("..resource.ImportAllRes")
local shade = import("..effect.shade")
local giftBag = import("..views.giftBag")
local scheduler = require("framework.scheduler")
local MobileMMSdk = import("..SDK.MobileMM")

local resurgence = class("resurgence",function() return display.newNode() end)

function resurgence:ctor(netWorkState,firstGame,closeCallBack,resurgenceCallBack,failResurgenceCallBack,gameSceneBottomView)
   
    self.gameSceneBottomView = gameSceneBottomView 
    self.resurgenceCallBack = resurgenceCallBack
    self.failResurgenceCallBack = failResurgenceCallBack
    self:setContentSize(DATA_pic_width,DATA_pic_height)
    self:setAnchorPoint(cc.p(0.5, 0.5))
    self:setScale(DATA_scale_changeResolution)

    local grayShade = shade:createGrayShade()
    local BG = display.newSprite(PIC_bg_resurgence)
    BG:setPosition(self:getContentSize().width/2,self:getContentSize().height/2 + 30)


    local closeButton = display.newSprite(PIC_icon_close2)
    closeButton:setPosition(BG:getContentSize().width-37,375)
    closeButton:setTouchEnabled(true)
    closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
        utility:playSound(Music_enterButton) 
        self:close(closeCallBack)
    end)
    
    local playBeyondSelf = display.newSprite(PIC_text_continuePlayBeyondSelf)
    playBeyondSelf:setPosition(BG:getContentSize().width/2,BG:getContentSize().height*0.7+60)

    local enterButton = display.newSprite(PIC_icon_greenEnterButton)
    enterButton:setPosition(BG:getContentSize().width/2 ,BG:getContentSize().height/100*25+10)
    enterButton:setTouchEnabled(true)
    enterButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:enterButton(resurgenceCallBack,failResurgenceCallBack) end)


    local secText = display.newSprite(PIC_text_secText)
    secText:setPosition(enterButton:getContentSize().width/2 +110 ,enterButton:getContentSize().height/2)

    self.residueTime = 5
    self.residueTimeLabel = cc.LabelAtlas:_create(self.residueTime,PIC_num_whiteRound, 16, 14, string.byte("0")) 
    self.residueTimeLabel:setPosition(enterButton:getContentSize().width/2 + 80 ,enterButton:getContentSize().height/2 - self.residueTimeLabel:getContentSize().height/2)
local ok, ret =luaoc.callStaticMethod("AppController", "showAd")
print(ok,ret)
    BG:addChild(playBeyondSelf)
    BG:addChild(closeButton)
    BG:addChild(enterButton)
    enterButton:addChild(self.residueTimeLabel)
    enterButton:addChild(secText)

    grayShade:addChild(BG)
    self:addChild(grayShade)

    self.residueTimehandle = scheduler.scheduleGlobal(handler(self,self.updateResidueTime), 1.0)

end

function resurgence:updateResidueTime()
    
    self.residueTime = self.residueTime - 1
    self.residueTimeLabel:setString(self.residueTime)
    if self.residueTime == 0 then 
        scheduler.unscheduleGlobal(self.residueTimehandle)
        self:enterButton(self.resurgenceCallBack,self.failResurgenceCallBack)
        return 
    end
end

function resurgence:close(closeCallBack)
    scheduler.unscheduleGlobal(self.residueTimehandle)
    closeCallBack()
    self:removeSelf()
end

function resurgence:loadNum(  )
        local diamond = UserData:getDiamondNum()
        if self.gameSceneBottomView~=nil then 
            self.gameSceneBottomView:setDiamondNumShow(diamond)
        end

   
        local magic = UserData:getMagicNum()
        if self.gameSceneBottomView~=nil then 
            self.gameSceneBottomView:setMagicNumShow(magic)
        end

        local refresh = UserData:getRefreshNum()
        if self.gameSceneBottomView~=nil then 
            self.gameSceneBottomView:setRefreshNum(refresh)
        end
end

function resurgence:enterButton(resurgenceCallBack,failResurgenceCallBack)

    if UserData:getDiamondNum() >= DATA_num_resurgenceCost then
        resurgenceCallBack()
        self.gameSceneBottomView:setPropNum(-DATA_num_resurgenceCost,nil,nil)
    else 
    self:getParent():addChild(giftBag.new(
                                function (  ) self.gameSceneBottomView:reloadBag() self.gameSceneBottomView:setPropNum(-DATA_num_resurgenceCost,nil,nil) resurgenceCallBack() end,
                                function() self:setVisible(true) end,
                                nil),102,888)
    end

    self.residueTime = 0
    self.residueTimeLabel:setString(self.residueTime)
    scheduler.unscheduleGlobal(self.residueTimehandle)
    self:setVisible(false)

    if self.residueTimehandle~= nil then
        scheduler.unscheduleGlobal(self.residueTimehandle)
    end
end

return resurgence