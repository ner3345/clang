local HttpService = import("..sprite.Http")
local guidLevelInfo = import("..resource.LevelGuid")
local Apk_upd = import("..sprite.apk_upd")

local utility = class("utility")

function utility:saveGame(matrixGrid,level,score,processEnergy)

    if matrixGrid == nil then
        return
    end

    local tempMatrix = {} 

    for i = 1 , DATA_matrix_row do 
        tempMatrix[i] = {}
        for j = 1 ,DATA_matrix_row do 
            if matrixGrid[i] ~= nil and matrixGrid[i][j] ~= nil then
               tempMatrix[i][j] = matrixGrid[i][j]:getColor()
            end
        end
    end

    local params = {level = level,score = score ,matrixGuid=tempMatrix,processEnergy = processEnergy}

    io.writefile(device.writablePath..device.directorySeparator.."saveGame.txt",json.encode(params),"w+")

end

function utility:saveGameWithNul(level,score,processEnergy)
    
    math.randomseed(os.time())
    local tempMatrix = {} 

    local params = {level = level,score = score ,matrixGuid=tempMatrix,processEnergy = processEnergy}

    io.writefile(device.writablePath..device.directorySeparator.."saveGame.txt",json.encode(params),"w+")

end

function utility:createEnterGame(isNewGame,row,col)
    if isNewGame == true then
        math.randomseed(os.time())
        local tempMatrix = {} 
        for i = 1 , row do 
            tempMatrix[i] = {}
            for j = 1 ,col do 
                tempMatrix[i][j] = math.random(1,DATA_pic_kind)
            end
        end

        local params = {level = 1,score = 0 ,matrixGuid=tempMatrix,processEnergy = 0}
        io.writefile(device.writablePath..device.directorySeparator.."enterGame.txt",json.encode(params),"w+")
    end

    if isNewGame == false then 
        if io.exists(device.writablePath.."saveGame.txt")  then
            local contents = io.readfile(device.writablePath.."saveGame.txt")
            local gameData = json.decode(contents)
            local params = {level = gameData.level,score = gameData.score ,matrixGuid=gameData.matrixGuid,processEnergy= gameData.processEnergy}
            io.writefile(device.writablePath..device.directorySeparator.."enterGame.txt",json.encode(params),"w+")
            return
        end
        self:createEnterGame(true,row,col)
    end
    
end

function utility:setGuidGame()
    if io.exists(device.writablePath.."enterGame.txt")  then
        local contents = io.readfile(device.writablePath.."enterGame.txt")
        local gameData = json.decode(contents)

        gameData.matrixGuid[5][2]=1
        gameData.matrixGuid[5][3]=1
        gameData.matrixGuid[5][4]=5
        gameData.matrixGuid[5][5]=3
        gameData.matrixGuid[5][6]=5
        gameData.matrixGuid[5][7]=5
        gameData.matrixGuid[5][8]=5
        gameData.matrixGuid[5][9]=1
        gameData.matrixGuid[5][10]=1
        gameData.matrixGuid[4][9]=2
        gameData.matrixGuid[4][8]=4
        gameData.matrixGuid[6][9]=3
        gameData.matrixGuid[6][10]=3


        gameData.matrixGuid[4][6]=1
        gameData.matrixGuid[4][7]=1
        gameData.matrixGuid[4][3]=1
        gameData.matrixGuid[4][4]=1
        gameData.matrixGuid[6][6]=1
        gameData.matrixGuid[6][7]=1
        gameData.matrixGuid[6][3]=1
        gameData.matrixGuid[6][4]=1

        gameData.matrixGuid[1][5]=5
        gameData.matrixGuid[2][5]=5
        gameData.matrixGuid[3][5]=5
        gameData.matrixGuid[4][5]=5
        gameData.matrixGuid[6][5]=5
        gameData.matrixGuid[7][5]=5
        gameData.matrixGuid[8][5]=5
        gameData.matrixGuid[9][5]=5
        gameData.matrixGuid[10][5]=4

        
        gameData.matrixGuid[1][6]=1
        gameData.matrixGuid[2][6]=1
        gameData.matrixGuid[3][6]=1
        gameData.matrixGuid[4][6]=1
        gameData.matrixGuid[6][6]=1
        gameData.matrixGuid[7][6]=1
        gameData.matrixGuid[8][6]=1
        gameData.matrixGuid[9][6]=1
        gameData.matrixGuid[10][6]=1

        gameData.matrixGuid[1][4]=1
        gameData.matrixGuid[2][4]=1
        gameData.matrixGuid[3][4]=1
        gameData.matrixGuid[4][4]=1
        gameData.matrixGuid[6][4]=1
        gameData.matrixGuid[7][4]=1
        gameData.matrixGuid[8][4]=1
        gameData.matrixGuid[9][4]=1

        local params = {level = gameData.level,score = gameData.score ,matrixGuid=gameData.matrixGuid,processEnergy= gameData.processEnergy}
        io.writefile(device.writablePath..device.directorySeparator.."enterGame.txt",json.encode(params),"w+")
        return
    end
end

function utility:ReadGame()
    local params
    if io.exists(device.writablePath.."enterGame.txt") then
        local contents = io.readfile(device.writablePath.."enterGame.txt")
        local gameData = json.decode(contents)
        params = {level = gameData.level,score = gameData.score ,matrixGuid=gameData.matrixGuid,processEnergy= gameData.processEnergy}
    end
    return params
end

function utility:jurgeHasSaveGame()
    if io.exists(device.writablePath.."saveGame.txt") then
        return true
    end
    return false
end

function utility:login(callback)
    local params = {}
    params.username = device.getOpenUDID()
    params.channel = CHANNEL
    HttpService:sendRequest(INIT_USER_REQ,params,callback)
end

function utility:UseCDKey(CDKeyCode,callback)
    local params = {}
    params.key = CDKeyCode
    HttpService:sendRequest(GET_UseCDKey,params,callback)
end

function utility:getContinueLoginDay(callback)
    local params = {}
    params.mid = mid
    HttpService:sendRequest(GET_continueLoginPrize,params,callback)
end

function utility:getContinueLoginRewordList(callback)
    local params = {}
    params.mid = mid
    HttpService:sendRequest(GET_continueLoginPrizeList,params,callback)
end

function utility:getNotice(callback)
    HttpService:sendRequest(GET_NOTICE,nil,callback)
end

function utility:playMusic(music)
    if UserData:getIsMusic() == 0 then 
        return 
    end
    return audio.playMusic(music,true)
end

function utility:stopMusic()
    audio.stopMusic(true)
end

function utility:playSound(soundName,isLoop)
    if UserData:getIsSound() == 0 then 
        return 
    end
    return audio.playSound(soundName,isLoop)
end

function utility:stopSound(music)
    audio.stopSound(music)
end

function utility:updateApp(scene)
    self.path = device.writablePath
    local random = os.time()
    self.apk_upd = Apk_upd.new(scene, self.path, random)
    self.apk_upd:updateApk()
end

return utility