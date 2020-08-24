-- -----------------------------------------------------------------------------------------
-- --
-- -- Testing.lua
-- -- Student Name: Umair Mohamed Feroze
-- -- Student ID: 10464891
-- -- Subject Code: CSP2108
-- --
-- -----------------------------------------------------------------------------------------

local luaunit = require("luaunit")

print ("\n----Carrying out Tests----")
-- Testing User Method Choice Function
function UserMethodChoice(userChoice)
    if (userChoice == 1) then
        choice = "Euclidean"
    elseif (userChoice == 2) then
        choice = "Manhattan"
    elseif (userChoice == 3) then
        choice = "Cosine Similarity"
    elseif (userChoice == 4) then
        choice = "TaxiCab"
    else 
        choice = "Error"
    end
    return choice
end
function testUserMethodChoice()
    luaunit.assertEquals(UserMethodChoice(1),"Euclidean")
    luaunit.assertEquals(UserMethodChoice(2),"Manhattan")
    luaunit.assertEquals(UserMethodChoice(3),"Cosine Similarity")
    luaunit.assertEquals(UserMethodChoice(4),"TaxiCab")
    luaunit.assertEquals(UserMethodChoice(5),"Error")
end 

-- Testing the User Distance Matrix Function 
function UserDistanceMatrix(userChoice)
    if (userChoice == 1) then
        choice = "Euclidean"
    elseif (userChoice == 2) then
        choice = "Manhattan"
    elseif (userChoice == 3) then
        choice = "Cosine Similarity"
    elseif (userChoice == 4) then
        choice = "TaxiCab"
    else
        choice = "Error"
    end
    return choice
end
function testUserDistanceMatrix()
    luaunit.assertEquals(UserDistanceMatrix(1),"Euclidean")
    luaunit.assertEquals(UserDistanceMatrix(2),"Manhattan")
    luaunit.assertEquals(UserDistanceMatrix(3),"Cosine Similarity")
    luaunit.assertEquals(UserDistanceMatrix(4),"TaxiCab")
    luaunit.assertEquals(UserDistanceMatrix(5),"Error")
end

-- Testing Write to Table Function
function WriteToTable()
    data={}
    local dataPath = system.pathForFile("knn.csv",system.ResourceDirectory)
    local file,errorString = io.open(dataPath,"r")
    if not file then
        print("File Error: "..errorString)
        ans = "error"
    else
        local i = 1
        for line in file:lines() do
            local _xValue,_yValue,_class = string.match(line,"(%d+),(%d+),(%a+)") -- search for items in file
            data[i] = {xValue=_xValue, yValue=_yValue, class=_class} -- insert values into the file 
            -- print(data[i].xValue..","..data[i].yValue..","..data[i].class)
            i = i + 1
        end
        io.close(file)
        ans = "File Transfered!"
    end
    file = nil
    return ans
end
function testWriteToTable()
    luaunit.assertEquals(WriteToTable(),"File Transfered!")
end

-- Testing Euclidean Distance Function
function EuclideanDistance(xUser,yUser)
    xValue,yValue = 10,10
    if (xUser>=0 and xUser<=10) then
        if (yUser>=0 and yUser<=10) then
            distance = math.sqrt((xUser-xValue)^2 + (yUser-yValue)^2)
        else
            distance = "error"
        end
    else
        distance = "error"
    end
    return distance
end
function testEuclideanDistance()
    luaunit.assertEquals(EuclideanDistance(0,0),math.sqrt(200))
    luaunit.assertEquals(EuclideanDistance(5,5),math.sqrt(50))
    luaunit.assertEquals(EuclideanDistance(10,10),0)
    luaunit.assertEquals(EuclideanDistance(11,11),"error")
end

-- Testing Manhattan Distance Function
function ManhattanDistance(xUser,yUser)
    xValue,yValue = 10,10
    if (xUser>=0 and xUser<=10) then
        if (yUser>=0 and yUser<=10) then
            distance = math.abs((xUser-xValue) + (yUser-yValue))
        else
            distance = "error"
        end
    else
        distance = "error"
    end
    return distance
end
function testManhattanDistance()
    luaunit.assertEquals(ManhattanDistance(0,0),20)
    luaunit.assertEquals(ManhattanDistance(5,5),10)
    luaunit.assertEquals(ManhattanDistance(10,10),0)
    luaunit.assertEquals(ManhattanDistance(11,11),"error")
