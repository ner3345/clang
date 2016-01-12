import("..resource.ImportAllRes")
local shade = import("..effect.shade")

local help = class("help",function() return display.newNode() end)

function help:ctor()

    local grayShade = shade:createGrayShade()
    
    local bg = display.newSprite(PIC_bg_help)
    bg:setPosition(display.width/2,display.height/2 - 40)
    bg:setScale(1.5)

    -- local title = display.newSprite(PIC_title_help)
    -- title:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.915)
    -- bg:addChild(title)

    local closeButton = display.newSprite(PIC_icon_close2)
    closeButton:setPosition(bg:getContentSize().width - closeButton:getContentSize().width/2 - 5,bg:getContentSize().height - closeButton:getContentSize().height/2 -5 )
    
    closeButton:setTouchEnabled(true)
    closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:removeSelf() end)
    
    local content = display.newSprite(PIC_text_crushStarAward)
    content:setPosition(bg:getContentSize().width/2+10,bg:getContentSize().height*0.45)

    bg:addChild(content)
    bg:addChild(closeButton)
    grayShade:addChild(bg)
    self:addChild(grayShade)
end

return help