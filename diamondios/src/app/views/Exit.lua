import("..resource.ImportAllRes")
local shade = import("..effect.shade")

local exit = class("exit",function() return display.newNode() end)

function exit:ctor(playAgainCallBack)
    local grayShade = shade:createGrayShade()
    local bg = display.newSprite(PIc_bg_exitGame)
    bg:setScale(DATA_scale_changeResolution)
    bg:setPosition(display.width/2,display.height/2 - 40)

    local exitButton = display.newSprite(PIC_button_Exit)
    exitButton:setScale(0.7)
    exitButton:setPosition(bg:getContentSize().width*0.3,bg:getContentSize().height*0.2)
    exitButton:setTouchEnabled(true)
    exitButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) os.exit() end)

    local giftBagSprite = display.newSprite(PIC_icon_exitGiftBag)
    giftBagSprite:setPosition(bg:getContentSize().width/2,bg:getContentSize().height/2)

    local playAgainButton = display.newSprite(PIC_button_playAgain)
    playAgainButton:setScale(0.7)
    playAgainButton:setPosition(bg:getContentSize().width*0.7,bg:getContentSize().height*0.2)
    playAgainButton:setTouchEnabled(true)
    playAgainButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function() utility:playSound(Music_enterButton) UserData:setResurgenceNum(0) playAgainCallBack()  app:enterGameScene() end)


    local apertureEffect = display.newSprite(PIC_icon_aperture)
    apertureEffect:setPosition(bg:getContentSize().width/2,bg:getContentSize().height/2 + 8)

    bg:addChild(apertureEffect)
    bg:addChild(giftBagSprite)
    bg:addChild(playAgainButton)
    bg:addChild(exitButton)
    grayShade:addChild(bg)
    self:addChild(grayShade)
    
end

return exit