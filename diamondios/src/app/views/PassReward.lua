import("..resource.ImportAllRes")
local shade = import("..effect.shade")
local move = import("..effect.move")
local PassReward = class("PassReward",function() return display.newNode() end)

function PassReward:ctor(prop,num,callBack,sceneBottom)

    utility:playSound(Music_getReward)
    self.sceneBottom = sceneBottom
    local grayShade = shade:createGrayShade()
    local bg = display.newSprite(PIC_bg_passReward)
    bg:setScale(DATA_scale_changeResolution)
    bg:setPosition(display.width/2,display.height/2)
    local light = display.newSprite(PIC_icon_light)
    light:setPosition(bg:getContentSize().width/2,bg:getContentSize().height/2)

    move:createSpin(light)

    local imageAdd = nil

    if prop == Enum_kind_prop.diamond then 
        imageAdd = PIC_pic_passRewardDiamond
    elseif prop == Enum_kind_prop.magic then 
        imageAdd = PIC_pic_passRewardMagic
    else 
        imageAdd = PIC_pic_passRewardRefresh 
    end


    local propImage = display.newSprite(imageAdd)
    propImage:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.65)


    local getButton = display.newSprite(PIC_button_rewardButton)
    getButton:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.22)
    getButton:setTouchEnabled(true)
    local getButtonFun = function()
                            utility:playSound(Music_enterButton)
                            if prop == Enum_kind_prop.diamond then 
                                self.sceneBottom:setDiamondNumShow()
                            elseif prop == Enum_kind_prop.magic then 
                                self.sceneBottom:setMagicNumShow()
                            else 
                                self.sceneBottom:setRefreshNum()
                            end
                            callBack()
                            self:removeSelf()
                         end
    getButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, getButtonFun)
    
    bg:addChild(light,-1)
    bg:addChild(propImage)
    bg:addChild(getButton)
    grayShade:addChild(bg)
    self:addChild(grayShade)
    
end


return PassReward