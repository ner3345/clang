import("..resource.ImportAllRes")
local MobileMMSdk = import("..SDK.MobileMM")
local shade = import("..effect.shade")
local giftBag = import(".giftBag")
local BubbleButton = import("..views.BubbleButton")
local Store = import("framework.cc.sdk.Store")
local shop = class("shop",function() return display.newNode() end)
local loading = import("..effect.loading")

function shop:ctor(gameSceneBottomView,selectKind,entrance)
    -- MobileMMSdk:init()
    self.pro = proPrice['products']
    self.gameSceneBottomView = gameSceneBottomView
    self.entrance = entrance
    self:countKind()
    self.package = false
    local grayShade = shade:createGrayShade()
    
    local bg = display.newSprite(PIC_bg_shopBG)
    bg:setPosition(display.width/2,display.height/2 -65)
    bg:setScale(1.5)

    --title
    local shopText = display.newSprite(PIC_text_shopText)
    shopText:setPosition(bg:getContentSize().width/2,bg:getContentSize().height - shopText:getContentSize().height/2 - 32 )
    
    local closeButton = display.newSprite(PIC_icon_close2)
    closeButton:setPosition(bg:getContentSize().width - closeButton:getContentSize().width/2 - 5,bg:getContentSize().height - closeButton:getContentSize().height/2 -5 )
    closeButton:setTouchEnabled(true)
    closeButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:removeSelf() end)


    local myBagText = display.newSprite(PIC_text_myBag)
    myBagText:setPosition(bg:getContentSize().width*0.15,bg:getContentSize().height*0.842 )

    local diamond = display.newSprite(PIC_icon_diamond)
    diamond:setPosition(145,bg:getContentSize().height*0.842 )
    diamond:setScale(0.5)

    self.diamondNum  = cc.LabelAtlas:_create(UserData:getDiamondNum(),PIC_num_whiteSquare, 11, 17, string.byte("0"))
    self.diamondNum:setPosition(170,bg:getContentSize().height*0.827 )

    local magic = display.newSprite(PIC_icon_magic)
    magic:setPosition(220,bg:getContentSize().height*0.842 )
    magic:setScale(0.4)

    self.magicNum  = cc.LabelAtlas:_create(UserData:getMagicNum(),PIC_num_whiteSquare, 11, 17, string.byte("0"))
    self.magicNum:setPosition(245,bg:getContentSize().height*0.827 )

    local refresh = display.newSprite(PIC_icon_refresh)
    refresh:setPosition(290,bg:getContentSize().height*0.842 )
    refresh:setScale(0.5)

    self.refreshNum = cc.LabelAtlas:_create(UserData:getRefreshNum(),PIC_num_whiteSquare, 11, 17, string.byte("0"))
    self.refreshNum:setPosition(315,bg:getContentSize().height*0.827 )

    local bomb = display.newSprite(PIC_icon_bomb)
    bomb:setPosition(370,bg:getContentSize().height*0.84)
    bomb:setScale(0.4)

    self.bombNum = cc.LabelAtlas:_create(UserData:getBombNum(),PIC_num_whiteSquare, 11, 17, string.byte("0"))
    self.bombNum:setPosition(395,bg:getContentSize().height*0.827 )

    local giftBagBg = display.newSprite(PIC_bg_gifBagBG)
    giftBagBg:setPosition(bg:getContentSize().width/2,bg:getContentSize().height*0.75 )
    giftBagBg:setTouchEnabled(true)
    giftBagBg:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
                                                            self:addLoading()
                                                             self:countShop(1)
                                                             MobileMMSdk:payment(DATA_costCode_all.resurGifBag,
                                                                    function() 
                                                                    self.package = true
                                                                    self:gotGiftBag() 
                                                                    self:countShop(2)
                                                                    loading:onButtonClicked(self.loadings)
                                                                    end,function () loading:onButtonClicked(self.loadings) end) 
                                                        end)
    local eightYuanText = BubbleButton.new({image = PIC_text_eightYuan,listener = function (  )
            self:addLoading()
            self:countShop(1)
            MobileMMSdk:payment(DATA_costCode_all.resurGifBag,
                    function()
                    self.package = true
                    self:gotGiftBag() 
                    self:countShop(2)
                    loading:onButtonClicked(self.loadings)
                    end,function () loading:onButtonClicked(self.loadings) end)
        end})
    eightYuanText:setPosition(bg:getContentSize().width*0.8,bg:getContentSize().height*0.77 )
    local PriceText = "CNY12"
    if self.pro ~= nil and table.nums(self.pro) > 0 then
        PriceText = string.sub(self.pro[7]['priceLocale'],-3)..string.format("%0.2f",self.pro[7]['price'])
    end
    local price  = cc.ui.UILabel.new({text=PriceText, 
        color= cc.c3b(255, 255, 255), 
        size=20,
        })
    price:setAnchorPoint(0.5,0.5)
    price:setPosition(eightYuanText:getContentSize().width/2,eightYuanText:getContentSize().height/2)
    eightYuanText:addChild(price)

    if selectKind ~= nil then 
        if selectKind == 1 then 
            self:selectMagicShop(bg)
        else
            self:selectRefreshShop(bg)
        end
    else 
        self:selectDiamondShop(bg)
    end

    local qun  = cc.ui.UILabel.new({text="QQ粉丝群:317048381", 
        color= cc.c3b(255, 255, 255), 
        size=16,
        })
    qun:setPosition(bg:getContentSize().width/2-70,65)

    bg:addChild(qun)
    
    bg:addChild(self.bombNum)
    bg:addChild(bomb)
    bg:addChild(shopText)
    bg:addChild(closeButton)
    bg:addChild(myBagText)
    bg:addChild(diamond)
    bg:addChild(self.diamondNum)
    bg:addChild(magic)
    bg:addChild(self.magicNum)
    bg:addChild(refresh)
    bg:addChild(self.refreshNum)
    bg:addChild(giftBagBg)
    grayShade:addChild(bg)
    self:addChild(grayShade)
    bg:addChild(eightYuanText,1)
