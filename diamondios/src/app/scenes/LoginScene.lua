local loginSceneTop = import("..views.loginSceneTop")
local loginSceneMiddle = import("..views.loginSceneMiddle")
local loginSceneBottom = import("..views.loginSceneBottom")
local CDKey =import("..views.CDKey")
local shop = import("..views.shop")
local help = import("..views.help")
local move = import("..effect.move")
utility = import("..sprite.utility")
local MobileMMSdk = import("..SDK.MobileMM")
local giftBag = import("..views.giftBag")
local thinkFulBag = import("..views.thinkFulBag")
local continueReword = import("..views.continueReword")
local notice =import("..views.notice")
local shade = import("..effect.shade")
local exit  = import("..views.Exit")
local partical = import("..effect.partical")
local scheduler = require("framework.scheduler")
local update = import("..views.update")

DataStat = import("..SDK.DataStat")
import("..resource.Music")


UserData = import("..resource.UserData")
continueLoginDay = nil
continueLoginPrizeList = nil
import("..resource.ImportAllRes")


local LoginScene = class("LoginScene", function()
    return display.newScene("LoginScene")
end)

function LoginScene:ctor()
    local updateResidueTime = function()
        math.randomseed(os.time())
        local count = math.random(1, DATA_count_fireWorkAllAtOnce)
        for i=1 ,count do
            local onceTime =  math.random(0, 100)/100
            self:performWithDelay( function()
                                        local a = partical:createCakesPartical()
                                        local x = 0
                                        local y = 650
                                        local xIncrementer = math.random(1,720)
                                        local yIncrementer = math.random(1,630)
                                        x = xIncrementer + x
                                        y = yIncrementer + y
                                        a:setPosition(x,y)
                                        self:addChild(a,10000) 
                                    end , onceTime )
        end
    end

    self.residueTimehandle = scheduler.scheduleGlobal(handler(self,updateResidueTime), 1.0)
   

    UserData:init()
    if UserData:getIsFirstGame() ~= 1 then 
        self:musicCallBack()
        self:soundCallBack()
    end
    utility:playMusic(Music_bg)

    MobileMMSdk:init()

    self:setKeypadEnabled(true)
    self:addNodeEventListener(cc.KEYPAD_EVENT, function(event)
        if event.key == "back" then
            if self:getChildByTag(10000) == nil then
                local callBack = function()
                    if UserData:getIsFirstGuid() ~= 1 then 
                        utility:createEnterGame(true, DATA_matrix_row, DATA_matrix_col)
                        utility:setGuidGame()
                        utility:playSound(Music_startGame) 
                    else    
                        utility:createEnterGame(false, DATA_matrix_row, DATA_matrix_col) 
                        utility:playSound(Music_startGame) 
                    end
                end
                self:addChild(exit.new(callBack,100,10000))
            end
        end
    end)

    self:NovicePackage()
    self:initData()
    self:initViews()
end

function LoginScene:NovicePackage()
      
    if UserData:getIsFirstGame() ~= 1 then 
        local grayShade = shade:createGrayShade()
        local novicePackage = display.newSprite(PIC_bg_novicePackage)
        novicePackage:setPosition(self:getContentSize().width/2,self:getContentSize().height/2)
        novicePackage:setScale(1.5)

        local getButton = display.newSprite(PIC_button_novicePackage)
        getButton:setPosition(novicePackage:getContentSize().width/2,novicePackage:getContentSize().height*0.2)

        novicePackage:addChild(getButton)
        grayShade:addChild(novicePackage)
        self:addChild(grayShade,100)

        local getPackage = function() 
                                      UserData:SetIsFirstGame(1)
                                      UserData:addProp(10,3,3,3)
                                      grayShade:removeSelf()
                                end

        getButton:setTouchEnabled(true)
        getButton:addNodeEventListener(cc.NODE_TOUCH_EVENT, getPackage )
    end
end

function LoginScene:initData()
    -- utility:updateApp(self)

    self.isCent = nil
    local registerCallback = function(params)
        dump(params)
        mid = params.data.mid
        isnotice = params.data.notice

        local createNoticeCallBack = function() 
                                            self:createNoticeView(isnotice) 
                                        end 

        -- continueLoginDay  = params.data.login_day
        self.isCent = params.data.cent
        self:thinkFulBag()
        -- if params.data.is_reward ~= 1 then 

        --     local getContinueLoginPrizeList = function(params)
        --             dump(params)
        --             continueLoginPrizeList = params.data

        --             local getContinueLoginDay = function(params)
        --                 self:createContinueRewordView(createNoticeCallBack)
        --             end

        --             utility:getContinueLoginDay(getContinueLoginDay)

        --     end
        --     utility:getContinueLoginRewordList(getContinueLoginPrizeList)
        -- end
    end
    utility:login(registerCallback)
    function cback( event )
        LoginScene:oc_callback(event,successCallBack,failCallBack)
    end
    --local ok,ret = luaoc.callStaticMethod("AppController", "addScriptListener",{listener = cback})
    --print(ok,ret)
end

