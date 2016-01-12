
require("config")
require("cocos.init")
require("framework.init")

local MyApp = class("MyApp", cc.mvc.AppBase)
mid = nil
function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
   cc.FileUtils:getInstance():addSearchPath("res/")
    display.addSpriteFrames("Main/bgs/mainStar1.plist", "Main/bgs/mainStar1.png")
    display.addSpriteFrames("Main/mainStar.plist", "Main/mainStar.png")
    display.addSpriteFrames("Effect/effectStaining.plist", "Effect/effectStaining.png")
    self:enterScene("LoginScene")
end

function MyApp:enterGameScene()
    self:enterScene("GameScene", nil, "fade", 0.6, display.COLOR_WHITE)
end

function MyApp:enterLoginScene()
    self:enterScene("LoginScene", nil, "fade", 0.6, display.COLOR_WHITE)
end

return MyApp
