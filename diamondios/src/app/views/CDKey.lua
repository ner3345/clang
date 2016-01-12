import("..resource.ImportAllRes")
local shade = import("..effect.shade")
local utility = import("..sprite.utility")
local BubbleButton = import("..views.BubbleButton")
local CDKey = class("CDKey",function() return display.newNode() end)

function CDKey:ctor()

    local grayShade = shade:createGrayShade()
    local bg = display.newSprite(PIC_bg_CDKey)
    bg:setScale(1.5)
    bg:setPosition(display.width/2,display.height/2 - 40)

    local closeButton = display.newSprite(PIC_icon_close2)
    closeButton:setPosition(bg:getContentSize().width - closeButton:getContentSize().width/2 - 45,bg:getContentSize().height - closeButton:getContentSize().height/2 -10 )
    closeButton:setTouchEnabled(true)
    closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:removeSelf() end)
    
    local getButton = BubbleButton.new({image = PIC_Button_get,listener = function (  )
            utility:playSound(Music_enterButton) self:updateUserName(self.name)
        end})
    getButton:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.25)
    
    self.cashBox = cc.ui.UIInput.new({
            image = PIC_icon_cashBox,
            x = bg:getContentSize().width/2,
            y = bg:getContentSize().height*0.5 +8,
            listener = function(event, editbox) self:onEditName(event, editbox) end,
            size = cc.size(305, 45)
        })
    self.cashBox:setFontColor(cc.c3b(0, 0, 0))
    -- self.cashBox:setReturnType(kKeyboardReturnTypeDone)
    self.cashBox:setFontSize(10)
    -- self.inputCDKeyText = display.newSprite(PIC_text_inputCDKey)
    -- self.inputCDKeyText:setPosition(self.inputCDKeyText:getContentSize().width/2 + 2,self.cashBox:getContentSize().height/2)

    self.inputCDKeyText = cc.ui.UILabel.new({text=DATA_text_SRDHM, 
        color= cc.c3b(195, 195, 195), 
        size=23,
        })
    self.inputCDKeyText:setAnchorPoint(0.5,0.5)
    self.inputCDKeyText:setPosition(self.cashBox:getContentSize().width/2,self.cashBox:getContentSize().height/2)

    self.cashBox:addChild(self.inputCDKeyText)
    bg:addChild(self.cashBox)
    bg:addChild(closeButton)
    grayShade:addChild(bg)
    self:addChild(grayShade)
    -- local menu = ui.newMenu({getButton})
    bg:addChild(getButton)
    
end

function CDKey:onEditName(event, editbox)

    if self.inputCDKeyText ~= nil then
        self.inputCDKeyText:removeSelf()
        self.inputCDKeyText = nil
    end

    if event == "began" then
        -- ��ʼ����
        print("editBoxName 1event return : ", editbox:getText())
    elseif event == "changed" then
        -- ��������ݷ����仯
        print("editBoxName 2event return : ", editbox:getText())
        local name = editbox:getText()
        if name ~= nil and name ~= "" then
            self.name  = name
        end
    elseif event == "ended" then
        -- �������
        print("editBoxName 3event return : ", editbox:getText())
        local name = editbox:getText()
        if name ~= nil and name ~= "" then
             self.name  = name
        end
    elseif event == "return" then
        -- ������򷵻�
        print("editBoxName 4event return : ", editbox:getText())
        local name = editbox:getText()
        if name ~= nil and name ~= "" then
            self.name  = name
        end
    end
end

function CDKey:updateUserName(name)
    if name ~= nil then 
        local callBack =function(params)
                            if params.code == -1 then 
                                self:failUserCdKey()
                            else 
                                self:sucessUserCDkey(params.data)
                            end
                        end
        utility:UseCDKey(name,callBack)
    end
end

function CDKey:sucessUserCDkey(weekReword)
        if weekReword[Enum_kind_prop.diamond] ~= nil then
            dimaondNum = weekReword[Enum_kind_prop.diamond]
        end  

        if weekReword[Enum_kind_prop.magic] ~= nil then
            magicNum = weekReword[Enum_kind_prop.magic]
        end 

        if weekReword[Enum_kind_prop.refresh] ~= nil then
            refreshNum = weekReword[Enum_kind_prop.refresh]
        end
        if weekReword[Enum_kind_prop.bomb] ~= nil then
            bombNum = weekReword[Enum_kind_prop.bomb]
        end  
        UserData:addProp(dimaondNum,magicNum,refreshNum,bombNum)
        device.showAlert("兑换成功", "钻石："..dimaondNum.."  口红："..magicNum.."  香吻："..refreshNum.."  炸弹："..bombNum, {"确认"} , onButtonClicked)
        self:removeSelf() 
end

function CDKey:failUserCdKey()

    local function onButtonClicked(event)
        
    end
 
    device.showAlert("兑换码无效", "               请输入有效兑换码", {"确认"} , onButtonClicked)
end

return CDKey