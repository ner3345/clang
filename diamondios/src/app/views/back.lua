import("..resource.ImportAllRes")
local shade = import("..effect.shade")
local BubbleButton = import("..views.BubbleButton")

local back = class("back",function() return display.newNode() end)

function back:ctor(backCallBack,restartCallBack,SaveCallBack)

    local grayShade = shade:createGrayShade()
    local bg = display.newSprite(PIC_bg_back)
    bg:setScale(DATA_scale_changeResolution)
    bg:setPosition(display.width/2,display.height/2 - 40)
    local closeButton = display.newSprite(PIC_icon_close2)
    closeButton:setPosition(bg:getContentSize().width - closeButton:getContentSize().width/2,bg:getContentSize().height - closeButton:getContentSize().height/2  )
    closeButton:setTouchEnabled(true)
    closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:removeSelf() end)
    

    local pleaseComeBackText = display.newSprite(PIC_text_pleaseComeBack)
    pleaseComeBackText:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.85+5)
    
    local backHomeButton = display.newSprite(PIC_text_backHome)
    backHomeButton:setPosition(100,65)


    local restartButton = display.newSprite(PIC_text_continueGame)
    restartButton:setPosition(bg:getContentSize().width-100,65)

    backHomeButton:setTouchEnabled(true)
    backHomeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) backCallBack() app:enterLoginScene()  end)
   
    local saveButton = BubbleButton.new({image = PIC_button_continueGame,listener = function (  )
            self:removeSelf()
        end})
    saveButton:setPosition(bg:getContentSize().width/2,bg:getContentSize().height/2)
    restartButton:setTouchEnabled(true)
    restartButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton)  self:removeSelf() end)
    local ok, ret =luaoc.callStaticMethod("AppController", "showAd")
    print(ok,ret)
   -- local menu = ui.newMenu({saveButton})
    bg:addChild(backHomeButton)
    bg:addChild(saveButton)
    bg:addChild(restartButton)
    bg:addChild(pleaseComeBackText)
    bg:addChild(closeButton)
    grayShade:addChild(bg)
    self:addChild(grayShade)
    
end

return back