end

function shop:addLoading(  )
    self.loadings = loading:createGrayloading()
    self:addChild(self.loadings,1)
    loading:createBlendloading(self.loadings,self)
end

function shop:selectDiamondShop(bg)
   
    if bg:getChildByTag(1) ~= nil then 
        return
    end
    if bg:getChildByTag(2) ~= nil then
        bg:getChildByTag(2):removeSelf()
    end
    if bg:getChildByTag(3) ~= nil then
        bg:getChildByTag(3):removeSelf()
    end
    if bg:getChildByTag(4) ~= nil then
        bg:getChildByTag(4):removeSelf()
    end

    local diamondContentBG = display.newSprite(PIC_bg_diamondContent)
    diamondContentBG:setPosition(bg:getContentSize().width/2 ,bg:getContentSize().height*0.33-1)

    local diamondButton  = display.newSprite(PIC_buttom_yellowMatrix)
    diamondButton:setPosition(diamondButton:getContentSize().width/2 - 4,diamondContentBG:getContentSize().height+diamondButton:getContentSize().height/2 + 19 )

    local magicButton  = display.newSprite(PIC_buttom_redMatrix)
    magicButton:setPosition(diamondButton:getContentSize().width - 7 + magicButton:getContentSize().width/2,diamondContentBG:getContentSize().height+magicButton:getContentSize().height/2 + 19)

    local refreshButton  = display.newSprite(PIC_buttom_redMatrix)
    refreshButton:setPosition(diamondButton:getContentSize().width*2 - 9 + refreshButton:getContentSize().width/2,diamondContentBG:getContentSize().height+refreshButton:getContentSize().height/2 + 19)
    
    local bombButton = display.newSprite(PIC_buttom_redMatrix)
    bombButton:setPosition(diamondButton:getContentSize().width*3 + 39,diamondContentBG:getContentSize().height+refreshButton:getContentSize().height/2 + 19)
    
    local diamondText   = display.newSprite(PIC_text_diamond)
    diamondText:setPosition(diamondButton:getContentSize().width/2,diamondButton:getContentSize().height/2 + 3)

    local magicText = display.newSprite(PIC_text_magic)
    magicText:setPosition(magicButton:getContentSize().width/2,magicButton:getContentSize().height/2 + 3)

    local refreshText = display.newSprite(PIC_text_refrest)
    refreshText:setPosition(refreshButton:getContentSize().width/2,refreshButton:getContentSize().height/2 + 3)

    local bombText = display.newSprite(PIC_text_bomb)
    bombText:setPosition(bombButton:getContentSize().width/2,bombButton:getContentSize().height/2 + 3)
    bombButton:addChild(bombText)
    diamondContentBG:addChild(bombButton)

    local giveAwayText = display.newSprite(PIC_text_giveAwayRed):align(display.CENTER,165,80)
    diamondContentBG:addChild(giveAwayText)
    --diamondContentBG:addChild(display.newSprite(PIC_text_giveAway):align(display.CENTER,175,157))
    --diamondContentBG:addChild(display.newSprite(PIC_text_giveAwayRed):align(display.CENTER,175,219))
    --diamondContentBG:addChild(display.newSprite(PIC_text_giveAway):align(display.CENTER,175,281))
    local sequence = transition.sequence({
            cc.ScaleTo:create(DATA_time_giftBagChangeInterval, 1.2,1.2),
            cc.ScaleTo:create(DATA_time_giftBagChangeInterval, 0.8,0.8),
            })
    giveAwayText:runAction(cc.RepeatForever:create(sequence))

    local fontSize = 19
    for i=1,5 do 
        local RMBButton = BubbleButton.new({image = PIC_button_shopDiamond, --display.newSprite(PIC_button_shopDiamond)
        listener = function (  )
            if proPrice['errorCode']~=nil and proPrice['errorCode'] == 0 then
               device.showAlert("初始化失败", "请检查网络后重新启动游戏", {"确认"} , nil)
            end
            self:addLoading()
            self:countShop(2*i+1)
            self:buyDiamond(DATA_costCode_all[i],function() 
                    self:updateProp("diamond",DAtA_diamond_shop[i]) 
                    self:countShop(2*i+2)
                    loading:onButtonClicked(self.loadings)
            end,function () loading:onButtonClicked(self.loadings) end)
        end})
        
        local pri = {}
        if self.pro ~= nil and table.nums(self.pro) > 0 then
            -- pri =string.format("%0.3s",self.pro[i]['priceLocale'])..string.format("%0.2f",self.pro[i]['price'])
            pri = string.sub(self.pro[i]['priceLocale'],-3)..string.format("%0.2f",self.pro[i]['price'])
            fontSize = 18
        else
            pri ="CNY"..DATA_RMB_costList[i]
        end
        local price  = cc.ui.UILabel.new({text=pri, 
        color= cc.c3b(30, 73, 40), 
        size=fontSize,
        })
        price:setAnchorPoint(0.5,0.5)
        price:setPosition(RMBButton:getContentSize().width/2,RMBButton:getContentSize().height/2)

        RMBButton:align(display.CENTER,340,340 - (i-1)*66)
        RMBButton:setTouchEnabled(true)
        RMBButton:addChild(price)
        diamondContentBG:addChild(RMBButton)
    end

    diamondButton:addChild(diamondText)
    magicButton:addChild(magicText)
    refreshButton:addChild(refreshText)
    diamondContentBG:addChild(refreshButton)
    diamondContentBG:addChild(magicButton)
    diamondContentBG:addChild(diamondButton)
    bg:addChild(diamondContentBG)
    diamondContentBG:setTag(1)

    magicButton:setTouchEnabled(true)
    magicButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectMagicShop(bg) end)

    diamondButton:setTouchEnabled(true)
    diamondButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectDiamondShop(bg) end)

    refreshButton:setTouchEnabled(true)
    refreshButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectRefreshShop(bg) end)

    bombButton:setTouchEnabled(true)
    bombButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectBombShop(bg) end)

