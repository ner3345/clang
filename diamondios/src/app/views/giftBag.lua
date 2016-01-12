import("..resource.ImportAllRes")
local shade = import("..effect.shade")
local BubbleButton = import("..views.BubbleButton")
local MobileMMSdk = import("..SDK.MobileMM")
local loading = import("..effect.loading")

local giftBag = class("giftBag",function() return display.newNode() end)

function giftBag:ctor(getCallBack,closeCallBack,entrance)
    self.entrance = entrance
    self:countKind()
    local grayShade = shade:createGrayShade()
    local bg = display.newSprite(PIC_bg_giftBag)
    bg:setScale(1.5)
    bg:setPosition(display.width/2,display.height/2)
    bg:setTag(1000)
    local closeButton = display.newSprite(PIC_icon_close2)
    closeButton:setPosition(bg:getContentSize().width - closeButton:getContentSize().width/2 + 20 ,bg:getContentSize().height - closeButton:getContentSize().height/2 +20 )
    closeButton:setTouchEnabled(true)
    closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) if closeCallBack~=nil then closeCallBack() end self:removeSelf() end)
    
    local contentBg = display.newSprite(PIC_bg_giftBagContent)
    contentBg:setPosition(bg:getContentSize().width/2,bg:getContentSize().height/2 + 60)

     local getButton = BubbleButton.new({image = PIC_button_getGreen,listener = function (  )
            self:addLoading()
            self:countShop(1)
            utility:playSound(Music_enterButton) 
            MobileMMSdk:payment(DATA_costCode_all.resurGifBag, function() 
                self:countShop(2)
                self:gotGiftBag(getCallBack) 
            end,function () loading:onButtonClicked(self.loadings) end) 
        end})
     getButton:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.18)

    bg:addChild(contentBg)
    bg:addChild(closeButton)
    grayShade:addChild(bg)
    grayShade:setTag(1000)
    bg:addChild(getButton)
    self:addChild(grayShade)

    local sequence = transition.sequence({
            cc.ScaleTo:create(DATA_time_giftBagChangeInterval,0.8,0.8),
            cc.ScaleTo:create(DATA_time_giftBagChangeInterval,1.1,1.1),
            })
    getButton:runAction(cc.RepeatForever:create(sequence)); 
end

function giftBag:gotGiftBag(getCallBack)
    UserData:addProp(DATA_num_giftBagProp[1],DATA_num_giftBagProp[2],DATA_num_giftBagProp[3],DATA_num_giftBagProp[4])
    if getCallBack ~= nil then
        getCallBack(DATA_num_giftBagProp[1],DATA_num_giftBagProp[2],DATA_num_giftBagProp[3],DATA_num_giftBagProp[4]) 
    end
    self:removeSelf() 
    
end

function giftBag:addLoading(  )
    self.loadings = loading:createGrayloading()
    self:addChild(self.loadings,1)
    loading:createBlendloading(self.loadings,self)
end

function giftBag:countKind()
    if self.entrance ~= nil then
        if self.entrance == Kind_view.loginScene then
            self.countList = DATA_count_loginSceneGiftBag
        end
        if self.entrance == Kind_view.gameScene then
            self.countList = DATA_count_gameSceneGiftBag
        end
        if self.entrance == Kind_view.finallyScene then
            self.countList = DATA_count_finallySceneGiftBag
        end 
        if self.entrance == Kind_view.shops then
            self.countList = DATA_count_loginSceneGiftBag
        end
    end
end

function giftBag:countShop(countEvent)
    if self.entrance ~= nil then 
        DataStat:stat(self.countList[countEvent])
    end
end

return giftBag