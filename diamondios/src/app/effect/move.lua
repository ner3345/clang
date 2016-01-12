import("..resource.ImportAllRes")

local move = class("move")

function move:createScoreMove(sprite,endPosition)

    local bezierConf = {}--ccBezierConfig()
    bezierConf.controlPoint_1 = cc.p(sprite:getPositionX()+200, sprite:getPositionY() + (820 - sprite:getPositionY()) / 3 * 1)
    bezierConf.controlPoint_2 = cc.p(sprite:getPositionX()-200, sprite:getPositionY() + (820 - sprite:getPositionY()) / 3 * 2)
    bezierConf.endPosition = endPosition
    return cc.MoveTo:create(1,endPosition)
    -- return cc.BezierTo:create(1, bezierConf)

end


function move:createStraightMove(sprite,endPosition)
    return cc.BezierTo:create(1, bezierConf)
end

function move:createSpin(sprite)

    local rotateto = cc.RotateTo:create(8, 720);
    local sequence = transition.sequence({
        rotateto,
    })
    sprite:runAction(cc.RepeatForever:create(sequence));

end

return move