end

function shop:selectMagicShop(bg)
    if bg:getChildByTag(2) ~= nil then 
        return
    end
    if bg:getChildByTag(1) ~= nil then
        bg:getChildByTag(1):removeSelf()
    end
    if bg:getChildByTag(3) ~= nil then
        bg:getChildByTag(3):removeSelf()
    end
    if bg:getChildByTag(4) ~= nil then
        bg:getChildByTag(4):removeSelf()
    end

    local diamondContentBG = display.newSprite(PIC_bg_magicContent)
    diamondContentBG:setPosition(bg:getContentSize().width/2 ,bg:getContentSize().height*0.33)

    local diamondButton  = display.newSprite(PIC_buttom_redMatrix)
    diamondButton:setPosition(diamondButton:getContentSize().width/2 - 4,diamondContentBG:getContentSize().height+diamondButton:getContentSize().height/2 +18 )

    local magicButton  = display.newSprite(PIC_buttom_yellowMatrix)
    magicButton:setPosition(diamondButton:getContentSize().width - 7 + magicButton:getContentSize().width/2,diamondContentBG:getContentSize().height+magicButton:getContentSize().height/2 +18)

    local refreshButton  = display.newSprite(PIC_buttom_redMatrix)
    refreshButton:setPosition(diamondButton:getContentSize().width*2 - 9 + refreshButton:getContentSize().width/2,diamondContentBG:getContentSize().height+refreshButton:getContentSize().height/2 +18)
    
    local bombButton = display.newSprite(PIC_buttom_redMatrix)
    bombButton:setPosition(diamondButton:getContentSize().width*3 + 39,diamondContentBG:getContentSize().height+refreshButton:getContentSize().height/2 +18)
    
    local diamondText   = display.newSprite(PIC_text_diamond)
    diamondText:setPosition(diamondButton:getContentSize().width/2,diamondButton:getContentSize().height/2 + 3)

    local magicText = display.newSprite(PIC_text_magic)
    magicText:setPosition(magicButton:getContentSize().width/2,magicButton:getContentSize().height/2 + 3)

    local refreshText = display.newSprite(PIC_text_refrest)
    refreshText:setPosition(refreshButton:getContentSize().width/2,refreshButton:getContentSize().height/2 + 3)

    local bombText = display.newSprite(PIC_text_bomb)
    bombText:setPosition(bombButton:getContentSize().width/2,bombButton:getContentSize().height/2 + 3)
    bombButton:addChild(bombText)
    diamondContentBG:addChild(bombButton)

    for i=1,5 do 
        local RMBButton = display.newSprite(PIC_button_shopGoods)
        local price  = cc.ui.UILabel.new({text=DATA_diamond_magicCost[i]..DATA_text_GZS, 
        color= cc.c3b(30, 73, 40), 
        size=19,
        })
        price:setPosition(RMBButton:getContentSize().width/2-30,RMBButton:getContentSize().height/2)
        RMBButton:align(display.CENTER,320,340 - (i-1)*66)
        RMBButton:setTouchEnabled(true)
        RMBButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
                                        function(event) 
                                            if(DATA_diamond_magicCost[i]<=UserData:getDiamondNum()) then 
                                                self:updateProp("magic",DATA_diamond_shopMagicList[i],DATA_diamond_magicCost[i])
                                            else 
                                                -- self:selectDiamondShop(bg)
                                                self:addChild(giftBag.new(function (  ) self:gotGiftBag() end,function (  ) self:selectDiamondShop(bg) end,Kind_view.shops))
                                            end
                                        end)
        RMBButton:addChild(price)
        diamondContentBG:addChild(RMBButton)
    end


    diamondButton:addChild(diamondText)
    magicButton:addChild(magicText)
    refreshButton:addChild(refreshText)
    diamondContentBG:addChild(refreshButton)
    diamondContentBG:addChild(magicButton)
    diamondContentBG:addChild(diamondButton)
    bg:addChild(diamondContentBG)
    diamondContentBG:setTag(2)

    magicButton:setTouchEnabled(true)
    magicButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectMagicShop(bg) end)

    diamondButton:setTouchEnabled(true)
    diamondButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectDiamondShop(bg) end)

    refreshButton:setTouchEnabled(true)
    refreshButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectRefreshShop(bg) end)

    bombButton:setTouchEnabled(true)
    bombButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectBombShop(bg) end)
