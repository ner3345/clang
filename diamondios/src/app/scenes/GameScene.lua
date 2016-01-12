local matrix = import("..views.matrix")
local star = import("..sprite.star")
local partical = import("..effect.partical")
local move = import("..effect.move")
local scheduler = require("framework.scheduler")
local partical = import("..effect.partical")
local gameSceneTop = import("..views.gameSceneTop")
local resurgence = import("..views.resurgence")
local finallyScore = import("..views.finallyScore")
local gameSceneBottom = import("..views.gameSceneBottom")
local shade = import("..effect.shade")
local help =import("..views.help")
local back =import("..views.back")
local MobileMMSdk = import("..SDK.MobileMM")
local passReward = import("..views.PassReward")
local processBar = import("..views.processBar")
local statistics = import("..Business.statistics")
local marquee = import("..effect.marquee")
local statistics = import("..Business.statistics")
local giftBag = import("..views.giftBag")
local shop = import("..views.shop")


import("..resource.Music")
import("..resource.ImportAllRes")

local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

matrixRow = DATA_matrix_row
matrixCol = DATA_matrix_col

function GameScene:ctor()
    self.shieldingClickShade = display.newColorLayer(cc.c4b(0,0,0,0))
    self.shieldingClickShade:setTouchEnabled(true)
    self.shieldingClickShade:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) self:addDiamondView(event) end)
    self:addChild(self.shieldingClickShade,50)
    self:setKeypadEnabled(true)

    self.touchTimeReset = display.newColorLayer(cc.c4b(0,0,0,0))
    self.touchTimeReset:setTouchEnabled(true)
    self.touchTimeReset:setTouchSwallowEnabled(false)
    self.touchTimeReset:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
                                                function(event) 
                                                    self:touchTimeGuidEnd() 
                                                end)
    self:addChild(self.touchTimeReset,10000)

    self:init()

    self:addNodeEventListener(cc.KEYPAD_EVENT, function(event)
        if event.key == "back" then
            if self:getChildByTag(10000) == nil then
                self:addChild(
                            back.new(   
                                        function() 
                                            utility:saveGame(self.matrixGuid,self.level,self.curScore,self.oldProcessEnergy)  
                                        end 
                                        ,function() 
                                            self:restartLevel(Enum_state_level.firstLevel) 
                                        end 
                                        , function() 
                                            utility:saveGame(self.matrixGuid,self.level,self.curScore,self.oldProcessEnergy) 
                                            CCDirector:sharedDirector():endToLua() 
                                            end )
                                        ,100
                                        ,10000
                                        )
            end
        end
    end)

end

function GameScene:init()
    print("init start")
    local parameter = utility:ReadGame()
    print("ReadGame end")
    UserData:setScore(parameter.score)
    UserData:setLevel(parameter.level)
    UserData:setProcessEnergy(parameter.processEnergy)
    self.isMusic = UserData:getIsMusic()
    self.curScore = UserData:getScore()
    self.level = UserData:getLevel()
    self.maxScore = UserData:getMaxScore()
    self.oldProcessEnergy  = UserData:getProcessEnergy()
    self.prevProcessEnergy = self.oldProcessEnergy
    self.prevScore = self.curScore

    print("initData start")
    self:initData()
    print("initData end")
    local bg = display.newSprite(PIC_bg_sceneBG)
    bg:setPosition(display.cx,display.cy)

    self.node = display.newNode()

    local nodeSize = cc.size(display.width, 100)
    local params = {score = self.curScore,level = self.level,maxScore = self.maxScore,targetScore = self.targetScore}
    self.top = gameSceneTop.new(params,nodeSize,function() self:addChild(help.new()) end,function() self:addChild(back.new( function() utility:saveGame(self.matrixGuid,self.level,self.curScore,self.oldProcessEnergy)  end ,function() self:restartLevel(Enum_state_level.firstLevel) end , function() utility:saveGame(self.matrixGuid,self.level,self.curScore,self.oldProcessEnergy) CCDirector:sharedDirector():endToLua() end),100,10000) end,function() self:musicCallBack() end,function() self:soundCallBack() end )
    self.top:setPosition(0,display.height - 130)
    
    self.bottom = gameSceneBottom.new(UserData:getDiamondNum(),UserData:getMagicNum(),UserData:getRefreshNum(),UserData:getBombNum(),
        function(isMagic,color) self:userMagicCallBack(isMagic,color) end,nil,function() self:userRefreshCallBack() end,
        function ( isBomb ) self:userBombCallBack(isBomb) end)
    self.bottom:setPosition(display.cx,self.bottom:getContentSize().height/2)
    
    self:addChild(bg)
    self:addChild(self.top)
    self:addChild(self.bottom,10)
    
    self:reportLevelInfo(function(parameter) self:reportLevelInfoCallBack(parameter) end,parameter.matrixGuid)
    local ok, ret =luaoc.callStaticMethod("AppController", "hideAd")
    print(ok,ret)

end

function GameScene:reportLevelInfoCallBack(parameter)
    self.matrixGuid = self:createSpriteMatrix(parameter)
    
    self.oldMatrixGuid = clone(self.matrixGuid)
    self.gameMatrix = matrix.new()
    self.gameMatrix:init(self.matrixGuid) 
    self.gameMatrix:setPosition(display.cx - self.gameMatrix:getContentSize().width/2,140)
    self.gameMatrix:setTouchEnabled(true)

    self.gameMatrix:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) self:onTouchPositionJurge(event) end)
    self:setShieldingClick(true)
    self:processBar()
    -- self:performWithDelay( 
    --         function()  
    --             self:gameGuid()
    --         end, 
    -- 0.8)

     self:performWithDelay( 
            function()  
               self.gameMatrix:setTouchEnabled(true)
            end, 
    0.5)

    self:scheduleUpdate()
    self:performWithDelay( 
                        function()  
                                self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
                                    self:setShieldingClick(false)

                                    self.processBarViews:setVisible(true)

                                    if  self.isCrushOver == true then 
                                            self.processBarViews:setVisible(false)
                                            if self.passLevel ~= nil then 
                                            self.passLevel:removeSelf()
                                            self.passLevel = nil
                                            end
                                    end

                                    if self.isBalancing == true or self.isCrushing == true or self.isMoving.state == true or self.isUseHeartEnergy == true then 
                                        self:setShieldingClick(true)  
                                    end

                                    if self.isRefresh == false and self.isBalancing == false and self.isCrushing == false and self.isMoving.state == false and self.isUseHeartEnergy == false then 
                                        if self.oldProcessEnergy >= 100 then
                                            self:processBarEvent()
                                        end
                                    end

                                    self:gameProcess()
                                    
                                end)
                            end, 
                            0.5)
    
    self:addChild(self.gameMatrix)

    local updateResidueTime = function()
        self.curTouchTime = self.curTouchTime + 1
        if self.curTouchTime == 5 then 
            self:touchTimeGuid()
        end
    end

    self.residueTimehandle = scheduler.scheduleGlobal(handler(self,updateResidueTime), 1.0)                            
