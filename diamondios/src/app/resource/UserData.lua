
local UserData = class("UserData")
local meta = UserData

function meta:init()

  self.mid = cc.UserDefault:getInstance():getIntegerForKey("Mid")

  self.musicVolume = cc.UserDefault:getInstance():getStringForKey("checkBoxButton_Music",0)
  self.soundVolume = cc.UserDefault:getInstance():getStringForKey("checkBoxButton_Sound",0)
  self.score = cc.UserDefault:getInstance():getIntegerForKey("Score",0)
  self.level = cc.UserDefault:getInstance():getIntegerForKey("Level",0)
  self.maxScore = cc.UserDefault:getInstance():getIntegerForKey("MaxScore",0)
  self.diamondNum = cc.UserDefault:getInstance():getIntegerForKey("DiamondNum",0)
  self.magicNum = cc.UserDefault:getInstance():getIntegerForKey("magicNum",0)
  self.bombNum = cc.UserDefault:getInstance():getIntegerForKey("bombNum",0)
  self.refreshNum = cc.UserDefault:getInstance():getIntegerForKey("refreshNum",0)
  self.resurgenceNum = cc.UserDefault:getInstance():getIntegerForKey("resurgenceNum",0)
  self.isFirstGame = cc.UserDefault:getInstance():getIntegerForKey("isFirstGame",0)
  self.isFirstRewardProp = cc.UserDefault:getInstance():getIntegerForKey("isFirstRewardProp",0)
  self.processEnergy = cc.UserDefault:getInstance():getIntegerForKey("processEnergy",0)
  self.isMusic  = cc.UserDefault:getInstance():getIntegerForKey("isMusic",0)
  self.isSound  = cc.UserDefault:getInstance():getIntegerForKey("isSound",0)
  self.isFirstGuid = cc.UserDefault:getInstance():getIntegerForKey("isFirstGuid",1)
  self.isButThingkFulBag = cc.UserDefault:getInstance():getIntegerForKey("isButThingkFulBag",0)
end

function meta:getIsButThingkFulBag()
    return self.isButThingkFulBag
end

function meta:setIsButThingkFulBag(isButThingkFulBag)
    self.isButThingkFulBag = tonumber(isButThingkFulBag)
    cc.UserDefault:getInstance():setIntegerForKey("isButThingkFulBag", self.isButThingkFulBag)
end

function meta:getIsFirstGuid()
    return self.isFirstGuid
end

function meta:setIsFirstGuid(isFirstGuid)
    self.isFirstGuid = tonumber(isFirstGuid)
    cc.UserDefault:getInstance():setIntegerForKey("isFirstGuid", self.isFirstGuid)
end

function meta:getIsSound()
    return self.isSound
end

function meta:setIsSound(isSound)
    self.isSound = tonumber(isSound)
    cc.UserDefault:getInstance():setIntegerForKey("isSound", self.isSound)
end


function meta:getIsMusic()
    return self.isMusic
end

function meta:setIsMusic(isMusic)
    self.isMusic = tonumber(isMusic)
    cc.UserDefault:getInstance():setIntegerForKey("isMusic", self.isMusic)
end

function meta:getProcessEnergy()
    return self.processEnergy
end

function meta:setProcessEnergy(processEnergy)
    self.processEnergy = tonumber(processEnergy)
    cc.UserDefault:getInstance():setIntegerForKey("processEnergy", self.processEnergy)
end

function meta:getIsFirstGame()
    return self.isFirstGame
end

function meta:SetIsFirstGame(isFirstGame)
    self.isFirstGame = tonumber(isFirstGame)
    cc.UserDefault:getInstance():setIntegerForKey("isFirstGame", self.isFirstGame)
end

function meta:getIsFirstRewardProp()
    return self.isFirstRewardProp
end

function meta:setIsFirstRewardProp(isFirstRewardProp)
    self.isFirstRewardProp = tonumber(isFirstRewardProp)
    cc.UserDefault:getInstance():setIntegerForKey("isFirstRewardProp", self.isFirstRewardProp)
end

function meta:getResurgenceNum()
  return self.resurgenceNum
end

function meta:setResurgenceNum(resurgenceNum)
  self.resurgenceNum = tonumber(resurgenceNum)
  cc.UserDefault:getInstance():setIntegerForKey("resurgenceNum", self.resurgenceNum)
end

--用户ID
function meta:getMid()
  return self.mid
end

function meta:setMid(mid)
  self.mid = tonumber(mid)
  cc.UserDefault:getInstance():setIntegerForKey("Mid", self.mid)
end

--道具数
function meta:getMagicNum()
  return self.magicNum
end

function meta:setMagicNum(magicNum)
    self.magicNum = tonumber(magicNum)
    local key = string.format("magicNum")
    cc.UserDefault:getInstance():setIntegerForKey(key, self.magicNum)
end

function meta:getBombNum()
  return self.bombNum
end

function meta:setBombNum(bombNum)
  self.bombNum = tonumber(bombNum)
  local key = string.format("bombNum")
  cc.UserDefault:getInstance():setIntegerForKey(key, self.bombNum)
end

function meta:getRefreshNum()
  return self.refreshNum
end

function meta:setRefreshNum(refresh)
  --specialNum = 0
  self.refreshNum = tonumber(refresh)
  local key = string.format("refreshNum")
  cc.UserDefault:getInstance():setIntegerForKey(key, self.refreshNum)
end

function meta:getMusic()
  return self.musicVolume
end

function meta:setMusic(musicVolume)
  self.musicVolume = musicVolume
  cc.UserDefault:getInstance():setStringForKey("checkBoxButton_Music", musicVolume)
end

function meta:getSound()
  return self.soundVolume
end

function meta:setSound(soundVolume)
  self.soundVolume = soundVolume
  cc.UserDefault:getInstance():setStringForKey("checkBoxButton_Sound", soundVolume)
end

function meta:getScore()
  return self.score
end

function meta:setScore(score)
  self.score = score
  cc.UserDefault:getInstance():setIntegerForKey("Score", self.score)
end

function meta:getLevel()
  return self.level
end

function meta:setLevel(level)
  self.level = level
  cc.UserDefault:getInstance():setIntegerForKey("Level", self.level)
end

--分数最大值
function meta:getMaxScore()
  return self.maxScore
end

function meta:setMaxScore(maxScore)
    self.maxScore = tonumber(maxScore)
    cc.UserDefault:getInstance():setIntegerForKey("MaxScore", self.maxScore)
end

--钻石数
function meta:getDiamondNum()
  return self.diamondNum
end

function meta:setDiamondNum(diamondNum)
  self.diamondNum = tonumber(diamondNum)
  cc.UserDefault:getInstance():setIntegerForKey("DiamondNum", self.diamondNum)
end

function meta:addProp(diamondNum,magicNum,refreshNum,bombNum)

    if diamondNum ~= nil then 
        self.diamondNum = tonumber(diamondNum) + self.diamondNum
    end
    if magicNum ~= nil then 
        self.magicNum = tonumber(magicNum) + self.magicNum
    end
    if refreshNum ~= nil then 
        self.refreshNum = tonumber(refreshNum) + self.refreshNum
    end

    if bombNum ~= nil then 
        self.bombNum = tonumber(bombNum) + self.bombNum
    end

    cc.UserDefault:getInstance():setIntegerForKey("DiamondNum", self.diamondNum)
    cc.UserDefault:getInstance():setIntegerForKey("refreshNum", self.refreshNum)
    cc.UserDefault:getInstance():setIntegerForKey("magicNum", self.magicNum)
    cc.UserDefault:getInstance():setIntegerForKey("bombNum", self.bombNum)

end

return meta