end

function shop:selectRefreshShop(bg)
    if bg:getChildByTag(3) ~= nil then 
        return
    end
    if bg:getChildByTag(4) ~= nil then
        bg:getChildByTag(4):removeSelf()
    end
    if bg:getChildByTag(2) ~= nil then
        bg:getChildByTag(2):removeSelf()
    end
    if bg:getChildByTag(1) ~= nil then
        bg:getChildByTag(1):removeSelf()
    end

    local diamondContentBG = display.newSprite(PIC_bg_refreshContent)
    diamondContentBG:setPosition(bg:getContentSize().width/2 ,bg:getContentSize().height*0.33)

    local diamondButton  = display.newSprite(PIC_buttom_redMatrix)
    diamondButton:setPosition(diamondButton:getContentSize().width/2 - 4,diamondContentBG:getContentSize().height+diamondButton:getContentSize().height/2 +18 )

    local magicButton  = display.newSprite(PIC_buttom_redMatrix)
    magicButton:setPosition(diamondButton:getContentSize().width - 7 + magicButton:getContentSize().width/2,diamondContentBG:getContentSize().height+magicButton:getContentSize().height/2 +18)

    local refreshButton  = display.newSprite(PIC_buttom_yellowMatrix)
    refreshButton:setPosition(diamondButton:getContentSize().width*2 - 9 + refreshButton:getContentSize().width/2,diamondContentBG:getContentSize().height+refreshButton:getContentSize().height/2 +18)
    
    local bombButton = display.newSprite(PIC_buttom_redMatrix)
    bombButton:setPosition(diamondButton:getContentSize().width*3 + 39,diamondContentBG:getContentSize().height+refreshButton:getContentSize().height/2 +18)
    
    local diamondText   = display.newSprite(PIC_text_diamond)
    diamondText:setPosition(diamondButton:getContentSize().width/2,diamondButton:getContentSize().height/2 + 3)

    local magicText = display.newSprite(PIC_text_magic)
    magicText:setPosition(magicButton:getContentSize().width/2,magicButton:getContentSize().height/2 + 3)

    local refreshText = display.newSprite(PIC_text_refrest)
    refreshText:setPosition(refreshButton:getContentSize().width/2,refreshButton:getContentSize().height/2 + 3)

    local bombText = display.newSprite(PIC_text_bomb)
    bombText:setPosition(bombButton:getContentSize().width/2,bombButton:getContentSize().height/2 + 3)
    bombButton:addChild(bombText)
    diamondContentBG:addChild(bombButton)

    for i=1,5 do 
        local RMBButton = display.newSprite(PIC_button_shopGoods)
        local price  = cc.ui.UILabel.new({text=DATA_diamond_magicCost[i]..DATA_text_GZS, 
        color= cc.c3b(30, 73, 40), 
        size=19,
        })
        price:setPosition(RMBButton:getContentSize().width/2-30,RMBButton:getContentSize().height/2)
        RMBButton:align(display.CENTER,320,340 - (i-1)*66)
        RMBButton:setTouchEnabled(true)
        RMBButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
                                        function(event) 
                                            if(DATA_diamond_refreshCost[i]<=UserData:getDiamondNum()) then 
                                                self:updateProp("refresh",DATA_diamond_shopRefreshList[i],DATA_diamond_refreshCost[i])
                                            else 
                                                -- self:selectDiamondShop(bg)
                                                self:addChild(giftBag.new(function (  ) self:gotGiftBag() end,function (  ) self:selectDiamondShop(bg) end,Kind_view.shops))
                                            end
                                        end)
        RMBButton:addChild(price)
        diamondContentBG:addChild(RMBButton)
    end


    diamondButton:addChild(diamondText)
    magicButton:addChild(magicText)
    refreshButton:addChild(refreshText)
    diamondContentBG:addChild(refreshButton)
    diamondContentBG:addChild(magicButton)
    diamondContentBG:addChild(diamondButton)
    bg:addChild(diamondContentBG)
    diamondContentBG:setTag(3)

    magicButton:setTouchEnabled(true)
    magicButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectMagicShop(bg) end)

    diamondButton:setTouchEnabled(true)
    diamondButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectDiamondShop(bg) end)

    refreshButton:setTouchEnabled(true)
    refreshButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectRefreshShop(bg) end)

    bombButton:setTouchEnabled(true)
    bombButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectBombShop(bg) end)
