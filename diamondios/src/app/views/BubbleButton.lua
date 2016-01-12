
-- local BubbleButton = {}

-- -- create bubble button
-- function BubbleButton.new(params)
--     local listener = params.listener
--     local button -- pre-reference

--     params.listener = function(tag)
--         if params.prepare then
--             params.prepare()
--         end

--         local function zoom1(offset, time, onComplete)
--             local x, y = button:getPosition()
--             local size = button:getContentSize()

--             local scaleX = button:getScaleX() * (size.width + offset) / size.width
--             local scaleY = button:getScaleY() * (size.height - offset) / size.height

--             transition.moveTo(button, {y = y - offset, time = time})
--             -- transition.moveTo(button, {x = x - offset, time = time})
--             transition.scaleTo(button, {
--                 scaleX     = scaleX/2,
--                 scaleY     = scaleY,
--                 time       = time,
--                 onComplete = onComplete,
--             })
--         end

--         local function zoom2(offset, time, onComplete)
--             local x, y = button:getPosition()
--             local size = button:getContentSize()

--             transition.moveTo(button, {y = y + offset, time = time / 2})
--             -- transition.moveTo(button, {x = x + offset, time = time / 2})
--             transition.scaleTo(button, {
--                 scaleX     = 1.0,
--                 scaleY     = 1.0,
--                 time       = time,
--                 onComplete = onComplete,
--             })
--         end

--         button:getParent():setEnabled(false)

--         zoom1(20, 0.08, function()
--             zoom2(20, 0.09, function()
--                 zoom1(10, 0.10, function()
--                     zoom2(10, 0.11, function()
--                         button:getParent():setEnabled(true)
--                         button:getParent():setAnchorPoint(0.5,0.5)
--                         listener(tag)
--                     end)
--                 end)
--             end)
--         end)
--     end

--     button = cc.ui.newImageMenuItem(params)
--     return button
-- end

-- return BubbleButton


local BubbleButton = {}

-- create bubble button
function BubbleButton.new(params)
    local listener = params.listener
    local button -- pre-reference

    params.listener = function(tag)
        if params.prepare then
            params.prepare()
        end

        local function zoom1(offset, time, onComplete)
            local x, y = button:getPosition()
            local size = button:getContentSize()
            size.width = 200
            size.height = 200

            local scaleX = button:getScaleX() * (size.width + offset) / size.width
            local scaleY = button:getScaleY() * (size.height - offset) / size.height

            transition.moveTo(button, {y = y - offset, time = time})
            transition.scaleTo(button, {
                scaleX     = scaleX/2,
                scaleY     = scaleY,
                time       = time,
                onComplete = onComplete,
            })
        end

        local function zoom2(offset, time, onComplete)
            local x, y = button:getPosition()
            local size = button:getContentSize()
            size.width = 200
            size.height = 200

            transition.moveTo(button, {y = y + offset, time = time / 2})
            transition.scaleTo(button, {
                scaleX     = 1.0,
                scaleY     = 1.0,
                time       = time,
                onComplete = onComplete,
            })
        end

        button:setButtonEnabled(false)

        zoom1(40, 0.08, function()
            zoom2(40, 0.09, function()
                zoom1(20, 0.10, function()
                    zoom2(20, 0.11, function()
                        button:setButtonEnabled(true)
                        listener(tag)
                    end)
                end)
            end)
        end)
    end

    button =  cc.ui.UIPushButton.new({normal = params.image})
    button:onButtonClicked(function(tag)
        params.listener(tag)
    end)
    return button
end

return BubbleButton