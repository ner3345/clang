import("..resource.ImportAllRes")
local shade = import("..effect.shade")
local utility = import("..sprite.utility")
local notice = class("notice",function() return display.newNode() end)

function notice:ctor(params)
    dump(params)
    local grayShade = shade:createGrayShade()
    local bg = display.newSprite(PIC_bg_notice)
    bg:setScale(DATA_scale_changeResolution)
    bg:setPosition(grayShade:getContentSize().width/2,grayShade:getContentSize().height/2 - 40)

    local closeButton = display.newSprite(PIC_icon_close2)
    closeButton:setPosition(bg:getContentSize().width - closeButton:getContentSize().width/2 -10,bg:getContentSize().height - closeButton:getContentSize().height/2 )
    closeButton:setTouchEnabled(true)
    closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:removeSelf() end)
    
    
    local titleText  = ui.newTTFLabel({text=params[1]["title"], 
        align = ui.TEXT_ALIGN_CENTER,
        valign = ui.TEXT_VALIGN_CENTER,
        dimensions = CCSize(440, 60),
        color= ccc3(255, 255, 0), 
        size=30,
        x = bg:getContentSize().width/2 + 5,
        y = bg:getContentSize().height*0.92,
        })

    local contentText  = ui.newTTFLabel({text=params[1]["content"], 
        align = ui.TEXT_ALIGN_LEFT,
        valign = ui.TEXT_VALIGN_TOP,
        dimensions = CCSize(400, 430),
        color= ccc3(6, 3, 0), 
        size=24,
        x = bg:getContentSize().width/2 -190 ,
        y = bg:getContentSize().height/2 - 40,
        })

    bg:addChild(contentText)
    bg:addChild(titleText)
    bg:addChild(closeButton)
    grayShade:addChild(bg)
    self:addChild(grayShade)
    
end

return notice