end

function shop:selectBombShop(bg)
    if bg:getChildByTag(4) ~= nil then 
        return
    end
    if bg:getChildByTag(3) ~= nil then
        bg:getChildByTag(3):removeSelf()
    end
    if bg:getChildByTag(2) ~= nil then
        bg:getChildByTag(2):removeSelf()
    end
    if bg:getChildByTag(1) ~= nil then
        bg:getChildByTag(1):removeSelf()
    end

    local diamondContentBG = display.newSprite(PIC_bg_bombContent)
    diamondContentBG:setPosition(bg:getContentSize().width/2 ,bg:getContentSize().height*0.33)

    local diamondButton  = display.newSprite(PIC_buttom_redMatrix)
    diamondButton:setPosition(diamondButton:getContentSize().width/2 - 4,diamondContentBG:getContentSize().height+diamondButton:getContentSize().height/2 +18 )

    local magicButton  = display.newSprite(PIC_buttom_redMatrix)
    magicButton:setPosition(diamondButton:getContentSize().width - 7 + magicButton:getContentSize().width/2,diamondContentBG:getContentSize().height+magicButton:getContentSize().height/2 +18)

    local refreshButton  = display.newSprite(PIC_buttom_redMatrix)
    refreshButton:setPosition(diamondButton:getContentSize().width*2 - 9 + refreshButton:getContentSize().width/2,diamondContentBG:getContentSize().height+refreshButton:getContentSize().height/2 +18)
    
    local bombButton = display.newSprite(PIC_buttom_yellowMatrix)
    bombButton:setPosition(diamondButton:getContentSize().width*3 + 39,diamondContentBG:getContentSize().height+refreshButton:getContentSize().height/2 +18)
    
    local diamondText   = display.newSprite(PIC_text_diamond)
    diamondText:setPosition(diamondButton:getContentSize().width/2,diamondButton:getContentSize().height/2 + 3)

    local magicText = display.newSprite(PIC_text_magic)
    magicText:setPosition(magicButton:getContentSize().width/2,magicButton:getContentSize().height/2 + 3)

    local refreshText = display.newSprite(PIC_text_refrest)
    refreshText:setPosition(refreshButton:getContentSize().width/2,refreshButton:getContentSize().height/2 + 3)

    local bombText = display.newSprite(PIC_text_bomb)
    bombText:setPosition(bombButton:getContentSize().width/2,bombButton:getContentSize().height/2 + 3)
    bombButton:addChild(bombText)
    diamondContentBG:addChild(bombButton)

    for i=1,5 do 
        local RMBButton = display.newSprite(PIC_button_shopGoods)
        local price  = cc.ui.UILabel.new({text=DATA_diamond_magicCost[i]..DATA_text_GZS, 
        color= cc.c3b(30, 73, 40), 
        size=19,
        })
        price:setPosition(RMBButton:getContentSize().width/2-30,RMBButton:getContentSize().height/2)
        RMBButton:align(display.CENTER,320,340 - (i-1)*66)
        RMBButton:setTouchEnabled(true)
        RMBButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
                                        function(event) 
                                            if(DATA_diamond_bombCost[i]<=UserData:getDiamondNum()) then 
                                                self:updateProp("bomb",DATA_diamond_shopBombList[i],DATA_diamond_bombCost[i])
                                            else 
                                                -- self:selectDiamondShop(bg)
                                                self:addChild(giftBag.new(function (  ) self:gotGiftBag() end,function (  ) self:selectDiamondShop(bg) end,Kind_view.shops))
                                            end
                                        end)
        RMBButton:addChild(price)
        diamondContentBG:addChild(RMBButton)
    end


    diamondButton:addChild(diamondText)
    magicButton:addChild(magicText)
    refreshButton:addChild(refreshText)
    diamondContentBG:addChild(refreshButton)
    diamondContentBG:addChild(magicButton)
    diamondContentBG:addChild(diamondButton)
    bg:addChild(diamondContentBG)
    diamondContentBG:setTag(4)

    magicButton:setTouchEnabled(true)
    magicButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectMagicShop(bg) end)

    diamondButton:setTouchEnabled(true)
    diamondButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectDiamondShop(bg) end)

    refreshButton:setTouchEnabled(true)
    refreshButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectRefreshShop(bg) end)

    bombButton:setTouchEnabled(true)
    bombButton:addNodeEventListener(cc.NODE_TOUCH_EVENT,  function(event) utility:playSound(Music_enterButton) self:selectBombShop(bg) end)
