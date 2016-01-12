import("..resource.ImportAllRes")
local star = import("..sprite.star")

local shade = class("shade")

function shade:createGrayShade()
    local grayShade = display.newColorLayer(cc.c4b(20,20,20,120))
    grayShade:setTouchEnabled(true)
    grayShade:setTouchSwallowEnabled(true)
    return grayShade
end

function shade:createBlendShade(spriteList,self,callBack,picAddress,text)
    local function setBlend(obj, src, dst)
        local b = {}
        b.src = src
        b.dst = dst
        obj:setBlendFunc(src,dst)
    end

    local node = display.newNode()
    local layer = display.newColorLayer(cc.c4b(0,0,0,0))
    local myLayer = display.newColorLayer(cc.c4b(0,0,0,200))

    local pMaskList = {}

    for i=1 , #spriteList do 

        local sprite = spriteList[i][1]
        local pMask = display.newSprite(picAddress)

        -- pMask:setScaleX(1.1)
        -- pMask:setScaleY(1.1)

        pMask:setPosition(spriteList[i][2].x,spriteList[i][2].y)
                --设置混合模式
        setBlend(pMask, gl.ZERO, gl.ONE_MINUS_SRC_ALPHA)

        pMaskList[#pMaskList+1] = pMask

    end 


    local arrows = display.newSprite(PIC_icon_finger)
    arrows:setPosition(spriteList[#spriteList][2].x,spriteList[#spriteList][2].y + spriteList[#spriteList][1]:getContentSize().height)
    arrows:setScale(1.5)
    node:addChild(arrows)

    local sequence = transition.sequence({
                                        cc.MoveBy:create(1.0, cc.p(0, 10)),
                                        cc.MoveBy:create(1.0, cc.p(0, -10)),
                                        })
    arrows:runAction(cc.RepeatForever:create(sequence))

    if text ~= nil then 
        local textShow = display.newSprite(text)
        textShow:setScale(1.2)
        textShow:setPosition(spriteList[#spriteList][2].x - 70 ,spriteList[#spriteList][2].y + 280 )
        node:addChild(textShow)

        if text == PIC_text_text_lip then
            textShow:setPosition(spriteList[#spriteList][2].x + 20,spriteList[#spriteList][2].y + 280 )
        end

        local sequence = transition.sequence({
                                        cc.MoveBy:create(1.0, cc.p(0, 10)),
                                        cc.MoveBy:create(1.0, cc.p(0, -10)),
                                        })
        textShow:runAction(cc.RepeatForever:create(sequence))
    end


    local pRt = cc.RenderTexture:create(display.width, display.height)
    self:addChild(pRt,49);
    pRt:setPosition(display.cx, display.cy)

    pRt:begin()
    myLayer:visit()

    for i = 1 ,#pMaskList do 
        pMaskList[i]:visit()
    end
    --end
    pRt:endToLua()

    -- 启用触摸
    function onTouch(event)
        x = event.x
        y = event.y
        local xMin = 100000
        local xMax = 0
        local yMin = 100000
        local yMax = 0
        for i=1,#spriteList do 
            local sprite = spriteList[i][1]
            local point = spriteList[i][2]
            local spriteX = point.x - sprite:getContentSize().width/2
            local spriteY = point.y - sprite:getContentSize().height/2
            if xMin > spriteX then 
                xMin = spriteX
            end
            if yMin > spriteY then 
                yMin = spriteY
            end
            if xMax < spriteX then 
                xMax = spriteX
            end
            if yMax < spriteY then 
                yMax = spriteY
            end
        end
        if x > xMin and x < xMax + spriteList[1][1]:getContentSize().width and y > yMin  and y < yMax + spriteList[1][1]:getContentSize().height then  
            node:removeSelf()
            pRt:removeSelf()
            if callBack ~= nil then
                callBack()
            end
            return false
        end
        return true
    end
    ----end
    ----开启触摸
    node:setTouchEnabled(true)
    layer:setTouchEnabled(false)
    node:addNodeEventListener(cc.NODE_TOUCH_EVENT, onTouch)
    node:setNodeEventEnabled(true)
    node:addChild(layer)
    self:addChild(node,49)
end




return shade