end

function GameScene:initData()
    self.isCrushing = false
    self.isMoving = {state = false}
    self.isCrushOver = false
    self.isResurgence = false
    self.isBalancing = false 
    self.isMagic = false
    self.isBomb = false
    self.magicColor = nil
    self.isShieldingClick = false
    self.isUseHeartEnergy = false
    self.curTouchTime = 0
    self.isRefresh = false
    self.isReportLevel = false
    self.touchTimeSpriteList = {}
    self:initDataFromLevel(self.level)

end

function GameScene:initDataFromLevel(level)
    if self.level > DATA_num_maxLevel then
        self.targetScore = DATA_score_passLevel[DATA_num_maxLevel] + 4000*(self.level - DATA_num_maxLevel)
        return
    end
    self.targetScore = DATA_score_passLevel[level]
end

function GameScene:createSpriteMatrix(colorMatrixGuid)
    local matrixGuid = {}
    if colorMatrixGuid == nil then 
        math.randomseed(os.time())
        for i=1 , DATA_matrix_row do 
            matrixGuid[i] = {}
            for j =1,DATA_matrix_col do 
                local randomColor = math.random(1,DATA_pic_kind)
                local randomStar = star.new(randomColor)
                matrixGuid[i][j] = randomStar
            end
        end
    end
    if colorMatrixGuid ~= nil then 
        for i = 1 ,DATA_matrix_row do 
            matrixGuid[i] = {}
            if colorMatrixGuid[i] ~= nil then 
                for j = 1 ,DATA_matrix_col do 
                    if colorMatrixGuid[i][j] ~= nil then 
                        matrixGuid[i][j] = star.new(colorMatrixGuid[i][j])
                    end
                end
            end
        end
    end
    return matrixGuid
end

function GameScene:createSpriteMatrixByAssign(matrixGuid)
    for i=1 , matrixRow do 
        if matrixGuid[i] ~= nil then
            for j =1, matrixCol do 
                if matrixGuid[i][j] ~= nil then
                    local randomStar = star.new(matrixGuid[i][j])
                    matrixGuid[i][j] = randomStar
                end
            end
        end
    end
end