end

function shop:buyDiamond(costCode,sucessCallBack,failCallBack)
    orderId = string.format("%02d",costCode)
    MobileMMSdk:payment(orderId,sucessCallBack,failCallBack)
end

function shop:updateProp(kind,propNum,cost)
    if kind == "diamond" then 
        UserData:setDiamondNum(UserData:getDiamondNum() + propNum)
        self.diamondNum:setString(UserData:getDiamondNum())

        if self.gameSceneBottomView~=nil then 
            self.gameSceneBottomView:setDiamondNumShow(propNum)
        end
    end

    if kind == "magic" then
        UserData:setDiamondNum(UserData:getDiamondNum() - cost)
        UserData:setMagicNum(UserData:getMagicNum() + propNum)
        self.magicNum:setString(UserData:getMagicNum())
        self.diamondNum:setString(UserData:getDiamondNum())
        if self.gameSceneBottomView~=nil then 
            self.gameSceneBottomView:setMagicNumShow(propNum)
            self.gameSceneBottomView:setDiamondNumShow(- cost)
        end
    end

    if kind == "refresh" then
        UserData:setDiamondNum(UserData:getDiamondNum() - cost)
        UserData:setRefreshNum(UserData:getRefreshNum() + propNum)
        self.refreshNum:setString(UserData:getRefreshNum())
        self.diamondNum:setString(UserData:getDiamondNum())
        if self.gameSceneBottomView~=nil then 
            self.gameSceneBottomView:setRefreshNum(propNum)
            self.gameSceneBottomView:setDiamondNumShow(- cost)
        end
    end

    if kind == "bomb" then
        UserData:setDiamondNum(UserData:getDiamondNum() - cost)
        UserData:setBombNum(UserData:getBombNum() + propNum)
        self.bombNum:setString(UserData:getBombNum())
        self.diamondNum:setString(UserData:getDiamondNum())
        if self.gameSceneBottomView~=nil then 
            self.gameSceneBottomView:setBombNum(propNum)
            self.gameSceneBottomView:setDiamondNumShow(- cost)
        end
    end
