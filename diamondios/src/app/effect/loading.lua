import("..resource.ImportAllRes")
local move = import("..effect.move")

local loading = class("loading")

function loading:createGrayloading()
    local grayloading = display.newColorLayer(cc.c4b(20,20,20,120))
    grayloading:setTouchEnabled(true)
    grayloading:setTouchSwallowEnabled(true)
    return grayloading
end

function loading:createBlendloading(loadings,scen)
    local light = display.newSprite(PIC_commont_loading)
    light:setScale(0.5)
    light:setPosition(display.width/2,display.height/2)
    loadings:addChild(light)
    move:createSpin(light)

    local loadText  = cc.ui.UILabel.new({text="正在支付...请稍后!", 
        color= cc.c3b(255, 255, 255), 
        size=32,
        })
    loadText:setAnchorPoint(0.5,0.5)
    loadText:setPosition(display.width/2,display.height/2-light:getContentSize().height/2)
    loadings:addChild(loadText)

    -- scen:performWithDelay(function()
    --     self:onButtonClicked(loadings)
    -- end, 8)
end

function loading:onButtonClicked(loadings)
    if loadings ~= nil then
       loadings:removeSelf()
    end
end




return loading