function GameScene:findCrushSprite(row,col,matrixGuid,m,n)
    
    if matrixGuid[row]==nil or matrixGuid[row][col] == nil then 
        return nil
    end

    local ans = {}
    for i = 0 , m do 
        ans[i] = {}
    end
    
    local xIncrement = {0,1,0,-1}
    local yIncrement = {1,0,-1,0}
    
    local count = 1
    ans[row][col] = 1
    local queueStart = 1

    local queue = {matrixGuid[row][col]}

    while(queue[queueStart]~=nil)
    do
        for i = 1 , #xIncrement do
            local matrixP = self.gameMatrix:gamePToMatrixP(queue[queueStart]:getPositionX(),queue[queueStart]:getPositionY())
            local x = matrixP.row + xIncrement[i]
            local y = matrixP.col + yIncrement[i]
            if x > 0 and x <= m and y>0 and y<= n then
                if matrixGuid[x] ~=nil then
                    if matrixGuid[x][y] ~= nil and ans[x][y]~= 1 then 
                        if self:jurgeIsTheSame(matrixGuid[x][y],queue[queueStart]) then
                            queue[#queue+1] = matrixGuid[x][y]
                            ans[x][y] = 1
                            count = count + 1
                        end
                    end
                end
            end
        end
        queueStart = queueStart + 1
    end

    if count > 1 then
        ans[0][0] = count
        return ans  
    else 
        return nil 
    end
end

function GameScene:jurgeIsTheSame(sprite1,sprite2)

    if sprite1:getColor() == sprite2:getColor() then
        return true
    else
        return false 
    end

end

function GameScene:starCrushPartical(sprite)
    
    utility:playSound(Music_pop)
    local a = partical:createStarPartical(sprite)
    a:setPosition(self:getSpriteWorldP(sprite))
    self:addChild(a)
    local b = partical:createStarPartical2(sprite)
    b:setPosition(self:getSpriteWorldP(sprite))
    self:addChild(b)

end

function GameScene:BombstarCrushPartical(sprite)
    local a = partical:createStarPartical(sprite)
    a:setPosition(self:getSpriteWorldP(sprite))
    self:addChild(a)

end

function GameScene:RemoveSprite(crushSprite,curshOverCallBack)

    if crushSprite == nil then 
        return
    end
    self.isCrushing = true
    local delayTime = 0
    local count = crushSprite[0][0]
    local onNum = 1

    local incrementScore = crushSprite[0][0]^2*DATA_score_crushBase 


    if self:getChildByTag(654) ~= nil then 
        self:getChildByTag(654):removeSelf()
    end
    local crushScoreText  = cc.ui.UILabel.new({text=math.sqrt(incrementScore/5)..DATA_text_LX.." "..incrementScore..DATA_text_F, 
        color= cc.c3b(255, 255, 255), 
        size=50,
        })
    crushScoreText:setAnchorPoint(0.5,0.5)
    crushScoreText:setPosition((display.width )/2,display.height/2 + 300)
    crushScoreText:setTag(654)
    self:addChild(crushScoreText)

    local sequence = transition.sequence({
            cc.DelayTime:create(2),
            cc.CallFunc:create(function() crushScoreText:removeSelf() end),
        })
    crushScoreText:runAction(sequence)

    --self:performWithDelay( function()
    --                                if crushScoreText ~= nil then 
    --                                    crushScoreText:removeSelf()
    --                                    crushScoreText = nil
    --                                end
    --                            end,2)


    for i = 1,matrixRow do 
        if crushSprite[i] ~= nil then
            for j = matrixCol, 1 , -1 do 
                if crushSprite[i][j] == 1 then
                    self.matrixGuid[i][j]:changeStarColor(self.matrixGuid[i][j]:getColor()*10)
                    self:performWithDelay( 
                                    function()
                                        self:starCrushPartical(self.matrixGuid[i][j]) 
                                        self:updateScoreEffect(onNum,self.matrixGuid[i][j])
                                        self.matrixGuid[i][j]:crush()   
                                        self.matrixGuid[i][j] = nil  
                                        onNum = onNum + 1
                                        count = count - 1
                                        if count == 0 then 
                                            self.isCrushing = false
                                            if curshOverCallBack ~= nil then 
                                                self:performWithDelay( function() curshOverCallBack() end,0.5)
                                            end
                                            self:compactMatrix()
                                            self:updateMatrix()
                                            self:updateProcessEnergy(incrementScore)
                                        end
                                    end, 
                                    delayTime)
                    delayTime = delayTime + DATA_time_crushStar

                end
            end
        end
    end

    if crushSprite[0][0] >= 5 then

        math.randomseed(os.time())
        local random = math.random(1, #PIC_text_Copywriter)
        local copyWriter = display.newSprite(PIC_text_Copywriter[random])
        copyWriter:setScale( 2 )
        utility:playSound(Music_list_special[random])

        local sequence = transition.sequence({
        cc.ScaleTo:create(0.08,1.9),
        cc.ScaleTo:create(0.08,2.1),
        cc.ScaleTo:create(0.08,1.8),
        cc.ScaleTo:create(0.08,2.2),
        cc.ScaleTo:create(0.5,1),
        })
        copyWriter:runAction(sequence)

        --local sequence = transition.sequence({
        --    cc.ScaleTo:create(0.5, 1,1),
        --    })
        --copyWriter:runAction(sequence); 

        copyWriter:setPosition(display.cx,display.height - 260)
        self:addChild(copyWriter,51)
        self:performWithDelay( 
                                function()  
                                    copyWriter:removeSelf()
                                    copyWriter = nil
                                end, 
                                DATA_time_crushStar*crushSprite[0][0])
    end

    self:updateScore(incrementScore)
end

function GameScene:removeBombSprite(crushSprite,curshOverCallBack)

    if crushSprite == nil then 
        return
    end
    self.isCrushing = true
    local delayTime = 0
    local count = crushSprite[0][0]
    local onNum = 1

    local incrementScore = crushSprite[0][0]^2*DATA_score_crushBase 


    if self:getChildByTag(654) ~= nil then 
        self:getChildByTag(654):removeSelf()
    end
    local crushScoreText  = cc.ui.UILabel.new({text=math.sqrt(incrementScore/5)..DATA_text_LX.." "..incrementScore..DATA_text_F, 
        color= cc.c3b(255, 255, 255), 
        size=50,
        })
    crushScoreText:setAnchorPoint(0.5,0.5)
    crushScoreText:setPosition((display.width )/2,display.height/2 + 260)
    crushScoreText:setTag(654)
    self:addChild(crushScoreText)

    local sequence = transition.sequence({
            cc.DelayTime:create(2),
            cc.CallFunc:create(function() crushScoreText:removeSelf() end),
        })
    crushScoreText:runAction(sequence)


    for i = 1,matrixRow do 
        if crushSprite[i] ~= nil then
            for j = matrixCol, 1 , -1 do 
                if crushSprite[i][j] == 1 then
                    self.matrixGuid[i][j]:changeStarColor(self.matrixGuid[i][j]:getColor()*10)
                    self:performWithDelay( 
                                    function() 
                                        self:BombstarCrushPartical(self.matrixGuid[i][j],true) 
                                        self:updateScoreEffect(onNum,self.matrixGuid[i][j])
                                        self.matrixGuid[i][j]:crush()   
                                        self.matrixGuid[i][j] = nil  
                                        onNum = onNum + 1
                                        count = count - 1
                                        if count == 0 then 
                                            self.isCrushing = false
                                            if curshOverCallBack ~= nil then 
                                                self:performWithDelay( function() curshOverCallBack() end,0.5)
                                            end
                                            self:compactMatrix()
                                            self:updateMatrix()
                                            self:updateProcessEnergy(incrementScore)
                                        end
                                    end, 
                                    delayTime)

                end
            end
        end
    end

    if crushSprite[0][0] >= 5 then

        math.randomseed(os.time())
        local random = math.random(1, #PIC_text_Copywriter)
        local copyWriter = display.newSprite(PIC_text_Copywriter[random])
        copyWriter:setScale( 2 )
        utility:playSound(Music_list_special[random])

        local sequence = transition.sequence({
        cc.ScaleTo:create(0.08,1.9),
        cc.ScaleTo:create(0.08,2.1),
        cc.ScaleTo:create(0.08,1.8),
        cc.ScaleTo:create(0.08,2.2),
        cc.ScaleTo:create(0.5,1),
        })
        copyWriter:runAction(sequence)

        --local sequence = transition.sequence({
        --    cc.ScaleTo:create(0.5, 1,1),
        --    })
        --copyWriter:runAction(sequence); 

        copyWriter:setPosition(display.cx,display.height - 260)
        self:addChild(copyWriter,51)
        self:performWithDelay( 
                                function()  
                                    copyWriter:removeSelf()
                                    copyWriter = nil
                                end, 
                                DATA_time_crushStar*crushSprite[0][0])
    end

    self:updateScore(incrementScore)
end

function GameScene:compactMatrix()

    for i = 1 , matrixRow do 
        if self.matrixGuid[i] ~= nil then
            local rowIsNil = true
            for j = 1 ,matrixCol do  
                if self.matrixGuid[i][j] ~= nil then 
                    rowIsNil = false
                    break
                end
            end
            if rowIsNil then
                self.matrixGuid[i] = nil
            end
        end
    end


    local count = 0
    for i = 1 , matrixRow do 
        if self.matrixGuid[i] ~= nil then 
            count = count + 1
            self.matrixGuid[count] = self.matrixGuid[i]
        end
    end

    for i = count + 1, matrixRow do 
        self.matrixGuid[i] = nil
    end


    for i = 1 , matrixRow do 
        if self.matrixGuid[i] ~= nil then 
            count = 0
            for j = 1 , matrixCol do 
                if self.matrixGuid[i][j] ~= nil then 
                    count = count + 1
                    self.matrixGuid[i][count] = self.matrixGuid[i][j]
                end
            end
            for j = count + 1 ,matrixCol do 
                self.matrixGuid[i][j] = nil
            end
        end
    end
end

function GameScene:updateMatrix()

    self.isMoving.state = true
    self.gameMatrix:updateMatrix(self.oldMatrixGuid,self.matrixGuid,self.isMoving)
    self.oldMatrixGuid = clone(self.matrixGuid)

end

function GameScene:onEnter()
end

function GameScene:onExit()
    print("exit")
    if self.residueTimehandle ~= nil then
        scheduler.unscheduleGlobal(self.residueTimehandle)
    end
end

function GameScene:onTouchPositionJurge(event)
    -- dump(event)
    -- dump(event.x)
    -- if UserData:getIsFirstGuid() ~= 1 then
    --     return 
    -- end
    local x = event.x
    local y = event.y
    local gameMatrixLocalPosition = self.gameMatrix:convertToNodeSpace(cc.p(x, y))

    local matrixXMin = self.gameMatrix:getPositionX()
    local matrixXMax = self.gameMatrix:getPositionX() + self.gameMatrix:getWidth()
    local matrixYMin = self.gameMatrix:getPositionY() 
    local matrixYMax = self.gameMatrix:getPositionY() + self.gameMatrix:getHeight()

    if x > matrixXMin and x<matrixXMax and y > matrixYMin and y < matrixYMax then
        self:onTouchMatrix(self:getSpriteRC(gameMatrixLocalPosition.x,gameMatrixLocalPosition.y))
    end
end

function GameScene:onTouchMatrix(matrixP,callBack)
    if self.isRefresh == true then
        return 
    end
    self.bottom:stopPopBomb()
    if self.isMagic == true then
        if self.magicColor ~= self.matrixGuid[matrixP.row][matrixP.col]:getColor() then 
            self.matrixGuid[matrixP.row][matrixP.col]:changeStarColor(self.magicColor)
            utility:playSound(Music_heartDown)
            marquee:createMarquee(self.matrixGuid[matrixP.row][matrixP.col])
            self.isMagic = false
            self.bottom:removeMagicPropBG()
            if UserData:getMagicNum() <=0 then
                self.bottom:setPropNum(-DATA_magic_cost,nil,nil)
            else
                self.bottom:setPropNum(nil,-1,nil)
            end
        end
        return
    end

        --是否使用炸弹
    if self.isBomb == true then
        if self:Detonate(matrixP.row,matrixP.col,callBack) then
            utility:playSound(Music_bomb)
            if UserData:getBombNum() <=0 then
                self.bottom:setPropNum(-5, nil, nil,nil)
            else
                self.bottom:setPropNum(nil, nil, nil,-1)
            end
            return
        end
    end

    if self.isCrushing == true or self.isMoving.state == true or self.matrixGuid[matrixP.row]==nil or self.matrixGuid[matrixP.row][matrixP.col] == nil then 
        return 
    end
    local crushSprite = self:findCrushSprite(matrixP.row,matrixP.col,self.matrixGuid,matrixRow,matrixCol)
    
    self:RemoveSprite(crushSprite,callBack)
    
end

--查找爆破的Ｓprite
function GameScene:Detonate( x,y,callBack)
    if self.matrixGuid[x][y] == nil then
        self.bottom:removeBombText()
        self.isBomb = false
        return false
    end
    local xPos = {0,1,0,1,1,0,-1,-1,-1}
    local yPos = {0,0,1,1,-1,-1,0,1,-1}
    local count = 0
    local bombList = {}
    for i=0,10 do
        bombList[i]={}
    end

    for i=1,#xPos do
        if self.matrixGuid[x+xPos[i]] ~= nil then
            if self.matrixGuid[x+xPos[i]][y+yPos[i]] ~= nil then
                bombList[x+xPos[i]][y+yPos[i]] = 1
                count = count + 1
            end
        end
    end
    bombList[0][0]=count
    self.bottom:removeBombText()
    self.isBomb = false
    self:bombpop(x,y)
    self:removeBombSprite(bombList,callBack)
    return true
end

function GameScene:bombpop( x,y )
    local s = self.gameMatrix:matrixPToGameP(x,y)
    local scene = display.getRunningScene()
        display.addSpriteFrames("Bomb/bomb.plist", "Bomb/bomb.png")
        local frames = display.newFrames("bomb%02d.png", 1, 5)
        local animation = display.newAnimation(frames, 0.5 / 5) -- 0.5s play 20 frames
        local bombSprite = display.newSprite(frames[1])
        bombSprite:setPosition(s.x,s.y+130)
        bombSprite:playAnimationOnce(animation,true)
        bombSprite:setScale(1)
        scene:addChild(bombSprite)
end

function GameScene:getSpriteRC(x,y)

    return self.gameMatrix:gamePToMatrixP( x,y )

end

function GameScene:getSpriteWorldP(sprite)
    local point = sprite:convertToWorldSpace(cc.p(0,0))
    point.x = sprite:getContentSize().width/2 + point.x
    point.y = sprite:getContentSize().height/2 + point.y
    return cc.p(point)
end

function GameScene:updateScore(incrementScore)
    self.top:updateScore(self.curScore,self.curScore+incrementScore)
    self.curScore = self.curScore + incrementScore

    if self.curScore > self.maxScore then 
        self.maxScore = self.curScore
        self.top:setMaxScore(self.maxScore)
        UserData:setMaxScore(self.maxScore)
    end

    if self.curScore >= self.targetScore and self.passLevel==nil then 
        utility:playSound(Music_congratelationPassLevel)

        self.passLevel = display.newSprite(PIC_icon_congratulationPassLevel)
        self.passLevel:align(display.CENTER,display.cx,display.cy+100)
        self:addChild(self.passLevel)

        self.passLevel:setScale(1.8)
        local sequence = transition.sequence({
        cc.ScaleTo:create(0.5,1.8),
        cc.ScaleTo:create(0.05,1.7),
        cc.ScaleTo:create(0.05,1.9),
        cc.ScaleTo:create(0.05,1.7),
        cc.ScaleTo:create(0.05,1.9),
        cc.CallFunc:create(function()
            self.passLevel:runAction(cc.ScaleTo:create(0.5,0.8))
            self.passLevel:runAction(cc.MoveTo:create(0.5, cc.p(display.cx + 250, display.cy + 400)))
        end)
        })
        self.passLevel:runAction(sequence)

        local delayTime = 1
        math.randomseed(os.time())
        for i=1 ,DATA_count_fireWork do
            self:performWithDelay( function()
                                            local a = partical:createCakesPartical()
                                            local x = 0
                                            local y = 872
                                            local xIncrementer = math.random(1,720)
                                            local yIncrementer = math.random(1,408)
                                            x = xIncrementer + x
                                            y = yIncrementer + y
                                            a:setPosition(x,y)
                                            self:addChild(a,10000) 
                                        end,delayTime)
            delayTime = delayTime + 0.3
        end

    end
    self:gameProcess()
end

function GameScene:updateScoreEffect(onNum,sprite)
    
    local singleStarScore = onNum^2*DATA_score_crushBase
    --print(singleStarScore)
    local picScore = cc.LabelAtlas:_create(singleStarScore,PIC_num_yellowItalic, 27, 35, string.byte("0"))
    picScore:setScale(1)
    picScore:setTag(100)
    picScore:setPosition(self:getSpriteWorldP(sprite))
    self:addChild(picScore)

    local scoreShow = self.top:getChildByTag(1):getChildByTag(1):getChildByTag(1)

    local endPoint = self:getSpriteWorldP(scoreShow)
    endPoint.x = endPoint.x -30
    endPoint.y = endPoint.y -15

    local picScoreMove = move:createScoreMove(picScore, cc.p(endPoint))
    transition.execute(picScore, picScoreMove , {
        onComplete = function()
            local temp = self:getChildByTag(100)
            temp:removeSelf()
            temp = nil
        end,
        })

end

function GameScene:jurgeCrushState()
    
    for i=1 , matrixRow do 
        if self.matrixGuid[i] ~= nil then
            for j=1 , matrixCol do 
                if self.matrixGuid[i][j] ~= nil then
                    local crushSprite = self:findCrushSprite(i,j,self.matrixGuid,matrixRow,matrixCol)
                    if crushSprite ~= nil and crushSprite[0][0] >= 2 then 
                        self.isBalancing = false
                        return Enum_state_cursh.ableCrush
                    end
                end
            end
        end
    end 

    return Enum_state_cursh.unalbeCrush
end

function GameScene:jurgeGameState()
    
    if self.curScore >= self.targetScore then  
        return Enum_state_game.pass
    else return Enum_state_game.gameOver end

end
    
function GameScene:restartLevel(levelState)
    if levelState == Enum_state_level.nextLevel then
        self.level = self.level + 1
        self.prevScore = self.curScore
        self.prevProcessEnergy = self.oldProcessEnergy
        self:initDataFromLevel(self.level)
    end

    if levelState == Enum_state_level.prevLevel  then
        self.level = self.level 
        self.curScore= self.prevScore 
        self.oldProcessEnergy = self.prevProcessEnergy
        self.processBarViews:setPercentage(self.oldProcessEnergy)
        self:initDataFromLevel(self.level)
    end

    if levelState == Enum_state_level.firstLevel then
        
        self.oldProcessEnergy = 0
        self.prevProcessEnergy = 0
        self.processBarViews:setPercentage(self.oldProcessEnergy)
        self.level = 1
        self.curScore= 0
        self.prevScore = self.curScore 
        self.oldProcessEnergy = 0
        self:initDataFromLevel(self.level)
    end

    self:initData()
    
    local reportLevelInfoCallBack = function()
        self.top:setTargetScore(self.targetScore)
        self.top:setScore(self.curScore)
        self.top:setLevel(self.level)
        self.matrixGuid = self:createSpriteMatrix(nil)
        self.oldMatrixGuid = clone(self.matrixGuid)
        self.gameMatrix:removeAllSprite()
        self.gameMatrix:init(self.matrixGuid)
    end

    self:reportLevelInfo(reportLevelInfoCallBack)
end

function GameScene:gameOver()
    
    if UserData:getResurgenceNum() == 0 then
        DataStat:stat(DATA_count_gameOver[1])
    elseif UserData:getResurgenceNum() == 1 then 
        DataStat:stat(DATA_count_gameOver[2])
    elseif UserData:getResurgenceNum() >= 2 then
        DataStat:stat(DATA_count_gameOver[3])
    end
    
    local resurgenceView = resurgence.new(
        Enum_state_netWork.on,
        false,
        function() self:resurgenceColseCallBack() end,
        function() self:resurgenceCallBack() end,
        nil,
        self.bottom) 

    resurgenceView:setPosition(display.cx ,display.cy - 100)
    self:addChild(resurgenceView,100)
  
end

function GameScene:resurgenceCallBack()
    self.top:setTrueVisible()
    self:restartLevel(Enum_state_level.prevLevel) 
end

function GameScene:cleanling()

    local residueStar = 0
    for i = 1 , matrixRow do 
        if self.matrixGuid[i] ~= nil then 
            for j=1,matrixCol do 
                if self.matrixGuid[i][j] ~=nil then 
                    residueStar = residueStar + 1
                end
            end
        end
    end
    local incrementScore = 0
    if residueStar<= 9 then 
        incrementScore = DATA_score_residueStar[residueStar + 1]
        self:updateScore(incrementScore)  
    end

    local delayTime = 0
    local crushCount = self:countMatrixResidue(self.matrixGuid,matrixRow,matrixCol)
    local residueStar = crushCount

    if residueStar == 0 then 
        self.isCrushOver = true
        self:showResidueAward(residueStar)
        return
    end

    if self.matrixGuid ~=nil then 
        for i = 1 , matrixRow do 
            if self.matrixGuid[i] ~= nil then 
                for j=matrixCol,1,-1 do 
                    if self.matrixGuid[i][j] ~=nil then 
                        self:performWithDelay( 
                                        function()  
                                            crushCount = crushCount - 1
                                            self:starCrushPartical(self.matrixGuid[i][j]) 
                                            self.matrixGuid[i][j]:crush()   
                                            self.matrixGuid[i][j] = nil  
                                            if crushCount == 0 then 
                                                self.isCrushOver = true
                                                self:showResidueAward(residueStar)
                                            end
                                        end, 
                                        delayTime)
                        delayTime = delayTime + 0.1
                    end
                end
            end
        end
    end
    
end

function GameScene:showResidueAward(residueStar)

    local residueStarText  = cc.ui.UILabel.new({text=DATA_text_SY..residueStar..DATA_text_XXXC, 
        color= cc.c3b(b255, 255, 255), 
        size=50,
        })
    residueStarText:setAnchorPoint(0.5,0.5)
    residueStarText:setPosition(display.width + residueStarText:getContentSize().width/2,display.height/2+200)
    self:addChild(residueStarText)

    local incrementScore = 0
    if residueStar<= 9 then 
        incrementScore = DATA_score_residueStar[residueStar + 1]
    end

    local awardScoreText  = cc.ui.UILabel.new({text=DATA_text_HD..incrementScore..DATA_text_FSJL, 
        color= cc.c3b(255, 255, 255), 
        size=50,
        })
    awardScoreText:setAnchorPoint(0.5,0.5)
    awardScoreText:setPosition(display.width+awardScoreText:getContentSize().width/2,display.height/2+100)
    self:addChild(awardScoreText)

    transition.execute(residueStarText, cc.MoveTo:create(DATA_time_moveStar, cc.p(display.width/2 , residueStarText:getPositionY())), {
        delay = 1,
        --easing = "backout",
        onComplete = function()
            transition.execute(residueStarText, cc.MoveTo:create(DATA_time_moveStar, cc.p(-residueStarText:getContentSize().width/2, residueStarText:getPositionY())), {
                delay = 2,
                onComplete = function()
                    residueStarText:removeSelf()
                end,
        })
        end,
        })
    
    transition.execute(awardScoreText, cc.MoveTo:create(DATA_time_moveStar, cc.p(display.width/2 , awardScoreText:getPositionY())), {
        delay = 1,
        --easing = "backout",
        onComplete = function()
            transition.execute(awardScoreText, cc.MoveTo:create(DATA_time_moveStar, cc.p(- awardScoreText:getContentSize().width/2, awardScoreText:getPositionY())), {
                delay = 2,
                onComplete = function()
                    awardScoreText:removeSelf()
                end,
        })
        end,
        })


    self:performWithDelay( 
                            function()  
                                if self:jurgeGameState() == Enum_state_game.gameOver then
                                    self:gameOver()
                                end
                                if self:jurgeGameState() == Enum_state_game.pass then 
                                    utility:playSound(Music_passLevel)
                                    self:passReward(function() self:restartLevel(Enum_state_level.nextLevel) end)
                                end
                            end, 
                            3.5)
end

function GameScene:countMatrixResidue(countMatrix,row,col)
    local count = 0
    if countMatrix ~=nil then
        for i=1 , row do 
            if countMatrix[i] ~= nil then
                for j=1 , col do 
                    if countMatrix[i][j] ~= nil then
                        count = count +1
                    end
                end
            end
        end 
    end
    return count
end

function GameScene:cleanFinallyScore()

    local restartLevelCallBack =  function() self:restartLevel(Enum_state_level.firstLevel) self.top:setTrueVisible() DataStat:stat(DATA_count_gameOver[4]) end
    utility:playSound(Music_failLevel)

    self.top:setFalseVisible()
    local finallyScoreViews = finallyScore.new(self.curScore,self.level,function() self:resurgenceCallBack() end,restartLevelCallBack,self.bottom)
    finallyScoreViews:setPosition(display.cx,display.cy)
    self:addChild(finallyScoreViews,100)

end

function GameScene:userMagicCallBack(isMagic,color)
    self.isMagic = isMagic
    self.magicColor = color
end

function GameScene:userBombCallBack( isBomb )
    self.isBomb = isBomb
end
function GameScene:userRefreshCallBack()
    self.isRefresh = true
    utility:playSound(Music_refreshProp)
    math.randomseed(os.time())
    if self.matrixGuid ~= nil then 
        --for i = 1 ,matrixRow do 
        --    if self.matrixGuid[i] ~= nil then
        --        for j = 1 ,matrixCol do 
        --            if self.matrixGuid[i][j] ~=nil then 
        --                self.matrixGuid[i][j]:changeStarColor(math.random(1,5))
        --                self.matrixGuid[i][j]:setScale(0.1)
        --                local time = (i*j)/(DATA_matrix_row * DATA_matrix_col) + 0.2
        --                if time > 0.5 then
        --                    time = 0.5
        --                end
        --                local ScaleTo = cc.ScaleTo:create(time, 80/self.matrixGuid[i][j]:getContentSize().width)
        --                self.matrixGuid[i][j]:runAction(ScaleTo); 
        --            end
        --        end
        --    end
        --end
        local count = 0
        local time = 0
        for j = DATA_matrix_col, 1 ,-1 do
            for i=1,DATA_matrix_row do
                if self.matrixGuid[i] ~= nil and self.matrixGuid[i][j] ~= nil then
                    local node = self.matrixGuid[i][j]
                        local color = math.random(1,5)                    
                        time = time + 0.01 
                        count = count + 1
                        local sequence = transition.sequence({
                            cc.DelayTime:create(time),
                            cc.CallFunc:create(function()
                                node:changeStarColor(color)
                                node:setScale(0.1)
                                count = count - 1
                                if count == 0 then 
                                    self.isRefresh = false
                                end
                            end),
                            cc.ScaleTo:create(0.1, DATA_star_side/self.matrixGuid[i][j]:getContentSize().width),
                        })
                        node:runAction(sequence); 
                    end
                end
            end
        end
    if UserData:getRefreshNum() <=0 then
        self.bottom:setPropNum(-DATA_refresh_cost,nil,nil)
    else
        self.bottom:setPropNum(nil,nil,-1)
    end

end

function GameScene:passReward(continueCallBack)
    -- math.randomseed(os.time())
    if UserData:getIsFirstRewardProp() == 1 then 
        local probability = DATA_probability_passReward[self.level]
        local randomNum = math.random(1,100)

        if self.level > DATA_num_maxLevel then
            local callBack = function()
                                    self.bottom:setPropNum(1,nil,nil)
                                    continueCallBack()
                                end
            self:addChild(passReward.new("102",1,function() callBack() end,self.bottom),100)
            return 
        end

        if probability >= randomNum and probability~=0 then 

            local diamondNum = nil
            local magicNum = nil
            local refreshNum = nil

            if DATA_king_passReward[self.level] == Enum_kind_prop.diamond then 
                    diamondNum = 1
            elseif DATA_king_passReward[self.level] == Enum_kind_prop.magic then 
                    magicNum = 1
            else refreshNum = 1
            end

            local callBack = function()
                                    self.bottom:setPropNum(diamondNum,magicNum,refreshNum)
                                    continueCallBack()
                                end
            self:addChild(passReward.new(DATA_king_passReward[self.level],1,function() callBack() end,self.bottom),100)
        else
            continueCallBack() 
        end
    else
        if self.level == 3 then 
            local callBack = function()
                                    self.bottom:setPropNum(1,nil,nil)
                                    UserData:setIsFirstRewardProp(1)
                                    continueCallBack()
                                end
            self:addChild(passReward.new(Enum_kind_prop.diamond,1,function() callBack() end,self.bottom),100)
        else 
            continueCallBack()
        end
    end

    
end

function GameScene:processBar()
    self.processBarViews = processBar.new(self.oldProcessEnergy)
    self:addChild(self.processBarViews,15)
end

function GameScene:setShieldingClick(touchState)
    
    if self.setShieldingClick ~= nil then 
        if touchState == true  then 
            self.shieldingClickShade:setTouchSwallowEnabled(true)
            self:setKeypadEnabled(false)
        else 
            self.shieldingClickShade:setTouchSwallowEnabled(false)
            self:setKeypadEnabled(true)
        end
    end

end

function GameScene:updateProcessEnergy(incrementScore)

    self.oldProcessEnergy = self.oldProcessEnergy + incrementScore*100/self.targetScore 
    self.processBarViews:updateProcessEnergy(self.oldProcessEnergy)

end

function GameScene:processBarEvent()

    self.isUseHeartEnergy = true

    local maxStarNum = 1 
    local m = 0 
    local n = 0
    for i=1 , matrixRow do 
        if self.matrixGuid[i] ~= nil then
            for j=1 , matrixCol do 
                if self.matrixGuid[i][j] ~= nil then
                    local crushSprite = self:findCrushSprite(i,j,self.matrixGuid,DATA_matrix_row,DATA_matrix_col)
                    if crushSprite~=nil then
                        if crushSprite[0][0] > maxStarNum then
                            maxStarNum = crushSprite[0][0] 
                            m = i
                            n = j
                        end
                    end
                end
            end
        end
    end 

    if m == 0 or n==0 then 
        for i=1 , matrixRow do 
            if self.matrixGuid[i] ~= nil then
                for j=1 , matrixCol do 
                    if self.matrixGuid[i][j] ~= nil then
                        m = i
                        n = j
                    end
                end
            end
        end 
    end

    local crushSprite = self:findCrushSprite(m,n,self.matrixGuid,DATA_matrix_row,DATA_matrix_col)
    
    local color = nil 
    local targetSprite = nil
    local xIncrement = {0,1,0,-1}
    local yIncrement = {1,0,-1,0}

    if crushSprite == nil then
        for z = 1 , #xIncrement do
            local x = m + xIncrement[z]
            local y = n + yIncrement[z]
            if x > 0 and x <= matrixRow and y>0 and y<= matrixCol then
                if self.matrixGuid[x] ~= nil then
                    if self.matrixGuid[x][y] ~= nil and self.matrixGuid[x][y]:getColor() ~= self.matrixGuid[m][n]:getColor() then 
                        color = self.matrixGuid[m][n]:getColor()
                        targetSprite = self.matrixGuid[x][y]
                    end
                end
            end
        end
    else 
        for i = 1,matrixRow do 
            if crushSprite[i] ~= nil then
                for j = 1, matrixCol do 
                    if crushSprite[i][j] == 1 then
                        for z = 1 , #xIncrement do
                            local x = i + xIncrement[z]
                            local y = j + yIncrement[z]
                            if x > 0 and x <= matrixRow and y>0 and y<= matrixCol then
                                if self.matrixGuid[x] ~= nil then
                                    if self.matrixGuid[x][y] ~= nil and self.matrixGuid[x][y]:getColor() ~= self.matrixGuid[m][n]:getColor() then 
                                        color = self.matrixGuid[m][n]:getColor()
                                        targetSprite = self.matrixGuid[x][y]
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    --local changeSprite = statistics:getMostScore(self.matrixGuid)
    --dump(changeSprite)

    if targetSprite == nil then 
        self.isUseHeartEnergy = false
        return
    end

    local  targetSpriteList = {}
    targetSpriteList[#targetSpriteList+1] = targetSprite
    local  count = 0

    math.randomseed(os.time())
    local randomNum = math.random(1,100)
    for i=#DATA_probability_heartDown-1 , 1 ,-1 do  
        if randomNum > DATA_probability_heartDown[i]  then 
            count = DATA_count_heartDown[i]
            break
        end
    end

    xIncrement = {1,-1,0,0}
    yIncrement = {0,0,1,-1}

    local position = self.gameMatrix:gamePToMatrixP(targetSprite:getPositionX(),targetSprite:getPositionY())
    m = position.row
    n = position.col
    for z = 1 , count do
        local x = m + xIncrement[z]
        local y = n + yIncrement[z]
        if x > 0 and x <= matrixRow and y>0 and y<= matrixCol then
            if self.matrixGuid[x] ~= nil then
                if self.matrixGuid[x][y] ~= nil and self.matrixGuid[x][y]:getColor() ~= color then 
                    targetSpriteList[#targetSpriteList+1] = self.matrixGuid[x][y]
                end
            end
        end
    end

    self.oldProcessEnergy = self.oldProcessEnergy - 100
    self.processBarViews:setPercentage(0)
    self.processBarViews:updateProcessEnergy(self.oldProcessEnergy)

    --local targetSprite = self.matrixGuid[changeSprite[2]][changeSprite[3]]
    local sprite = display.newSprite(processStarList[color])
    sprite:scale(0.7)

    sprite:setPosition(self:getSpriteWorldP(self.processBarViews:getProgress()))
    self:addChild(sprite,101)

    utility:playSound(Music_heartDown)
    transition.execute(sprite, cc.MoveTo:create(0.8, cc.p(self:getSpriteWorldP(targetSprite))), {
        onComplete = function()
            sprite:removeSelf()
            for i=1,#targetSpriteList do
                marquee:createMarquee(targetSpriteList[i])
                targetSpriteList[i]:changeStarColor(color)
            end
            self.isUseHeartEnergy = false
        end,
        })

end

function GameScene:musicCallBack()
    local musicState = UserData:getIsMusic()
    if musicState == 0 then 
        self.isMusic = 1
        UserData:setIsMusic(self.isMusic)
        utility:playMusic(Music_bg)
    else 
        self.isMusic = 0
        UserData:setIsMusic(self.isMusic)
        utility:stopMusic()
    end
end

function GameScene:soundCallBack()
    
    local SoundState = UserData:getIsSound()
    if SoundState == 0 then 
        self.isSound = 1
        UserData:setIsSound(self.isSound)
    else 
        self.isSound = 0
        UserData:setIsSound(self.isSound)
    end

end

function GameScene:addDiamondView(event)
    
    if self.bottom:getChildByTag(10003) ~=nil then 
        return 
    end

    x = event.x
    y = event.y
    local addDiamond = self.bottom:getChildByTag(999)
    local point = self:getSpriteWorldP(addDiamond)
    
    local matrixXMin = point.x - addDiamond:getContentSize().width/2
    local matrixXMax = point.x + addDiamond:getContentSize().width/2
    local matrixYMin = point.y - addDiamond:getContentSize().height/2
    local matrixYMax = point.y + addDiamond:getContentSize().height/2
    
    if x > matrixXMin and x<matrixXMax and y > matrixYMin and y < matrixYMax then
        if self:getChildByTag(888) == nil then
            utility:playSound(Music_enterButton) 
            self.bottom:addDiammond(nil)
        end
    end
end

function GameScene:gameProcess()
    
    if self.isResurgenceAgain == true then 
        self.isBalancing = true
        self.isResurgenceAgain = false
        self:gameOver()
    end
                    

    if self.isReportLevel == false and self.isRefresh == false and self.isBalancing == false and self.isCrushing == false and self.isMoving.state == false and self.isUseHeartEnergy == false then 
    local crushState = self:jurgeCrushState()
        if crushState == Enum_state_cursh.unalbeCrush then 
            self.isBalancing = true
            self:performWithDelay( 
                        function()  
                            self:cleanling()
                        end, 
                        1)
        end
    end
end

function GameScene:gameGuid()

    if UserData:getIsFirstGuid() ~= 1 then
        
        local refreshCal = function (  )
            self:userRefreshCallBack()
            self.bottom:setPropNum(nil,nil,1)
            UserData:setIsFirstGuid(1)
            -- self:RemoveSprite()
        end

        local refreshUseCallBack = function()
                            
                                        local point = self:getSpriteWorldP(self.bottom:getChildByTag(997))
                                        local magicSprite = {{self.bottom:getChildByTag(997),point}} 
                                        local node = shade:createBlendShade(magicSprite,self,refreshCal,PIC_icon_propBG3,PIC_text_text_kiss)
                                        
                                    end

        local bombCallBack = function (  )
            self.bottom:setPropNum(nil,nil,nil,1)
            self.isBomb = true
            self:onTouchMatrix(self:getSpriteRC(self.matrixGuid[5][2]:getPositionX(),self.matrixGuid[5][2]:getPositionY()),refreshUseCallBack)
        end
        
        local refreshEndCallBack = function()
                                    local point = self:getSpriteWorldP(self.matrixGuid[5][2])
                                    local magicSprite = {{self.matrixGuid[5][2],point}} 
                                    local node = shade:createBlendShade(magicSprite,self,bombCallBack,"#"..starList[1])

                                   end

        local refreshOnCallBack  = function()
                                       local point = self:getSpriteWorldP(self.bottom:getChildByTag(996))
                                       local magicSprite = {{self.bottom:getChildByTag(996),point}} 
                                       local node = shade:createBlendShade(magicSprite,self,refreshEndCallBack,PIC_icon_propBG3,PIC_text_text_bomb)

                                    end

        local crushRedCallBack = function()
                                    self:onTouchMatrix(self:getSpriteRC(self.matrixGuid[5][5]:getPositionX(),self.matrixGuid[5][5]:getPositionY()),refreshOnCallBack)
                                 end

        local enterRedCallBack = function()
                                    self.matrixGuid[5][5]:changeStarColor(5)
                                    utility:playSound(Music_heartDown)
                                    marquee:createMarquee(self.matrixGuid[5][5])
                                    local point = self:getSpriteWorldP(self.matrixGuid[5][5])
                                    local magicSprite = {{self.matrixGuid[5][5],point}} 
                                    local node = shade:createBlendShade(magicSprite,self,crushRedCallBack,"#"..starList[1])
                                 end

        local magicOnCallBack = function()
                                    
                                    local point = self:getSpriteWorldP(self.matrixGuid[5][5])
                                    local magicSprite = {{self.matrixGuid[5][5],point}} 
                                    local node = shade:createBlendShade(magicSprite,self,enterRedCallBack,"#"..starList[1])
                                    self.bottom:getChildByTag(10003):removeSelf()
                                    
                                end

        local crushSpriteList = {{self.matrixGuid[5][9],self:getSpriteWorldP(self.matrixGuid[5][9])},{self.matrixGuid[5][10],self:getSpriteWorldP(self.matrixGuid[5][10])}}

        local enterMagicCallBack = function()
                                       self.bottom:useMagic(function() self:userMagicCallBack() end)
                                       local point = self:getSpriteWorldP(self.bottom:getChildByTag(10003):getChildByTag(10001):getChildByTag(5))
                                       point.x = point.x - 13
                                       point.y = point.y + 160
                                       local magicSprite = {{self.bottom:getChildByTag(10003):getChildByTag(10001):getChildByTag(5),point}} 
                                       local node = shade:createBlendShade(magicSprite,self,magicOnCallBack,"#"..starList[1])
                                   end

        local useMagicCallBack = function()
                                    local magicSprite = {{self.bottom:getChildByTag(998),self:getSpriteWorldP(self.bottom:getChildByTag(998))}} 
                                    local node = shade:createBlendShade(magicSprite,self,enterMagicCallBack,PIC_icon_propBG3,PIC_text_text_lip)
                                 end

        local crushSpriteCallBack = function()
                                        self:onTouchMatrix(self:getSpriteRC(self.matrixGuid[5][9]:getPositionX(),self.matrixGuid[5][9]:getPositionY()),useMagicCallBack)
                                    end

        local node = shade:createBlendShade(crushSpriteList,self,crushSpriteCallBack,"#"..starList[1])

        local magicSprite = {self.matrixGuid[5][5]}
    end
end

function GameScene:touchTimeGuid()

    local ans = statistics:countMatrixSameNum(self.matrixGuid)
    if ans[#ans][1] == nil then
        return
    end
    local maxCount = ans[#ans][1]
    if maxCount < 2 then
        return
    end
    for i=1,#ans do  
        if #ans[i] == maxCount then
            for j=1,#ans[i] do 
                ans[i][j]:mark()
                self.touchTimeSpriteList[#self.touchTimeSpriteList+1] = ans[i][j]
            end
            break
        end 
    end

end

function GameScene:touchTimeGuidEnd()
    self.curTouchTime = 0
    if self.touchTimeSpriteList == nil or #self.touchTimeSpriteList == 0 then
        return
    end
    for i=1 , #self.touchTimeSpriteList do 
        self.touchTimeSpriteList[i]:removeMark()
    end
    self.touchTimeSpriteList = {}
end

function GameScene:reportLevelInfo(callBack,parameter)

    self.isReportLevel = true
    local residueStarText = cc.ui.UILabel.new({text=DATA_text_GK..self.level, 
        color= cc.c3b(255, 255, 255), 
        size=50,
        })
    residueStarText:setAnchorPoint(0.5,0.5)
    residueStarText:setPosition(display.width + residueStarText:getContentSize().width/2,display.height/2+100)

    local awardScoreText  = cc.ui.UILabel.new({text=DATA_text_MB..self.targetScore, 
        color= cc.c3b(255, 255, 255), 
        size=50,
        })
    awardScoreText:setAnchorPoint(0.5,0.5)
    awardScoreText:setPosition(display.width + awardScoreText:getContentSize().width/2,display.height/2)

    self:addChild(awardScoreText)
    self:addChild(residueStarText)

    transition.execute(residueStarText, cc.MoveTo:create(DATA_time_moveStar, cc.p(display.width/2 , residueStarText:getPositionY())), {
        delay = 0.5,
        --easing = "backout",
        onComplete = function()
            transition.execute(residueStarText, cc.MoveTo:create(DATA_time_moveStar, cc.p(-residueStarText:getContentSize().width/2, residueStarText:getPositionY())), {
                delay = 1,
                onComplete = function()
                    residueStarText:removeSelf()
                end,
        })
        end,
        })
    
    transition.execute(awardScoreText, cc.MoveTo:create(DATA_time_moveStar, cc.p(display.width/2 , awardScoreText:getPositionY())), {
        delay = 0.5,
        --easing = "backout",
        onComplete = function()
            transition.execute(awardScoreText, cc.MoveTo:create(DATA_time_moveStar, cc.p(- awardScoreText:getContentSize().width/2, awardScoreText:getPositionY())), {
                delay = 1,
                onComplete = function()
                    awardScoreText:removeSelf()
                    if parameter~=nil and #parameter == 0 then
                        self.isResurgenceAgain = true
                    end
                    callBack(parameter)
                    self.isReportLevel = false
                end,
        })
        end,
        })


end

function GameScene:resurgenceColseCallBack()

    utility:saveGameWithNul(self.level,self.prevScore,self.oldProcessEnergy)
    app:enterLoginScene()
end

function GameScene:shop()
    self:addChild(shop.new(self.bottom,nil,Kind_view.gameScene),100)
end

function GameScene:resurgenceFailCallBack()

    utility:saveGameWithNul(self.level,self.prevScore,self.oldProcessEnergy)
    
end

return GameScene

