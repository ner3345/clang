import("..resource.ImportAllRes")

local marquee = class("move")

function marquee:createMarquee(node)

    local frames = display.newFrames("%02d.png", 0, 9)
    local animation = display.newAnimation(frames, 1 / 14)
    local sprite = display.newSprite(frames[1])
    sprite:setScale(2/3)
    sprite:setPosition(node:getContentSize().width/2,node:getContentSize().height/2)
    node:addChild(sprite)
    sprite:playAnimationOnce(animation,true)
end

return marquee