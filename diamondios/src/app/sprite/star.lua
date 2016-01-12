--region star.lua
--Author : Administrator
--Date   : 2014/8/18
--此文件由[BabeLua]插件自动生成

import("..resource.picture")

local partical = import("..effect.partical")

local star = class("star",function(color) 
                            return display.newSprite("#"..starList[color]) 
                            end
                  )

function star:ctor(color)
    self.color = color
end

function star:crush()
    self:removeSelf()
end

function star:getColor()
    return self.color
end

function star:setColor(color)
    self.color = color
end

function star:starChangeToScore()
     
end

function star:mark()
    local sequence = transition.sequence({
            cc.ScaleTo:create(1, 0.6,0.6),
            cc.ScaleTo:create(1, 1.0,1.0),
            })
    self:runAction(cc.RepeatForever:create(sequence)); 
end

function star:removeMark()
    self:stopAllActions()
    self:setScale(DATA_star_side/self:getContentSize().width)
end

function star:changeStarColor(color)
    local spriteFrame
    if color > 9 then
        spriteFrame = display.newSpriteFrame(starListL[color/10])
        self:setColor(color/10)
    else
        spriteFrame = display.newSpriteFrame(starList[color])
        self:setColor(color)
    end

    self:setSpriteFrame(spriteFrame)
end

return star

--endregion
