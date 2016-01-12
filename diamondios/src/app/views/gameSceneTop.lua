import("..resource.ImportAllRes")

local gameSceneTop = class("gameSceneTop",function() return display.newNode() end)


function gameSceneTop:ctor(parameter,nodeSize,helpCallBack,backCallBack,musicCallBack,soundCallBack)
    
    self:setContentSize(nodeSize)

    local levelInfoBG = display.newScale9Sprite(PIC_bg_levelInfo,0,0, cc.size(display.width,50))
    levelInfoBG:setPosition(self:getContentSize().width/2,0)
    
    local scoreBG = display.newScale9Sprite(PIC_bg_ScoreInfo,0,0,cc.size(250,40))
    scoreBG:setPosition(levelInfoBG:getContentSize().width/2,levelInfoBG:getContentSize().height/2)

    local scoreText  = cc.ui.UILabel.new({text=DATA_text_FS..":  ", 
        color= cc.c3b(255, 255, 255), 
        size=30,
        x = 45,
        y = scoreBG:getContentSize().height/2,
        })
    self.scoreNum = cc.ui.UILabel.new({text= parameter.score, 
        color= cc.c3b(255, 255, 255), 
        size=30,
        })
    self.scoreNum:setAnchorPoint(cc.p(0,0))
    self.scoreNum:setPosition(120,scoreBG:getContentSize().height/2 - self.scoreNum:getContentSize().height/2)

    scoreBG:addChild(scoreText)
    scoreBG:addChild(self.scoreNum,1,1)

    self.levelLabel = cc.ui.UILabel.new({text=DATA_text_GK..":  "..parameter.level, 
        color= cc.c3b(255, 255, 255), 
        size=25,
        x = 80,
        y = levelInfoBG:getContentSize().height/2,
        })
    self.targetScoreLabel = cc.ui.UILabel.new({text=DATA_text_MB..":  "..parameter.targetScore, 
        color= cc.c3b(255, 255, 255), 
        size=25,
        x = levelInfoBG:getContentSize().width - 180,
        y = levelInfoBG:getContentSize().height/2,
        })

    levelInfoBG:addChild(self.targetScoreLabel)
    levelInfoBG:addChild(self.levelLabel)
    levelInfoBG:addChild(scoreBG,1,1)

    local topBG = display.newNode()
    topBG:setContentSize(cc.size(self:getContentSize().width,50))
    topBG:setPosition(0,self:getContentSize().height - 60)

    local maxScoreText = display.newSprite(PIC_sprite_maxScoreText)
    maxScoreText:setPosition(topBG:getContentSize().width/2 - 60,topBG:getContentSize().height/2)
    local backButton = display.newSprite(PIC_icon_back)
    backButton:setPosition(50,topBG:getContentSize().height/2)
    backButton:setScale(1.5)
    backButton:setTouchEnabled(true)
    backButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event)
        utility:playSound(Music_enterButton) backCallBack()
    end)


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

    self.musicButton:setPosition(580,topBG:getContentSize().height/2)
    self.musicButton:setScale(1.5)
    self.musicButton:setTouchEnabled(true)
    self.musicButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:setMusicTouch(musicCallBack,topBG) end) 

    self.soundButton:setPosition(650,topBG:getContentSize().height/2 )
    self.soundButton:setScale(1.5)
    self.soundButton:setTouchEnabled(true)
    self.soundButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:setSoundTouch(soundCallBack,topBG) end) 

    --local helpButton = display.newSprite(PIC_icon_help)
    --helpButton:setPosition(160,topBG:getContentSize().height/2)
    --helpButton:setScale(1.5)
    --helpButton:setTouchEnabled(true)
    --helpButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) helpCallBack() end)

    self.maxScore  = cc.LabelAtlas:_create(parameter.maxScore,PIC_num_yellowItalic, 27, 35, string.byte("0"))
    self.maxScore:setPosition(topBG:getContentSize().width/2+30,7)
    self.maxScore:setTag(10)

    topBG:addChild(self.maxScore)
    topBG:addChild(self.musicButton)
    topBG:addChild(self.soundButton)
    topBG:addChild(backButton)
    topBG:addChild(maxScoreText)
    topBG:setTag(10)

    self:addChild(topBG)
    self:addChild(levelInfoBG,1,1)


    self.setVisibleFalse = 
                    function()
                        self.musicButton:setVisible(false)
                        levelInfoBG:setVisible(false)
                        backButton:setVisible(false)
                        self.soundButton:setVisible(false)
                    end
    self.setVisibleTrue = 
                    function()
                        self.musicButton:setVisible(true)
                        levelInfoBG:setVisible(true)
                        backButton:setVisible(true)
                        self.soundButton:setVisible(true)
                    end
end

function gameSceneTop:updateScore(oldScore,newScore)

    local delayTime = 0

    local setpSize = 1

    local scoreSize = newScore - oldScore
    
    if scoreSize >= 50 then
         setpSize = math.floor(scoreSize/50)
    end

    for i = oldScore , newScore , setpSize do 
        self:performWithDelay( 
                                function()  
                                    self.scoreNum:setString(i)
                                end, 
                                delayTime)
        delayTime = delayTime + DATA_time_scoreShow
    end

    self.scoreNum:setString(newScore)
end

function gameSceneTop:setScore(score)
    self.scoreNum:setString(score)
end

function gameSceneTop:setLevel(level)
    self.levelLabel:setString(DATA_text_GK..":  "..level)
end

function gameSceneTop:setTargetScore(targetScore)
    self.targetScoreLabel:setString(DATA_text_MB..":  "..targetScore)
end

function gameSceneTop:setMaxScore(maxScore)
    self.maxScore:setString(maxScore)
end

function gameSceneTop:setMusicTouch(musicCallBack,topBG)

    self.musicButton:removeSelf()
    musicCallBack()
    if UserData:getIsMusic() == 0 then
        self.musicButton = display.newSprite(PIC_icon_musicOff)
    else 
        self.musicButton = display.newSprite(PIC_icon_music)
    end

    self.musicButton:setPosition(580,topBG:getContentSize().height/2)
    self.musicButton:setScale(1.5)
    self.musicButton:setTouchEnabled(true)
    self.musicButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:setMusicTouch(musicCallBack,topBG) end) 
    topBG:addChild(self.musicButton)
end

function gameSceneTop:setSoundTouch(musicCallBack,topBG)

    self.soundButton:removeSelf()
    musicCallBack()
    if UserData:getIsSound() == 0 then
        self.soundButton = display.newSprite(PIC_icon_soundOff)
    else 
        self.soundButton = display.newSprite(PIC_icon_sound)
    end

    self.soundButton:setPosition(650,topBG:getContentSize().height/2 )
    self.soundButton:setScale(1.5)
    self.soundButton:setTouchEnabled(true)
    self.soundButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:setSoundTouch(musicCallBack,topBG) end) 
    topBG:addChild(self.soundButton)
end

function gameSceneTop:setFalseVisible()
    self.setVisibleFalse()
end

function gameSceneTop:setTrueVisible()
    self.setVisibleTrue()
end
return gameSceneTop