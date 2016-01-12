local shade  = import("..effect.shade")
import("..resource.ImportAllRes")
local giftBag = import("..views.giftBag")
local shop = import("..views.shop") 
local star = import("..sprite.star")
local gameSceneBottom = class("gameSceneBottom",function() return display.newNode() end)

function gameSceneBottom:ctor(diamondNum,magicNum,refreshNum,bombNum,magicCallBack,diamondCallBack,refreshCallBack,bombCallBack)
    
    local flowerOrnament = display.newSprite(PIC_Button_rect)
    local propBG = display.newSprite(PIC_bg_levelInfo)
    local blackGrassOrnament = display.newSprite(PIC_ornament_blackGrass)
    self.isSelectBomb = false

    self:setContentSize(DATA_pic_width, flowerOrnament:getContentSize().height + blackGrassOrnament:getContentSize().height )
    self:setAnchorPoint(cc.p(0.5, 0.5))
    self:setScale(DATA_scale_changeResolution)
    
    flowerOrnament:setScaleX(0.7)
    flowerOrnament:setPosition(self:getContentSize().width/2,flowerOrnament:getContentSize().height)

    propBG:setPosition(self:getContentSize().width/2,propBG:getContentSize().height/2)

    --钻石
    local diamondBG = display.newSprite(PIC_icon_propBG3)
    diamondBG:setScale(2/3)
    diamondBG:setPosition(90,70)
    local diamond = display.newSprite(PIC_icon_diamond)
    diamond:setPosition(diamondBG:getContentSize().width/2,diamondBG:getContentSize().height/2)
    
    self.diamondIcon = display.newSprite(PIC_icon_bubble)
    self.diamondIcon:setPosition(diamondBG:getContentSize().width * 0.2,diamondBG:getContentSize().height * 0.2)

    self.diamondNumText  = cc.LabelAtlas:_create(diamondNum,PIC_num_yellowSquare, 14, 20, string.byte("0"))
    self.diamondNumText:setAnchorPoint(0.5,0.5)
    self.diamondNumText:setPosition(self.diamondIcon:getContentSize().width/2 ,self.diamondIcon:getContentSize().height/2)

    
    local diamondAdd = display.newSprite(PIC_icon_add)
    diamondAdd:setScale(5/6)
    diamondAdd:setPosition(diamondBG:getContentSize().width - 20,diamondBG:getContentSize().height-30)
    diamondBG:addChild(diamondAdd, 1000)

    self.diamondIcon:addChild(self.diamondNumText)
    diamondBG:addChild(self.diamondIcon)
    diamondBG:addChild(diamond)

    --口红
    local magicBG = display.newSprite(PIC_icon_propBG3)
    magicBG:setScale(2/3)
    magicBG:setPosition(190,70)
    local magic   = display.newSprite(PIC_icon_magic)
    magic:setPosition(magicBG:getContentSize().width/2,magicBG:getContentSize().height/2)

    self.magicIcon = display.newSprite(PIC_icon_bubble)
    self.magicIcon:setPosition(magicBG:getContentSize().width*0.2,magicBG:getContentSize().height*0.2)
    
    self.magicNumText  = cc.LabelAtlas:_create(magicNum,PIC_num_yellowSquare, 14, 20, string.byte("0"))
    self.magicNumText:setAnchorPoint(0.5,0.5)
    self.magicNumText:setPosition(self.magicIcon:getContentSize().width/2,self.magicIcon:getContentSize().height/2)

    self.magicIcon:addChild(self.magicNumText)
    magicBG:addChild(self.magicIcon, 1000)
    magicBG:addChild(magic)

    --香吻
    local refreshBG = display.newSprite(PIC_icon_propBG3)
    refreshBG:setScale(2/3)
    refreshBG:setPosition(390,70)
    local refresh   = display.newSprite(PIC_icon_refresh)
    refresh:setPosition(refreshBG:getContentSize().width/2,refreshBG:getContentSize().height/2)

    self.refreshIcon = display.newSprite(PIC_icon_bubble)
    self.refreshIcon:setPosition(refreshBG:getContentSize().width * 0.2,refreshBG:getContentSize().height * 0.2)

    self.refreshNumText  = cc.LabelAtlas:_create(refreshNum,PIC_num_yellowSquare, 14, 20, string.byte("0"))
    self.refreshNumText:setAnchorPoint(0.5,0.5)
    self.refreshNumText:setPosition(self.refreshIcon:getContentSize().width / 2,self.refreshIcon:getContentSize().height / 2)

    self.refreshIcon:addChild(self.refreshNumText)
    refreshBG:addChild(self.refreshIcon,1000)
    refreshBG:addChild(refresh)

