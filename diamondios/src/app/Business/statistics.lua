local statistics = class("statistics")

function statistics:countMatrixSameNum(matrixGrid)

    if matrixGrid == nil then
        return
    end

    local m = DATA_matrix_row
    local n = DATA_matrix_col
    local ans = {}

    local mark = {}
    for i = 0 , m do 
        mark[i] = {}
    end

    local xIncrement = {0,1,0,-1}
    local yIncrement = {1,0,-1,0}

    for i=1,#matrixGrid do 
        if matrixGrid[i]~= nil then
            for j=1,#matrixGrid[i] do 
                if matrixGrid[i][j] ~= nil and mark[i][j] ~= 1 then 

                    mark[i][j] = 1
                    ans[#ans+1] = {}
                    ans[#ans][#ans[#ans]+1] = matrixGrid[i][j]
                    local queue = {{matrixGrid[i][j],i,j}}
                    local queueStart = 1
                    while(queue[queueStart]~=nil)
                    do
                        for z = 1 , #xIncrement do
                            local x = queue[queueStart][2] + xIncrement[z]
                            local y = queue[queueStart][3] + yIncrement[z]
                            if x > 0 and x <= m and y>0 and y<= n then
                                if matrixGrid[x] ~=nil then
                                    if matrixGrid[x][y] ~= nil and mark[x][y] ~= 1 then 
                                        if self:jurgeIsTheSame(matrixGrid[x][y],queue[queueStart][1]) then
                                            queue[#queue+1] = {matrixGrid[x][y],x,y}
                                            ans[#ans][#ans[#ans]+1] = matrixGrid[x][y]
                                            mark[x][y] = 1
                                        end
                                    end
                                end
                            end
                        end
                        queueStart = queueStart + 1
                    end
                    ans[#ans][0] = #ans[#ans]
                end
            end
        end
    end
    
    ans[#ans+1] = {}
    for i = 1 ,#ans do 
        ans[#ans][i] = ans[i][0] 
    end
    local sortFunc = function(a, b) return b < a end
    table.sort(ans[#ans],sortFunc)
    return ans
end

function statistics:jurgeIsTheSame(sprite1,sprite2)

    if sprite1:getColor() == sprite2:getColor() then
        return true
    else
        return false 
    end

end

function statistics:getMostScore(matrixGrid)

    if matrixGrid == nil then
        return
    end

    local ans = {}
    local max = 1

    for i=1,#matrixGrid do 
        if matrixGrid[i]~= nil then
            for j=1,#matrixGrid[i] do 
                if matrixGrid[i][j] ~= nil then
                    local oldColor = matrixGrid[i][j]:getColor()
                    for color = 1,DATA_pic_kind do 
                        matrixGrid[i][j]:setColor(color)
                        local temp = self:countMatrixSameNum(matrixGrid)
                        curNum = temp[#temp][1]
                        if max < curNum then 
                            max = curNum
                            ans = {color,i,j}
                        end
                    end
                    matrixGrid[i][j]:setColor(oldColor)
                end
            end
        end
    end
    return ans
end

return statistics