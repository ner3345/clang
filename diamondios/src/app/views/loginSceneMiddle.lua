import("..resource.ImportAllRes")
local BubbleButton = import("..views.BubbleButton")
local loginSceneMiddle = class("loginSceneMiddle",function() return display.newNode() end)


function loginSceneMiddle:ctor(hasSaveGame,newGameCallBack,loadGameCallBack)
    self:setContentSize(DATA_pic_width,DATA_pic_height* 0.8)
    self:setScale(DATA_scale_changeResolution)
    self:setAnchorPoint(cc.p(0.5, 0.5))

    local crushStartBG = display.newSprite(PIC_bg_crushStart)
    -- crushStartBG:setScale(1.2)
    crushStartBG:setPosition(self:getContentSize().width/2+20,self:getContentSize().height - crushStartBG:getContentSize().height/2)
    -- crushStartBG:setTouchEnabled(true)
    -- crushStartBG:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) print(123) end) 

    local newGameButton = BubbleButton.new({image = PIC_Button_pink,listener = function (  )
        utility:playSound(Music_enterButton) UserData:setResurgenceNum(0) newGameCallBack() app:enterGameScene()
    end})
    :align(display.CENTER,self:getContentSize().width/2,self:getContentSize().height*0.3)
    :addTo(self)

    local newGameText = display.newSprite(PIC_text_newGame)
    newGameText:setPosition(newGameButton:getContentSize().width/2,newGameButton:getContentSize().height/2)
    newGameButton:addChild(newGameText)

    local continueGameButton
    local continueGameText
    local continueGameTextRoad
    local list
    if hasSaveGame == true then 
        continueGameButton = BubbleButton.new({image = PIC_Button_green,listener = function (  )
            UserData:setResurgenceNum(0) loadGameCallBack() app:enterGameScene()
        end})
        continueGameButton:setPosition(self:getContentSize().width/2,self:getContentSize().height*0.15)
        continueGameTextRoad = PIC_text_continueGameGreen
    end

    if hasSaveGame == false then
       continueGameButton = BubbleButton.new({image = PIC_Button_gray,listener = function (  )
            
        end})
        continueGameButton:setPosition(self:getContentSize().width/2,self:getContentSize().height*0.15)
        continueGameTextRoad = PIC_text_continueGameGray
    end

    continueGameText = display.newSprite(continueGameTextRoad)
    continueGameText:setPosition(continueGameButton:getContentSize().width/2,continueGameButton:getContentSize().height/2)
    continueGameButton:addChild(continueGameText)
    self:addChild(continueGameButton)
    self:addChild(crushStartBG)

end


return loginSceneMiddle