end

-- Testing Cosine Similarity Function
function CanberraDistance(xUser,yUser)
    xValue, yValue = 10,10
    if (xUser>=0 and xUser<=10) then
        if (yUser>=0 and yUser<=10) then
            distance = ((math.abs(xUser-xValue))/(math.abs(xUser+xValue))) + ((math.abs(yUser-yValue))/math.abs(yUser+yValue))
        else
            distance = "error"
        end
    else
        distance = "error"
    end
    if (distance == "error") then 
        return distance
    else
        return math.floor(distance)
    end
end
function testCanberraDistance()
    xValue, yValue = 10,10
    luaunit.assertEquals(CanberraDistance(0,0),2)
    luaunit.assertEquals(CanberraDistance(5,5),0)
    luaunit.assertEquals(CanberraDistance(10,10),0)
    luaunit.assertEquals(CanberraDistance(11,11),"error")
end

-- Testing Taxi Cab Function
function TaxiCabDistance(xUser,yUser)
    xValue,yValue = 10,10
    if (xUser>=0 and xUser<=10) then
        if (yUser>=0 and yUser<=10) then
            distance = math.abs(xUser-xValue) + math.abs(yUser-yValue)
        else
            distance = "error"
        end
    else
        distance = "error"
    end
    return distance
end
function testTaxiCabDistance()
    luaunit.assertEquals(TaxiCabDistance(0,0),20)
    luaunit.assertEquals(TaxiCabDistance(5,5),10)
    luaunit.assertEquals(TaxiCabDistance(10,10),0)
    luaunit.assertEquals(TaxiCabDistance(11,11),"error")
end

function KnnAlgorithm(xUser,yUser,kUser)
    xValue, yValue = 10,10
    if (xUser>=0 and xUser<=10) then
        if (yUser>=0 and yUser<=10) then
            if (kUser>=1 and kUser<=24) then 
                -- read data from knn algorithm and insert to data table
                data={}
                local dataPath = system.pathForFile("knn.csv",system.ResourceDirectory)
                local file,errorString = io.open(dataPath,"r")
                if not file then
                    print("File Error: "..errorString)
                else
                    local i = 1
                    for line in file:lines() do
                        local _xValue,_yValue,_class = string.match(line,"(%d+),(%d+),(%a+)") -- search for items in file
                        data[i] = {xValue=_xValue, yValue=_yValue, class=_class} -- insert values into the file 
                        i = i + 1
                    end
                    io.close(file)
                end

                -- Use user input to calculate data matrix
                local euclideanDistanceTable={}
                for i=1, table.maxn(data) do
                    local distance = math.sqrt((xUser-data[i].xValue)^2 + (yUser-data[i].yValue)^2)
                    euclideanDistanceTable[i] = {class = data[i].class,distance = distance}
                end

                --Knn Algorithm 
                local function compare (a,b)
                    return a.distance < b.distance 
                end
                table.sort(euclideanDistanceTable,compare)

                knnTable = {}
                for j=1,kUser do 
                    knnTable[j] = {class = euclideanDistanceTable[j].class, distance = euclideanDistanceTable[j].distance}
                end

                local totalWeightageA = 0
                local totalWeightageB = 0
                for loop=1, table.maxn(knnTable) do
                    if (knnTable[loop].class == "a") then
                        weightageA = math.pow(loop,(-1))
                        totalWeightageA = totalWeightageA + weightageA
                    else
                        weightageB = math.pow(loop,(-1))
                        totalWeightageB = totalWeightageB + weightageB
                    end
                end

                if (totalWeightageA > totalWeightageB) then
                    class = "A"
                else
                    class = "B"
                end
            else
                class = "error"
            end
        else
            class = "error"
        end
    else
        class = "error"
    end
    return class
end
function testKnnAlgorithm ()
    luaunit.assertEquals(KnnAlgorithm(0,0,1),"A")
    luaunit.assertEquals(KnnAlgorithm(5,5,5),"B")
    luaunit.assertEquals(KnnAlgorithm(10,10,10),"B")
    luaunit.assertEquals(KnnAlgorithm(11,10,10),"error")
    luaunit.assertEquals(KnnAlgorithm(10,11,10),"error")
    luaunit.assertEquals(KnnAlgorithm(10,10,25),"error")
    luaunit.assertEquals(KnnAlgorithm(11,11,25),"error")
end


return luaunit.LuaUnit.run()