--炸弹
    local bombBG = display.newSprite(PIC_icon_propBG3)
    bombBG:setScale(2/3)
    bombBG:setPosition(290,70)
    self.bomb   = display.newSprite(PIC_icon_bomb)
    self.bomb:setScale(0.9)
    self.bomb:setPosition(bombBG:getContentSize().width/2+10,bombBG:getContentSize().height/2)

    self.bombIcon = display.newSprite(PIC_icon_bubble)
    self.bombIcon:setPosition(bombBG:getContentSize().width * 0.2,bombBG:getContentSize().height * 0.2)

    self.bombNumText  = cc.LabelAtlas:_create(bombNum,PIC_num_yellowSquare, 14, 20, string.byte("0"))
    self.bombNumText:setAnchorPoint(0.5,0.5)
    self.bombNumText:setPosition(self.bombIcon:getContentSize().width / 2,self.bombIcon:getContentSize().height / 2)

    self.bombIcon:addChild(self.bombNumText)
    bombBG:addChild(self.bombIcon,1000)
    bombBG:addChild(self.bomb)


    self:addChild(flowerOrnament)
    self:addChild(magicBG)
    self:addChild(diamondBG)
    self:addChild(refreshBG)
    self:addChild(bombBG)
    
    self:setRefreshNumInc()
    self:setDiamondNumInc()
    self:setMagicNumInc()
    self:setBombNumInc()

    magicBG:setTouchEnabled(true)
    magicBG:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) self:removeBombText(bombCallBack) utility:playSound(Music_enterButton) self:useMagic(magicCallBack) end)
    magicBG:setTag(998)

    diamondBG:setTouchEnabled(true)
    diamondBG:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) self:removeBombText(bombCallBack) utility:playSound(Music_enterButton) self:addDiammond(diamondCallBack) end)
    diamondBG:setTag(999)

    refreshBG:setTouchEnabled(true)
    refreshBG:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) self:removeBombText(bombCallBack) utility:playSound(Music_enterButton) self:useRefresh(refreshCallBack) end)
    refreshBG:setTag(997)

    bombBG:setTouchEnabled(true)
    bombBG:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) utility:playSound(Music_enterButton) self:useBomb(bombCallBack) end)
    bombBG:setTag(996)
end

function gameSceneBottom:setDiamondNumInc(  )
    if UserData:getDiamondNum() <=0 then
        self.diamondIcon:setVisible(false)
    else
        self.diamondIcon:setVisible(true)
    end
end

function gameSceneBottom:setBombNumInc(  )
    if UserData:getBombNum() <=0 then
        self.bombIcon:setVisible(false)
    else
        self.bombIcon:setVisible(true)
    end
end

function gameSceneBottom:setMagicNumInc(  )
    if UserData:getMagicNum() <=0 then
        self.magicIcon:setVisible(false)
    else
        self.magicIcon:setVisible(true)
    end
end

function gameSceneBottom:setRefreshNumInc(  )
    if UserData:getRefreshNum() <=0 then
        self.refreshIcon:setVisible(false)
    else
        self.refreshIcon:setVisible(true)
    end
end

function gameSceneBottom:setPropNum(diamondNum,magicNum,refreshNum,bombNum)
    if diamondNum ~= nil then
        self.diamondNumText:setString(UserData:getDiamondNum() + diamondNum)
        UserData:setDiamondNum(UserData:getDiamondNum()+diamondNum)
        self:setDiamondNumInc()
    end 
    if magicNum ~= nil then
        self.magicNumText:setString(UserData:getMagicNum() + magicNum) 
        UserData:setMagicNum(UserData:getMagicNum()+magicNum)
        self:setMagicNumInc()
    end
    if refreshNum ~= nil then 
        self.refreshNumText:setString(UserData:getRefreshNum() + refreshNum) 
        UserData:setRefreshNum(UserData:getRefreshNum() + refreshNum) 
        self:setRefreshNumInc()
    end
    if bombNum ~= nil then 
        self.bombNumText:setString(UserData:getBombNum() + bombNum) 
        UserData:setBombNum(UserData:getBombNum() + bombNum) 
        self:setBombNumInc()
    end
