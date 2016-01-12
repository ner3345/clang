import("..resource.ImportAllRes")
local MobileMMSdk = import("..SDK.MobileMM")
local giftBag = import("..views.giftBag")

local finallyScore = class("finallyScore",function() return display.newNode() end)

function finallyScore:ctor(councilScore,currentLevel,resurgenceCallBack,backCallBack,gameSceneBottomView)

    self.gameSceneBottomView = gameSceneBottomView 
    self:setContentSize(DATA_pic_width,DATA_pic_height)
    self:setAnchorPoint(cc.p(0.5, 0.5))
    self:setScale(DATA_scale_changeResolution)

    local BG = display.newSprite(PIC_bg_prettyGirl)
    BG:setPosition(self:getContentSize().width/100*55,self:getContentSize().height/100*70)

    local councilScoreText = display.newSprite(PIC_text_councilScore)
    councilScoreText:setPosition(self:getContentSize().width/100*35,self:getContentSize().height/100*54)

    local currentLevelText = display.newSprite(PIC_text_currentLevel)
    currentLevelText:setPosition(self:getContentSize().width/100*42,self:getContentSize().height/100*48)

    local councilScoreNum  = CCLabelAtlas:create(councilScore,PIC_num_yellowRound, 32, 30, string.byte("0"))
    councilScoreNum:setPosition(self:getContentSize().width/100*57,self:getContentSize().height/100*52)

    local currentLevelNum  = CCLabelAtlas:create(currentLevel,PIC_num_yellowRound, 32, 30, string.byte("0"))
    currentLevelNum:setPosition(self:getContentSize().width/100*65,self:getContentSize().height/100*46)

    local restartFirstLevel = display.newSprite(PIC_text_restartFirstLevel)
    restartFirstLevel:setPosition(self:getContentSize().width/2,self:getContentSize().height/100*26)

    local enterButtion = display.newSprite(PIC_button_purplePink) 
    enterButtion:setPosition(self:getContentSize().width/2,self:getContentSize().height/100*35)

    local costFiveResurgenceText = display.newSprite(PIC_text_costFiveResurgence)
    costFiveResurgenceText:setPosition(self:getContentSize().width/2,self:getContentSize().height/100*35)


    enterButtion:setTouchEnabled(true)
    enterButtion:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:resurgence(resurgenceCallBack,nil) end)

    restartFirstLevel:setTouchEnabled(true)
    restartFirstLevel:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:backToFirstLevel(backCallBack) end)

    local giftBagIcon = display.newSprite(PIC_icon_giftBag)
    giftBagIcon:setPosition(420 , 150)
    giftBagIcon:setScale(2/3)
    giftBagIcon:setTouchEnabled(true)
    giftBagIcon:addNodeEventListener(cc.NODE_TOUCH_EVENT,  
                                                function(event) 
                                                    DataStat:stat(DATA_count_finallySceneGiftBag[3])
                                                    utility:playSound(Music_enterButton) 
                                                    local giftBagView = giftBag.new(nil,nil,Kind_view.finallyScene)
                                                    bg = giftBagView:getChildByTag(1000):getChildByTag(1000)
                                                    bg:setScale(1)
                                                    bg:setPosition(display.cx-120,display.cy-220)
                                                    self:addChild(giftBagView) 
                                                end)

    self:addChild(BG)
    self:addChild(councilScoreText) 
    self:addChild(currentLevelText)
    self:addChild(councilScoreNum)
    self:addChild(currentLevelNum)
    self:addChild(restartFirstLevel)
    self:addChild(enterButtion)
    self:addChild(costFiveResurgenceText)
    self:addChild(giftBagIcon)

    local sequence = transition.sequence({
            CCScaleTo:create(DATA_time_giftBagChangeInterval, 0.9,0.9),
            CCScaleTo:create(DATA_time_giftBagChangeInterval, 2/3+0.1,2/3+0.1),
            })
    giftBagIcon:runAction(CCRepeatForever:create(sequence)); 

end

function finallyScore:backToFirstLevel(backCallBack)
    if backCallBack ~= nil then
        backCallBack()
        self:removeSelf()
    end
end

function finallyScore:resurgence(resurgenceCallBack,failResurgenceCallBack)
    if UserData:getDiamondNum() < DATA_num_resurgenceCost then
        if UserData:getResurgenceNum() == 0 then 
            DataStat:stat(DATA_count_Resur[7])
            MobileMMSdk:payment(DATA_costCode_all.firstResur,function() self:paymentSucess(resurgenceCallBack,1) DataStat:stat(DATA_count_Resur[8]) end ,function() self:failPayment(failResurgenceCallBack)end)
        elseif UserData:getResurgenceNum() == 1 then 
            DataStat:stat(DATA_count_Resur[9])
            MobileMMSdk:payment(DATA_costCode_all.secondResur,function() self:paymentSucess(resurgenceCallBack,2) DataStat:stat(DATA_count_Resur[10]) end,function() failResurgenceCallBack() self:removeSelf() end)
        elseif UserData:getResurgenceNum() > 2 then 
            DataStat:stat(DATA_count_Resur[11])
            MobileMMSdk:payment(DATA_costCode_all.resurGifBag,
                                                        function() 
                                                            resurgenceCallBack() 
                                                            self.gameSceneBottomView:setPropNum(DATA_num_resurgenceGiftBagDiamond ,nil,nil) 
                                                            UserData:setResurgenceNum(3)  
                                                            self:removeSelf()  
                                                            DataStat:stat(DATA_count_Resur[12])
                                                        end,
                                                        function() 
                                                            failResurgenceCallBack() 
                                                            self:removeSelf() 
                                                        end)
        end
    else 
        resurgenceCallBack()
        self.gameSceneBottomView:setPropNum(-DATA_num_resurgenceCost,nil,nil)
        self:removeSelf()
    end
end

function finallyScore:paymentSucess(resurgenceCallBack,i)
    UserData:setResurgenceNum(i) 
    resurgenceCallBack()
    self:removeSelf()                 
end

function finallyScore:failPayment(failResurgenceCallBack)
    failResurgenceCallBack() 
    self:removeSelf()
end

return finallyScore

