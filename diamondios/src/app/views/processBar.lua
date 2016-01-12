import("..resource.ImportAllRes")
local processBar = class("processBar",function() return display.newNode() end)

function processBar:ctor(processEnergy)

    local processBarBG = display.newSprite(PIC_icon_bloodBg)
    processBarBG:setPosition(display.left + 80, display.top - 260)

    self.processPointNum  = cc.ui.UILabel.new({text = math.floor(processEnergy).."%", 
        align = cc.ui.TEXT_ALIGN_CENTER,
        valign = cc.ui.TEXT_VALIGN_CENTER,
        color= cc.c3b(255, 255, 255), 
        size=30,
        x = processBarBG:getContentSize().width/2,
        y = processBarBG:getContentSize().height/2 + 5,
        })
    self.processPointNum:setAnchorPoint(0.5,0.5)
    processBarBG:addChild(self.processPointNum,10)

    self.progress01 = cc.ProgressTimer:create(cc.Sprite:create(PIC_icon_blood))
    self.progress01:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    self.progress01:setMidpoint(cc.p(0, 0))
    self.progress01:setBarChangeRate(cc.p(0, 1))
    self.progress01:setPosition(cc.p(display.left + 80, display.top - 260))

    self:addChild(self.progress01)
    self:addChild(processBarBG)

    self.to1 = cc.ProgressTo:create(1, processEnergy)
    self.progress01:runAction(self.to1)

end

function processBar:updateProcessEnergy(newProcessEnergy)
    self.processPointNum:setString(math.floor(newProcessEnergy).."%")
    self.to1 = cc.ProgressTo:create(1, newProcessEnergy)
    self.progress01:runAction(self.to1)

end

function processBar:setPercentage(processEnergy)
    self.processPointNum:setString(math.floor(processEnergy).."%")
    self.progress01:setPercentage(processEnergy)
end

function processBar:getProgress()
    return self.progress01
end

function processBar:processNum()
    
end

return processBar