end

function gameSceneBottom:setDiamondNumShow()
    self.diamondNumText:setString(UserData:getDiamondNum())
end

function gameSceneBottom:setMagicNumShow()
    self.magicNumText:setString(UserData:getMagicNum()) 
end

function gameSceneBottom:setRefreshNum()
    self.refreshNumText:setString(UserData:getRefreshNum()) 
end

function gameSceneBottom:setBombNum()
    self.bombNumText:setString(UserData:getBombNum()) 
end

function gameSceneBottom:newShop(selectKind)
    self:getParent():addChild(shop.new(self,selectKind,Kind_view.gameScene),102)
end

function gameSceneBottom:newGiftBag()

    if self:getParent():getChildByTag(888) == nil then
        
    local getGiftBagCallBack = function(diamondNum,magicNum,refreshNum,bombNum)
                                    self:reloadBag()
                               end
    self:getParent():addChild(giftBag.new(getGiftBagCallBack,nil,Kind_view.gameScene),102,888)    

    end

end

function gameSceneBottom:reloadBag(  )
    self:setRefreshNumInc()
    self:setDiamondNumInc()
    self:setMagicNumInc()
    self:setBombNumInc()

    self:setDiamondNumShow()
    self:setMagicNumShow()
    self:setRefreshNum()
    self:setBombNum()
end

function gameSceneBottom:useMagic(magicCallBack)

    if UserData:getMagicNum() <=0 and UserData:getDiamondNum() < DATA_magic_cost then 
        DataStat:stat(DATA_count_gameSceneGiftBag[5])
        --if  then
            --self:newShop(1)
        --else 
        self:newGiftBag()
        --end
    else

        self.propEnoughBG = display.newSprite(PIC_bg_propWhite)
        self.propEnoughBG:setPosition(self:getContentSize().width/2,-self.propEnoughBG:getContentSize().height/2)
        self.propEnoughBG:setScale(2/3)
        self.propEnoughBG:setTag(10001)
        
        self.grayShade = shade:createGrayShade()
        self.grayShade:setTag(10003)
        -- local magicTip  = display.newSprite(PIC_text_magicTip)
        -- magicTip:setPosition(self.propEnoughBG:getContentSize().width/2,self.propEnoughBG:getContentSize().height - magicTip:getContentSize().height/2 - 10)
        local rechargeTipText  = cc.ui.UILabel.new({text=DATA_text_MAG, 
        color= cc.c3b(99, 49, 16), 
        size=23,
        })
        rechargeTipText:setPosition(self:getContentSize().width/2-125,self.propEnoughBG:getContentSize().height/2+30)

        for i =1,5 do
            local starSprite = star.new(i)

            starSprite:setScale(2/3)
            starSprite:setPosition(i*120,self.propEnoughBG:getContentSize().height/2 - 10)
            self.propEnoughBG:addChild(starSprite)
            starSprite:setTag(i)

            starSprite:setTouchEnabled(true)
            starSprite:addNodeEventListener(cc.NODE_TOUCH_EVENT,  
                                                    function(event) 
                                                        for i = 1 ,5 do
                                                             self.propEnoughBG:getChildByTag(i):removeAllChildren()
                                                        end
                                                        local starTemp = self.propEnoughBG:getChildByTag(i)
                                                        local frame = display.newSprite(PIC_icon_frame)
                                                        frame:setPosition(starTemp:getContentSize().width/2,starTemp:getContentSize().height/2)
                                                        starTemp:addChild(frame)
                                                        if magicCallBack ~= nil then
                                                            self.grayShade:setTouchEnabled(false)
                                                            magicCallBack(true,starSprite:getColor()) 
                                                        end
                                                    end)
        end

        self.propEnoughBG:addChild(rechargeTipText)
        self.grayShade:addChild(self.propEnoughBG)
        self:addChild(self.grayShade)

        local closeButton = display.newSprite(PIC_icon_close2)
        closeButton:setPosition(self.propEnoughBG:getContentSize().width - closeButton:getContentSize().width+30,self.propEnoughBG:getContentSize().height - closeButton:getContentSize().height+40 )
        closeButton:setScale(3/2)
        closeButton:setTouchEnabled(true)
        closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) magicCallBack(false) self.grayShade:removeSelf()  end)

        self.propEnoughBG:addChild(closeButton)

        transition.execute(self.propEnoughBG, cc.MoveTo:create(DATA_time_moveStar, cc.p(self:getContentSize().width/2, self.propEnoughBG:getContentSize().height/2)), {})


        -- if UserData:getMagicNum() <=0 and UserData:getDiamondNum() >= DATA_magic_cost then

        --     local diamond = display.newSprite(PIC_icon_diamond)
        --     diamond:setPosition(self.propEnoughBG:getContentSize().width/2+diamond:getContentSize().width/2+55,self.propEnoughBG:getContentSize().height + 23)
        --     diamond:setScale(0.5)

        --     local awardScoreText  = ui.newTTFLabel({text=DATA_text_XH..DATA_magic_cost..DATA_text_GZS, 
        --     color= cc.c3b(255, 255, 255), 
        --     size=30,
        --     })
        --     awardScoreText:setPosition(self.propEnoughBG:getContentSize().width/2 - diamond:getContentSize().width/2+20,self.propEnoughBG:getContentSize().height + 23)
        --     self.propEnoughBG:addChild(awardScoreText)
        --     self.propEnoughBG:addChild(diamond)
        -- end

        -- magicCallBack(isMagic,color)

    end
