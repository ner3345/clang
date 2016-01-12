import("..resource.ImportAllRes")
local BubbleButton = import("..views.BubbleButton")
local loginSceneBottom = class("loginSceneBottom",function() return display.newNode() end)


function loginSceneBottom:ctor(shopCallBack,CDKeyCallBack)

    self:setContentSize(DATA_pic_width,DATA_pic_height* 0.15)
    self:setScale(DATA_scale_changeResolution)
    self:setAnchorPoint(cc.p(0.5, 0.5))

    local crushStartBG = display.newSprite(PIC_bg_loginSceneFollow)
    crushStartBG:setPosition(self:getContentSize().width/2,self:getContentSize().height - crushStartBG:getContentSize().height/2)

    local shopButton = BubbleButton.new({image = PIC_icon_shop,listener = function (  )
            utility:playSound(Music_enterButton) shopCallBack()
        end})
    shopButton:setPosition(self:getContentSize().width*0.85,self:getContentSize().height-40)

    -- local CDkeyButton = BubbleButton.new({image = PIC_icon_CDKey,listener = function (  )
    --         utility:playSound(Music_enterButton) CDKeyCallBack()
    --     end})
    -- CDkeyButton:setPosition(self:getContentSize().width*0.15,self:getContentSize().height-40)
    self:addChild(crushStartBG)
   self:addChild(shopButton,1)
   -- self:addChild(CDkeyButton,1)

end


return loginSceneBottom