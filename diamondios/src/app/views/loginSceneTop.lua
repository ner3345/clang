import("..resource.ImportAllRes")

local loginSceneTop = class("loginSceneTop",function() return display.newNode() end)


function loginSceneTop:ctor(maxScore,helpCallBack,musicCallBack,soundCallBack)

    self:setContentSize(DATA_pic_width*DATA_scale_changeResolution,80)
    self:setAnchorPoint(cc.p(0.5, 0.5))

    
    if UserData:getIsMusic() == 0 then
        self.musicButton = display.newSprite(PIC_icon_musicOff)
    else 
        self.musicButton = display.newSprite(PIC_icon_music)
    end

    if UserData:getIsSound() == 0 then
        self.soundButton = display.newSprite(PIC_icon_soundOff)
    else 
        self.soundButton = display.newSprite(PIC_icon_sound)
    end

    self.musicButton:setPosition(580,self:getContentSize().height/2 )
    self.musicButton:setScale(1.5)
    self.musicButton:setTouchEnabled(true)
    self.musicButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:setMusicTouch(musicCallBack) end) 

    self.soundButton:setPosition(650,self:getContentSize().height/2 )
    self.soundButton:setScale(1.5)
    self.soundButton:setTouchEnabled(true)
    self.soundButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:setSoundTouch(soundCallBack) end) 

    local helpButton = display.newSprite(PIC_icon_help)
    helpButton:setPosition(80,self:getContentSize().height/2)
    helpButton:setScale(1.5)
    helpButton:setTouchEnabled(true)
    helpButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) helpCallBack() end)
    

    local maxScoreText = display.newSprite(PIC_sprite_maxScoreText)
    maxScoreText:setPosition(self:getContentSize().width*0.38,self:getContentSize().height/2 -2 )

    local maxScoreNum  = cc.LabelAtlas:_create(maxScore,PIC_num_yellowItalic, 27, 35, string.byte("0"))
    maxScoreNum:setPosition(self:getContentSize().width*0.51,self:getContentSize().height/2 - 20 )

    

    self:addChild(self.musicButton)
    self:addChild(maxScoreNum)
    self:addChild(helpButton)
    self:addChild(maxScoreText)
    self:addChild(self.soundButton)

end

function loginSceneTop:setMusicTouch(musicCallBack)

    self.musicButton:removeSelf()
    musicCallBack()
    if UserData:getIsMusic() == 0 then
        self.musicButton = display.newSprite(PIC_icon_musicOff)
    else 
        self.musicButton = display.newSprite(PIC_icon_music)
    end

    self.musicButton:setPosition(580,self:getContentSize().height/2 )
    self.musicButton:setScale(1.5)
    self.musicButton:setTouchEnabled(true)
    self.musicButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:setMusicTouch(musicCallBack) end) 
    self:addChild(self.musicButton)
end

function loginSceneTop:setSoundTouch(musicCallBack)

    self.soundButton:removeSelf()
    musicCallBack()
    if UserData:getIsSound() == 0 then
        self.soundButton = display.newSprite(PIC_icon_soundOff)
    else 
        self.soundButton = display.newSprite(PIC_icon_sound)
    end

    self.soundButton:setPosition(650,self:getContentSize().height/2 )
    self.soundButton:setScale(1.5)
    self.soundButton:setTouchEnabled(true)
    self.soundButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:setSoundTouch(musicCallBack) end) 
    self:addChild(self.soundButton)
end

return loginSceneTop