end

function gameSceneBottom:useBomb(bombCallBack)
    if UserData:getBombNum() <=0 and UserData:getDiamondNum() < DATA_magic_cost then 
        DataStat:stat(DATA_count_gameSceneGiftBag[5])
        self:newGiftBag()
    else
        if self.isSelectBomb == true then
            self.isSelectBomb = false
            bombCallBack(false)
            self:removeBombText()
            self:stopPopBomb()
            return 
        else
            self.isSelectBomb = true
            self:popBomb()
        end
        
        if bombCallBack~=nil then
        self.bombText  = cc.ui.UILabel.new({
                text=DATA_text_XC3X3, 
                color= cc.c3b(255, 255, 255), 
                size=30,
            })
            self.bombText:setAnchorPoint(0.5,0.5)
            self.bombText:setPosition(self:getContentSize().width/2,display.cy)
            self:addChild(self.bombText)


            bombCallBack(true)
        end
        

    end
end

function gameSceneBottom:stopPopBomb(  )
    self.bomb:stopAllActions()
    self.bomb:setScale(0.9)
    self.isSelectBomb = false
end

function gameSceneBottom:popBomb()
       
            local sequence = transition.sequence({
                    cc.ScaleTo:create(DATA_time_giftBagChangeInterval, 1.2,1.2),
                    cc.ScaleTo:create(DATA_time_giftBagChangeInterval, 0.9,0.9),
                    })
            self.bomb:runAction(cc.RepeatForever:create(sequence)); 
    end

function gameSceneBottom:removeBombText( bombCallBack )
    if self.bombText ~= nil then
        self.bombText:removeSelf()
        self.bombText = nil
    end
    if bombCallBack ~= nil then
        bombCallBack(false)
    end
    if self.isSelectBomb ~= false then
        self:stopPopBomb()
    end
end


function gameSceneBottom:addDiammond(diamondCallBack,KindView)
    if KindView~= nil and KindView == Kind_view.finallyScene then 
        DataStat:stat(DATA_count_finallySceneGiftBag[3])
    else 
        DataStat:stat(DATA_count_gameSceneGiftBag[3])
    end
    self:newGiftBag()
    if diamondCallBack~=nil then
        diamondCallBack()
    end
end

function gameSceneBottom:useRefresh(refreshCallBack)
    if UserData:getRefreshNum() <=0 and UserData:getDiamondNum() < DATA_refresh_cost then 
        DataStat:stat(DATA_count_gameSceneGiftBag[4])
            self:newGiftBag()
    else
        refreshCallBack()
    end
   
end

function gameSceneBottom:removeMagicPropBG()
    if self.propEnoughBG ~= nil then
        self.propEnoughBG:removeSelf()
        self.grayShade:removeSelf()
        self.propEnoughBG = nil 
    end
end

return gameSceneBottom