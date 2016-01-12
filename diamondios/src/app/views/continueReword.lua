import("..resource.ImportAllRes")
local shade = import("..effect.shade")

local continueReword = class("continueReword",function() return display.newNode() end)

function continueReword:ctor(params,createNoticeCallBack)
   
    dump(createNoticeCallBack)
    local grayShade = shade:createGrayShade()
    local bg = display.newSprite(PIC_bg_continueReword)
    bg:setScale(DATA_scale_changeResolution)
    bg:setPosition(grayShade:getContentSize().width/2,grayShade:getContentSize().height/2-40)

    local todayGetButton = display.newSprite(PIC_button_todayGetButton)
    todayGetButton:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.2)
    todayGetButton:setTouchEnabled(true)
    todayGetButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:todayGetButtonEvent(createNoticeCallBack) end)

    self:createRewordFrame(params,bg)

    bg:addChild(todayGetButton)
    grayShade:addChild(bg)
    self:addChild(grayShade)
    
end

function continueReword:createRewordFrame(params,bg)
    dump(params)
    local today = tonumber(params.day)
    local nextDay = today+1
    if nextDay > 5  then 
        nextDay = 1
    end

    local weekReword = {params.rewordList['1'],params.rewordList['2'],params.rewordList['3'],params.rewordList['4'],params.rewordList['5']}
    self:createTodayFrame(weekReword,today,0,bg,PIC_bg_continueLoginProp1)
    self:createTodayFrame(weekReword,nextDay,-175,bg,PIC_bg_continueLoginProp2)
end

function continueReword:countNum(list)
    local count = 0
    if list[Enum_kind_prop.diamond] ~= nil then
        count = count +1
    end  

    if list[Enum_kind_prop.magic] ~= nil then
        count = count +1
    end 

    if list[Enum_kind_prop.refresh] ~= nil then
        count = count +1
    end 
    return count 
end

function continueReword:createTodayFrame(weekReword,today,Y,bg,propBG)
    local diamondNumPosizion = {160,365}
    local twoPropNumPosizion = {350,365}
    local ThreePropNumPosizion1 = {350,340}
    local ThreePropNumPosizion2 = {350,405}
    local propAndNum = {-20,30}
    if self:countNum(weekReword[today]) == 2 then
        if weekReword[today][Enum_kind_prop.diamond] ~= nil then
            local propNum  = CCLabelAtlas:create(weekReword[today][Enum_kind_prop.diamond],PIC_num_continueReward, 14, 18, string.byte("0"))
            propNum:setPosition(diamondNumPosizion[1] ,diamondNumPosizion[2] +Y)
            bg:addChild(propNum)
        end  

        if weekReword[today][Enum_kind_prop.magic] ~= nil then
            local propNum  = CCLabelAtlas:create(weekReword[today][Enum_kind_prop.magic],PIC_num_continueReward, 14, 18, string.byte("0"))
            propNum:setPosition(twoPropNumPosizion[1] ,twoPropNumPosizion[2] +Y)

            local propPic = display.newSprite(PIC_icon_magic)
            propPic:setPosition(propNum:getPositionX() + propAndNum[1] ,propNum:getPositionY() + propAndNum[2])
            propPic:setScale(2/3)

            local propPicBG = display.newSprite(propBG)
            propPicBG:setPosition(propNum:getPositionX() + propAndNum[1] ,propNum:getPositionY() + propAndNum[2])
            
            bg:addChild(propPicBG)
            bg:addChild(propPic)
            bg:addChild(propNum)
        end 

        if weekReword[today][Enum_kind_prop.refresh] ~= nil then
            local propNum  = CCLabelAtlas:create(weekReword[today][Enum_kind_prop.refresh],PIC_num_continueReward, 14, 18, string.byte("0"))
            propNum:setPosition(twoPropNumPosizion[1] ,twoPropNumPosizion[2] +Y)
            local propPic = display.newSprite(PIC_icon_refresh)
            propPic:setPosition(propNum:getPositionX() + propAndNum[1] ,propNum:getPositionY() + propAndNum[2])
            propPic:setScale(2/3)

            local propPicBG = display.newSprite(propBG)
            propPicBG:setPosition(propNum:getPositionX() + propAndNum[1] ,propNum:getPositionY() + propAndNum[2])
            
            bg:addChild(propPicBG)

            bg:addChild(propPic)
            bg:addChild(propNum)
        end 
    end

    if self:countNum(weekReword[today]) == 3 then
        if weekReword[today][Enum_kind_prop.diamond] ~= nil then
            local propNum  = CCLabelAtlas:create(weekReword[today][Enum_kind_prop.diamond],PIC_num_continueReward, 14, 18, string.byte("0"))
            propNum:setPosition(diamondNumPosizion[1] ,diamondNumPosizion[2] + Y)
            bg:addChild(propNum)
        end  

        if weekReword[today][Enum_kind_prop.magic] ~= nil then
            local propNum  = CCLabelAtlas:create(weekReword[today][Enum_kind_prop.magic],PIC_num_continueReward, 14, 18, string.byte("0"))
            propNum:setPosition(ThreePropNumPosizion1[1],ThreePropNumPosizion1[2] + Y)

            local propPic = display.newSprite(PIC_icon_magic)
            propPic:setPosition(propNum:getPositionX() + propAndNum[1] ,propNum:getPositionY() + propAndNum[2])
            propPic:setScale(2/3)

            local propPicBG = display.newSprite(propBG)
            propPicBG:setPosition(propNum:getPositionX() + propAndNum[1] ,propNum:getPositionY() + propAndNum[2])
            propPicBG:setScale(2/3)

            bg:addChild(propPicBG)

            bg:addChild(propPic)
            bg:addChild(propNum)
        end 

        if weekReword[today][Enum_kind_prop.refresh] ~= nil then
            local propNum  = CCLabelAtlas:create(weekReword[today][Enum_kind_prop.refresh],PIC_num_continueReward, 14, 18, string.byte("0"))
            propNum:setPosition(ThreePropNumPosizion2[1],ThreePropNumPosizion2[2]+Y)
            local propPic = display.newSprite(PIC_icon_refresh)
            propPic:setPosition(propNum:getPositionX() + propAndNum[1] ,propNum:getPositionY() + propAndNum[2])
            propPic:setScale(2/3)

            local propPicBG = display.newSprite(propBG)
            propPicBG:setPosition(propNum:getPositionX() + propAndNum[1] ,propNum:getPositionY() + propAndNum[2])
            propPicBG:setScale(2/3)

            bg:addChild(propPicBG)
            bg:addChild(propPic)
            bg:addChild(propNum)
        end 
    end
end

function continueReword:todayGetButtonEvent(createNoticeCallBack)
    if createNoticeCallBack ~=nil then 
        createNoticeCallBack()
    end
    self:removeSelf()
end

return continueReword