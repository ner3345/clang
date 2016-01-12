import("..resource.ImportAllRes")
local matrix = class("matrix",function() return display.newNode() end)

function matrix:ctor(distanceX,distanceY,leftDistance,buttomDistance,side)
    self.row = DATA_matrix_row
    self.col = DATA_matrix_col
    self.distanceX = 0
    self.distanceY = 0
    self.leftDistance = 0
    self.buttomDistance = 10
    self.side = DATA_star_side
    self.bg = self
    self:setContentSize(self.side*self.row,self.side*self.col)
end

function matrix:init(spriteList)
   
    local matrixBg = self.bg
    local distanceX = self.distanceX
    local distanceY = self.distanceY 
    local leftDistance = self.leftDistance
    local buttomDistance = self.buttomDistance
    local row = self.row 
    local col = self.col
    local side = self.side

    for i = 1 , row do
        if spriteList[i] ~= nil then  
            for j = 1 , col do
                if spriteList[i][j] ~= nil then 
                    spriteList[i][j]:align(display.CENTER, leftDistance + side/2 * ( 2*i-1 ) + (i-1)*distanceX , buttomDistance + side/2 *( 2*j -1 ) + ( j - 1)*distanceY )
                    --print("sprite posizion :",leftDistance + side/2 * ( 2*i-1 ) + (i-1)*distanceX , buttomDistance + side/2 *( 2*j -1 ) + ( j - 1)*distanceY )
                    spriteList[i][j]:setScaleX(side/spriteList[i][j]:getContentSize().width)
                    spriteList[i][j]:setScaleY(side/spriteList[i][j]:getContentSize().height)
                    self:initDown(i,j,spriteList[i][j])
                    matrixBg:addChild(spriteList[i][j])
                end
            end
        end
    end
end

function matrix:addNewSprite(newSpriteList)

    local matrixBg = self.bg
    local distanceX = self.distanceX
    local distanceY = self.distanceY 
    local leftDistance = self.leftDistance
    local buttomDistance = self.buttomDistance
    local row = self.row 
    local col = self.col
    local side = self.side
    local newSpritePositionYBase = self:getHeight()

    if newSpriteList~=nil then 
        for i = 1 , self.row do  
            if newSpriteList[i] ~= nil then
                for j = 1 , #newSpriteList[i] do 
                newSpriteList[i][j]:align(display.CENTER, leftDistance + side/2 * ( 2*i-1 ) + (i-1)*distanceX , buttomDistance + side/2 *( 2*j -1 ) + ( j - 1)*distanceY + newSpritePositionYBase)
                matrixBg:addChild(newSpriteList[i][j])
                end
            end 
        end
    end

end

function matrix:gamePToMatrixP(x,y)
    local row =  math.floor((x - self.leftDistance) / (self.side + self.distanceX)) + 1
    local col =  math.floor((y - self.buttomDistance) / (self.side + self.distanceY)) + 1
    return {row = row,col = col}

end

function matrix:matrixPToGameP(row,col)

    local distanceX = self.distanceX
    local distanceY = self.distanceY 
    local leftDistance = self.leftDistance
    local buttomDistance = self.buttomDistance
    local side = self.side

    local point = { x = nil, y = nil }
    point.x = leftDistance + side/2 * ( 2*row-1 ) + (row-1)*distanceX 
    point.y = buttomDistance + side/2 *( 2*col -1 ) + ( col - 1)*distanceY
    return point

end

function matrix:getWidth()
    return self.bg:getContentSize().width 
end

function matrix:getHeight()
    return self.bg:getContentSize().height
end

function matrix:updateMatrix(oldMatrix,newMatrix,isMoving)

    local changeSpriteList = {}
    if oldMatrix ~= nil and newMatrix ~= nil then
        for i = 1,#newMatrix do
            if newMatrix[i] ~= nil then  
                for j = 1, #newMatrix[i] do 
                    if self:getChangeSpriteInfo(newMatrix[i][j],i,j,oldMatrix) ~= nil then
                        changeSpriteList[#changeSpriteList + 1] = self:getChangeSpriteInfo(newMatrix[i][j],i,j,oldMatrix)
                    end
                end
            end
        end
    end

    self:changeSpritePosition(changeSpriteList,isMoving)

end

function matrix:getChangeSpriteInfo(sprite,row,col,oldMatrix)
    
    local changeSpriteInfo = {sprite = sprite,newP ={row = row,col = col}}
    
    if sprite ~= oldMatrix[row][col] then
        for i = 1 , #oldMatrix do 
            if oldMatrix[i] ~= nil then 
                for j = 1 , #oldMatrix[i] do 
                    if oldMatrix[i][j] ~= nil then 
                        if oldMatrix[i][j] == sprite then
                            changeSpriteInfo.sprite = oldMatrix[i][j]
                        end 
                    end
                end
            end
        end
    end

    return changeSpriteInfo
end

function matrix:changeSpritePosition(changeSpriteList,isMoving)
    
    local count = #changeSpriteList

    if #changeSpriteList == 0 then 
        isMoving.state = false
    end

    for i = 1 ,#changeSpriteList do 
        changeSpriteInfo = changeSpriteList[i]
        sprite = changeSpriteInfo.sprite
        point = self:matrixPToGameP(changeSpriteInfo.newP.row,changeSpriteInfo.newP.col)

        --print(changeSpriteInfo.newP.row,changeSpriteInfo.newP.col)

        transition.execute(sprite, cc.MoveTo:create(DATA_time_moveStar, cc.p(point.x, point.y)), {
        --delay = 0,
        --easing = "backout",
        onComplete = function()
            count = count - 1
            --print(count)
            if count == 0 then
                isMoving.state = false
                --print(isMoving.state)
            end
        end,
        })
    end
end

function matrix:removeAllSprite()
    self.bg:removeAllChildren()
end

function matrix:initDown(row, col,sprite)

    local nodeSprite = sprite

    local x = sprite:getPositionX()
    local y = sprite:getPositionY() 
    
    local start_y = sprite:getPositionY() + 500

    nodeSprite:setPosition(x,start_y)

    local time = (row*col)/(DATA_matrix_row * DATA_matrix_col) + 0.2
    if time > 0.5 then
        time = 0.5
    end

    nodeSprite:runAction(cc.MoveTo:create(time, cc.p(x,y)))

end

return matrix

