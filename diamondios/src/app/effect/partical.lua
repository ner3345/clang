--region patical.lua
--Author : Administrator
--Date   : 2014/8/19
--此文件由[BabeLua]插件自动生成
import("..resource.ImportAllRes")

local partical = class("partical")--,function() return display.newNode() end)


function partical:createStarPartical(node)
        --Music:playSound(GAME_SFX.bubbleRemove)
        local scene = display.getRunningScene()
        local color = node:getColor()
        local particleName = "bigwin_blowout_2"
       
        --ReorderParticleSystems_batchNode = CCParticleBatchNode:create("Effect/"..color..".png")
        local filename = "Effect/"..particleName..".plist"
        local emitter = cc.ParticleSystemQuad:create(filename)
        -- emitter:initWithFile(filename)
        
        emitter:setTexture(cc.Director:getInstance():getTextureCache():addImage("Effect/"..color..".png"))
        --emitter:setTexture(ReorderParticleSystems_batchNode:getTexture())
        emitter:setAutoRemoveOnFinish(true)
        -- emitter:autorelease()

        return emitter
end

function partical:createStarPartical2(node)
        --Music:playSound(GAME_SFX.bubbleRemove)
        local scene = display.getRunningScene()
        local color = node:getColor()
        local particleName = "bigwin_blowout_2"
       
        --ReorderParticleSystems_batchNode = CCParticleBatchNode:create("Effect/"..color..".png")
        local filename = "Effect/"..particleName..".plist"
        local emitter = cc.ParticleSystemQuad:create(filename)
        -- emitter:initWithFile(filename)
        
        emitter:setTexture(cc.Director:getInstance():getTextureCache():addImage("Effect/stat.png"))
        --emitter:setTexture(ReorderParticleSystems_batchNode:getTexture())
        emitter:setAutoRemoveOnFinish(true)
        -- emitter:autorelease()

        return emitter
end

function partical:createCakesPartical()

    utility:playSound( Music_fireworks )
    local particleName = "firework0"
               local filename = "Effect/"..particleName..".plist"
    local emitter = cc.ParticleSystemQuad:create(filename)
    -- emitter:initWithFile(filename)
    emitter:setScale(0.5)

    emitter:setAutoRemoveOnFinish(true)


    return emitter
end

return partical