function LoginScene:initViews()

    local bg = display.newSprite(PIC_bg_sceneBG)
    bg:setPosition(display.cx,display.cy)

    local topView = loginSceneTop.new(UserData:getMaxScore(),function() self:addChild(help.new()) end,function() self:musicCallBack() end,function() self:soundCallBack() end)
    topView:setPosition(display.cx,display.height - 80)
    
    local newGameFun = function() 
                            if UserData:getIsFirstGuid() ~= 1 then 
                                utility:createEnterGame(true, DATA_matrix_row, DATA_matrix_col) 
                                utility:setGuidGame()
                                utility:playSound(Music_startGame) 
                            else    
                                utility:createEnterGame(true, DATA_matrix_row, DATA_matrix_col) 
                                utility:playSound(Music_startGame) 
                            end
                        end
    local loginSceneMiddleViews = loginSceneMiddle.new(utility:jurgeHasSaveGame(), newGameFun , function() utility:createEnterGame(false,DATA_matrix_row, DATA_matrix_col) utility:playSound(Music_startGame) end )
    loginSceneMiddleViews:setPosition(display.cx,display.cy)
    
    local bottomViews = loginSceneBottom.new(function() 
                                                self:addChild(shop.new(nil,nil,Kind_view.loginScene)) end,function() self:addChild(CDKey.new()) end)
    bottomViews:setPosition(display.cx,95)
   

    local giftBagIcon = display.newSprite(PIC_icon_giftBag)
    giftBagIcon:setScale(0.8)
    giftBagIcon:setPosition(display.cx+250 , display.cy)
    giftBagIcon:setTouchEnabled(true)
    giftBagIcon:addNodeEventListener(cc.NODE_TOUCH_EVENT,  
                                                function(event) 
                                                    DataStat:stat(DATA_count_loginSceneGiftBag[3])
                                                    utility:playSound(Music_enterButton) 
                                                    self:addChild(giftBag.new(nil,nil,Kind_view.loginScene)) 
                                                end)

    self:addChild(bg)
    self:addChild(topView)
    self:addChild(loginSceneMiddleViews)
    self:addChild(bottomViews)
    self:addChild(giftBagIcon)

   
    local sequence = transition.sequence({
            cc.ScaleTo:create(DATA_time_giftBagChangeInterval, 0.8,0.8),
            cc.ScaleTo:create(DATA_time_giftBagChangeInterval, 0.5,0.5),
            })
    giftBagIcon:runAction(cc.RepeatForever:create(sequence)); 

end

function LoginScene:createContinueRewordView(createNoticeCallBack)
    local params = {}
    params.day = continueLoginDay
    params.rewordList = continueLoginPrizeList
    self:getContinueReword(params)
    self:addChild(continueReword.new(params,createNoticeCallBack))
end

function LoginScene:getContinueReword(params)
    local today = tonumber(params.day)
    local weekReword = {params.rewordList['1'],params.rewordList['2'],params.rewordList['3'],params.rewordList['4'],params.rewordList['5']}
    local diamondNum = nil
    local magicNum = nil 
    local refreshNum = nil

    if weekReword[today][Enum_kind_prop.diamond] ~= nil then
        dimaondNum = weekReword[today][Enum_kind_prop.diamond]
    end  

    if weekReword[today][Enum_kind_prop.magic] ~= nil then
        magicNum = weekReword[today][Enum_kind_prop.magic]
    end 

    if weekReword[today][Enum_kind_prop.refresh] ~= nil then
        refreshNum = weekReword[today][Enum_kind_prop.refresh]
    end 
    
    UserData:addProp(dimaondNum,magicNum,refreshNum)
end

function LoginScene:init()
end
 
function LoginScene:createNoticeView(isNotice)
    if isnotice == 0 then 
        local callBack = function(params)
                            self:addChild(notice.new(params.data))
                         end
        utility:getNotice(callBack)
    end
end

function LoginScene:onEnter()
    -- self:performWithDelay(function()  
    --     utility:updateApp(self)
    -- end, 1)
end

function LoginScene:onExit()
    scheduler.unscheduleGlobal(self.residueTimehandle)
end

function LoginScene:thinkFulBag()
    if self.isCent == 0 and UserData:getIsButThingkFulBag() ~= 1 then
        local thinkFulBagIcon = display.newSprite(PIC_bg_thinkFulBag)
        thinkFulBagIcon:setPosition(display.cx-250 , display.cy)
        thinkFulBagIcon:setTouchEnabled(true)
        thinkFulBagIcon:setScale(1.2)
        thinkFulBagIcon:addNodeEventListener(cc.NODE_TOUCH_EVENT,  
                                                    function(event) 
                                                        utility:playSound(Music_enterButton) 
                                                        self:addChild(thinkFulBag.new(nil,nil,thinkFulBagIcon)) 
                                                    end)
        self:addChild(thinkFulBagIcon)
        local light = display.newSprite(PIC_effect_thinkFulBag)
        light:setPosition(light:getContentSize().width/2 -15,light:getContentSize().height/2-15)

        thinkFulBagIcon:addChild(light,-1)

        move:createSpin(light)
    end

end

function LoginScene:musicCallBack()
    

    local musicState = UserData:getIsMusic()
    if musicState == 0 then 
        self.isMusic = 1
        UserData:setIsMusic(self.isMusic)
        utility:playMusic(Music_bg)
    else 
        self.isMusic = 0
        UserData:setIsMusic(self.isMusic)
        utility:stopMusic()
    end
end

function LoginScene:soundCallBack()
    

    local SoundState = UserData:getIsSound()
    if SoundState == 0 then 
        self.isSound = 1
        UserData:setIsSound(self.isSound)
    else 
        self.isSound = 0
        UserData:setIsSound(self.isSound)
    end
end

return LoginScene