end

function shop:gotGiftBag(getCallBack)
    if self.package == true then
        UserData:addProp(DATA_num_giftBagProp[1],DATA_num_giftBagProp[2],DATA_num_giftBagProp[3],DATA_num_giftBagProp[4])
        self.package = false
    end
    self.refreshNum:setString(UserData:getRefreshNum())
    self.diamondNum:setString(UserData:getDiamondNum())
    self.magicNum:setString(UserData:getMagicNum())
    self.bombNum:setString(UserData:getBombNum())
    if self.gameSceneBottomView ~= nil then
        self.gameSceneBottomView:setDiamondNumShow(DATA_num_giftBagProp[1])
        self.gameSceneBottomView:setMagicNumShow(DATA_num_giftBagProp[2])
        self.gameSceneBottomView:setRefreshNum(DATA_num_giftBagProp[3])
        self.gameSceneBottomView:setBombNum(DATA_num_giftBagProp[4])
    end
end

function shop:countKind()
    if self.entrance ~= nil then
        if self.entrance == Kind_view.loginScene then
            self.countList = DATA_count_LoginSceneShop
        end
        if self.entrance == Kind_view.gameScene then
            self.countList = DATA_count_gameSceneShop
        end
        if self.entrance == Kind_view.gameOver then
            self.countList = DATA_count_gameSceneShop
        end
    end
end

function shop:countShop(countEvent)
    if self.entrance ~= nil then 
        DataStat:stat(self.countList[countEvent])
    end
end

return shop