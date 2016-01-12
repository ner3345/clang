import("..resource.ImportAllRes")
local shade = import("..effect.shade")

local update = class("update",function() return display.newNode() end)

function update:ctor(getCallBack,closeCallBack)
 
    
    local grayShade = shade:createGrayShade()
    local bg = display.newSprite(PIC_pic_updatebg)
    bg:setScale(DATA_scale_changeResolution)
    bg:setPosition(grayShade:getContentSize().width/2,grayShade:getContentSize().height/2 - 40)
    bg:setTag(1000)
    local closeButton = display.newSprite(PIC_icon_close2)
    closeButton:setPosition(bg:getContentSize().width - closeButton:getContentSize().width/2 -10,bg:getContentSize().height - closeButton:getContentSize().height/2 -10 )
    closeButton:setTouchEnabled(true)
    closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:removeSelf() end)
    
    local contentBg = display.newSprite(PIC_pic_updateText)
    contentBg:setPosition(bg:getContentSize().width/2,bg:getContentSize().height/2 + 145)

    local getButton = display.newSprite(PIC_pic_updateButton)
    getButton:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.3)
    getButton:setTouchEnabled(true)
    getButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
                                                function(event) 
                                                    self:gotGiftBag(getCallBack)
                                                    end)

    bg:addChild(contentBg)
    bg:addChild(getButton)
    bg:addChild(closeButton)
    grayShade:addChild(bg)
    grayShade:setTag(1000)
    self:addChild(grayShade)

end

function update:gotGiftBag(getCallBack)

    utility:playSound(Music_enterButton) 
    if getCallBack ~= nil then
        getCallBack() 
    end
    self:removeSelf() 
    
end


return update