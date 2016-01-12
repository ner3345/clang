import("..resource.ImportAllRes")
local shade = import("..effect.shade")
local MobileMMSdk = import("..SDK.MobileMM")
local BubbleButton = import("..views.BubbleButton")
local loading = import("..effect.loading")

local thinkFulBag = class("thinkFulBag",function() return display.newNode() end)

function thinkFulBag:ctor(getCallBack,closeCallBack,entrance)
    
    self.entrance = entrance
     
    local grayShade = shade:createGrayShade()
    local bg = display.newSprite(PIC_text_thinkFulBag)
    bg:setScale(DATA_scale_changeResolution)
    bg:setPosition(display.width/2,display.height/2)
    bg:setTag(1000)
    local closeButton = display.newSprite(PIC_icon_close2)
    closeButton:setPosition(bg:getContentSize().width - closeButton:getContentSize().width/2 + 10 ,bg:getContentSize().height - closeButton:getContentSize().height/2 - 60 )
    closeButton:setTouchEnabled(true)
    closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) if closeCallBack~=nil then closeCallBack() end self:removeSelf() end)
    
    --local contentBg = display.newSprite(PIC_bg_giftBagContent)
    --contentBg:setPosition(bg:getContentSize().width/2,bg:getContentSize().height/2 + 60)

    -- local getButton = display.newSprite(PIC_button_getGreen)
    -- getButton:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.21)
    -- getButton:setTouchEnabled(true)

    local getButton = BubbleButton.new({image = PIC_button_getGreen,listener = function (  )
            self:addLoading()
            -- self:countShop(1)
            utility:playSound(Music_enterButton) 
            MobileMMSdk:payment(DATA_costCode_all.privilegeGifBag, function() 
                -- self:countShop(2)
                self.entrance:removeSelf()
                self:gotGiftBag()
                UserData:setIsButThingkFulBag(1)
            end,function () loading:onButtonClicked(self.loadings) end) 
        end})

    getButton:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.21)

    -- getButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
    --                                             function(event) 
    --                                                 utility:playSound(Music_enterButton) 
    --                                                 MobileMMSdk:payment(DATA_costCode_all.resurGifBag,
    --                                                                                             function() 
    --                                                                                                 self.entrance:removeSelf()
    --                                                                                                 self:gotGiftBag() 
    --                                                                                                 UserData:setIsButThingkFulBag(1)
    --                                                                                             end,
    --                                                                                             nil ) 
                                                                                                
    --                                                 end)

    --bg:addChild(contentBg)
    bg:addChild(getButton)
    bg:addChild(closeButton)
    grayShade:addChild(bg)
    grayShade:setTag(1000)
    self:addChild(grayShade)

    local sequence = transition.sequence({
            cc.ScaleTo:create(DATA_time_giftBagChangeInterval,0.8,0.8),
            cc.ScaleTo:create(DATA_time_giftBagChangeInterval,1.1,1.1),
            })
    getButton:runAction(cc.RepeatForever:create(sequence)); 
end

function thinkFulBag:gotGiftBag()
    UserData:addProp(10,nil,nil)
    
    self:removeSelf() 
    
end

function thinkFulBag:addLoading(  )
    self.loadings = loading:createGrayloading()
    self:addChild(self.loadings,1)
    loading:createBlendloading(self.loadings,self)
end

--function thinkFulBag:countKind()
--    if self.entrance ~= nil then
--        if self.entrance == Kind_view.loginScene then
--            self.countList = DATA_count_loginSceneGiftBag
--        end
--        if self.entrance == Kind_view.gameScene then
--            self.countList = DATA_count_gameSceneGiftBag
--        end
--        if self.entrance == Kind_view.finallyScene then
--            self.countList = DATA_count_finallySceneGiftBag
--        end
--    end
--end

--function thinkFulBag:countShop(countEvent)
--    if self.entrance ~= nil then 
--        DataStat:stat(self.countList[countEvent])
--    end
--end

return thinkFulBag