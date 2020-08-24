-- -----------------------------------------------------------------------------------------
-- --
-- -- SideScreen.lua
-- -- Student Name: Umair Mohamed Feroze
-- -- Student ID: 10464891
-- -- Subject Code: CSP2108
-- --
-- -----------------------------------------------------------------------------------------

-- Obtain requried libraries
local display = require("display")
local native = require ("native")

local composer = require("composer")
local scene = composer.newScene()

-----------------------------------------------------------------------------------------
--Obtain the values in knn.csv file to the table - LOC: 18
-----------------------------------------------------------------------------------------
local function WriteToTable()
    data={}
    local dataPath = system.pathForFile("knn.csv",system.ResourceDirectory)
    local file,errorString = io.open(dataPath,"r")
    print ("\n----Reading data in Table----")
    if not file then
        print("File Error: "..errorString)
    else
        local i = 1
        for line in file:lines() do
            local _xValue,_yValue,_class = string.match(line,"(%d+),(%d+),(%a+)") -- search for items in file
            data[i] = {xValue=_xValue, yValue=_yValue, class=_class} -- insert values into the file 
            print(data[i].xValue..","..data[i].yValue..","..data[i].class)
            i = i + 1
        end
        io.close(file)
    end
    file = nil
end

---------------------------------------------------------------------------------------
--KNN Algorithm - LOC: 35
---------------------------------------------------------------------------------------
local function KnnAlgorithm (distanceDataTable,kUserValue)
    local knnTable = {} -- knn Data Table
    local function compare( a, b )
        return a.distance < b.distance -- sort in ascending order
    end
    table.sort(distanceDataTable,compare)
    print("\n----Sorted table----")
    for i=1, table.maxn(distanceDataTable) do
        print(distanceDataTable[i].class..","..distanceDataTable[i].distance) -- view sorted array 
    end
    print ("\n----K Neighbours----")
    for j=1,kUserValue do
        knnTable[j] = {class = distanceDataTable[j].class, distance = distanceDataTable[j].distance}
        print(knnTable[j].class..","..knnTable[j].distance) -- view knn Array
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
        print("Your Point Belongs to Class A")
        class = "A"
    else
        print("Your Point belongs to Class B")
        class = "B"
    end
    label16 = display.newText(class,display.contentCenterX*1.35,display.contentCenterY*0.55,"Arial",16)
end

---------------------------------------------------------------------------------------
--Functions to Calculate Distance - LOC : 10
---------------------------------------------------------------------------------------

-- Euclidean Distance - LOC: 10
local function EuclideanDistance(xUser,yUser,kUserValue,data)
    local euclideanDistanceTable={}
    print("\n----Euclidean Distance----")
    for i=1, table.maxn(data) do
        local distance = math.sqrt((xUser-data[i].xValue)^2 + (yUser-data[i].yValue)^2)
        euclideanDistanceTable[i] = {class = data[i].class,distance = distance}
        print(euclideanDistanceTable[i].class..","..euclideanDistanceTable[i].distance)
    end
    KnnAlgorithm(euclideanDistanceTable,kUserValue)
end

-- Manhattan Distance - LOC: 10
local function ManhattanDistance(xUser,yUser,kUser,data)
    local manhattanDistanceTable = {}
    print("\n----Manhattan Distance----")
    for i=1, table.maxn(data) do
        local distance = math.abs((xUser-data[i].xValue) + (yUser-data[i].yValue))
        manhattanDistanceTable[i] = {class = data[i].class,distance = distance}
        print(manhattanDistanceTable[i].class..","..manhattanDistanceTable[i].distance)
    end
    KnnAlgorithm(manhattanDistanceTable,kUser)
end

-- Canberra Distance - LOC: 10
local function CanberraDistance(xUser,yUser,kUser,data)
    local CanberraDistanceTable = {}
    print("\n----Canberra Distance----")
    for i=1, table.maxn(data) do
        local canberraDistance = ((math.abs(xUser-data[i].xValue))/(math.abs(xUser+data[i].xValue))) + ((math.abs(yUser-data[i].yValue))/math.abs(yUser+data[i].yValue))
        CanberraDistanceTable[i] = {class = data[i].class,distance = canberraDistance}
        print(CanberraDistanceTable[i].class..","..CanberraDistanceTable[i].distance)
    end
    KnnAlgorithm(CanberraDistanceTable,kUser)
end

-- Taxi Cab Distance Matrix - LOC: 10
local function TaxiCabDistance(xUser,yUser,kUser,data)
    local taxiCabTable = {}
    print("\n----Taxi Cab Distance----")
    for i=1, table.maxn(data) do
        local distance = math.abs(xUser-data[i].xValue) + math.abs(yUser-data[i].yValue)
        taxiCabTable[i] = {class = data[i].class,distance = distance}
        print(taxiCabTable[i].class..","..taxiCabTable[i].distance)
    end
    KnnAlgorithm(taxiCabTable,kUser)
end

-----------------------------------------------------------------------------------------
-- Display the GUI - LOC : 32
-----------------------------------------------------------------------------------------
local function UserInterface2()
    label1 = display.newText("KNN Algorithm",display.contentCenterX,display.contentCenterY*0.20,"Arial",24)
    label2 = display.newText("Your Input Values: ",display.contentCenterX,display.contentCenterY*0.30,"Arial",18)
    label3 = display.newText("X Value: ",display.contentCenterX*0.25,display.contentCenterY*0.45,"Arial",16)
    label4 = display.newText("Y Value: ",display.contentCenterX*0.85,display.contentCenterY*0.45,"Arial",16)
    label5 = display.newText("K Value: ",display.contentCenterX*1.45,display.contentCenterY*0.45,"Arial",16)
    label6 = display.newText("Matrix: ",display.contentCenterX*0.23,display.contentCenterY*0.55,"Arial",16)
    label7 = display.newText("Class: ",display.contentCenterX*1.10,display.contentCenterY*0.55,"Arial",16)
    label8 = display.newText("Key: ",display.contentCenterX*1.50,display.contentCenterY*0.65,"Arial",13)
    label9 = display.newText("classA = Dark Blue",display.contentCenterX*1.50,display.contentCenterY*0.72,"Arial",13)
    label10 = display.newText("classB = Light Blue",display.contentCenterX*1.50,display.contentCenterY*0.79,"Arial",13)
    label11 = display.newText("Target Point = Yellow",display.contentCenterX*1.50,display.contentCenterY*0.86  ,"Arial",13)

    local widget = require("widget")
    local function handleButtonEvent(event)
        -- Code here would transfer the page to the homepage
        composer.gotoScene( "HomeScreen", "crossFade",500)
    end

    Back = widget.newButton(
        {
            label="< Back",
            onEvent = handleButtonEvent,
            emboss = false,
            shape = "roundedRect",
            font = "Arial",
            width = 100,
            height = 30,
            cornerRadius = 2,
            fillColor = {default={0,0,0,0}, over={1,0,1,0,7,0,4}},
            strokeColor = {default={1,0,4,0,1}, over={0,8,0,9,1,1}},
            strokeWidth = 2
        }
    )
    Back.x = display.contentWidth*0.1
    Back.y = (display.contentHeight)
end

-----------------------------------------------------------------------------------------
--Display the Values in a Graph - Scatter graph  -LOC : 36
-----------------------------------------------------------------------------------------
local function scatterGraph(data,xUserValue,yUserValue)
    -- graph layout
    local graphSize = (math.min(display.contentHeight, display.contentWidth))*0.8
    local graphLocation = {x = (display.contentWidth - graphSize)/2, y = (display.contentHeight - graphSize)/2}
    graph = display.newGroup()
    graph.x = display.contentCenterX*0.1
    graph.y = display.contentCenterY*0.7
    local axisThickness = 2
    local graphThickness = 1

    -- y axis
    yAxis = display.newRect(0, 0, axisThickness, graphSize)
    yAxis.anchorX = 0
    yAxis.anchorY = 0
    yAxis.type = "wall"
    graph:insert(yAxis)

    --x axis
    xAxis = display.newRect(0, graphSize-axisThickness, graphSize, graphThickness)
    xAxis.anchorX = 0
    xAxis.anchorY = 0
    xAxis.type = "wall"
    graph:insert(xAxis)

    -- sort in ascending order
    local function compare(a,b)
        return (a.class < b.class)
    end
    table.sort(data,compare)

    graphPoints = display.newGroup()
    pointA = display.newGroup(); graphPoints:insert(pointA)
    pointB = display.newGroup(); graphPoints:insert(pointB)
    for i=1, table.maxn(data) do
        if (data[i].class == "a") then
            pointA1 = display.newCircle(pointA,(data[i].xValue)*25,(display.contentHeight - data[i].yValue*20)*0.90,5)
            pointA1:setFillColor(0,0,1)
        else
            pointB1 = display.newCircle(pointB,(data[i].xValue)*25,(display.contentHeight - data[i].yValue*20)*0.90,3)
            pointB1:setFillColor(0,1,1)
        end 
    end
    targetPoint = display.newCircle(xUserValue*25,(display.contentHeight - yUserValue*20)*0.90,5)
    targetPoint:setFillColor(1,1,0)
end

-----------------------------------------------------------------------------------------
--Obtain User's Choice of Distance Matrix - LOC : 18
-----------------------------------------------------------------------------------------
local function userDistanceMatrix(userChoice,xUserValue,yUserValue,kUserValue,data)
    if (userChoice == 1) then
        print("User Choice: Euclidean")
        label12 = display.newText("Euclidean",display.contentCenterX*0.65,display.contentCenterY*0.55,"Arial",16)
        EuclideanDistance(xUserValue,yUserValue,kUserValue,data)
    elseif (userChoice == 2) then
        print ("User Choice: Manhattan")
        label12 = display.newText("Manhattan",display.contentCenterX*0.65,display.contentCenterY*0.55,"Arial",16)
        ManhattanDistance(xUserValue,yUserValue,kUserValue,data)
    elseif (userChoice == 3) then
        print ("User Choice: Canberra Distance")
        label12 = display.newText("Canberra",display.contentCenterX*0.65,display.contentCenterY*0.55,"Arial",16)
        CanberraDistance(xUserValue,yUserValue,kUserValue,data)
    elseif (userChoice == 4) then
        print ("User Choice: Taxi Cab")
        label12 = display.newText("Taxi Cab",display.contentCenterX*0.60,display.contentCenterY*0.55,"Arial",16)
        TaxiCabDistance(xUserValue,yUserValue,kUserValue,data)
    end
end

-----------------------------------------------------------------------------------------
--Scene Handling - LOC: 54
-----------------------------------------------------------------------------------------
-- create()
function scene:create( event )
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
end

-- show()
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        print("\n----Scene 02----")
        WriteToTable()
        --Obtain Values Entered by the User
        xUserValue = tonumber(event.params.xUser)
        yUserValue = tonumber(event.params.yUser)
        kUserValue = tonumber(event.params.kUser)
        userChoice = tonumber(event.params.userChoice)
        print("User X Value: "..xUserValue)
        print("User Y Value: "..yUserValue)
        print("User K Value: "..kUserValue)
        UserInterface2()
        label13 = display.newText(xUserValue,display.contentCenterX*0.50,display.contentCenterY*0.45,"Arial",16)
        label14 = display.newText(yUserValue,display.contentCenterX*1.10,display.contentCenterY*0.45,"Arial",16)
        label15 = display.newText(kUserValue,display.contentCenterX*1.70,display.contentCenterY*0.45,"Arial",16)
        userDistanceMatrix(userChoice,xUserValue,yUserValue,kUserValue,data)
        scatterGraph(data,xUserValue,yUserValue)
        sceneGroup:insert(Back)
        sceneGroup:insert(graph)
        sceneGroup:insert(graphPoints)
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
    end
end

-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        label1:removeSelf()
        label2:removeSelf()
        label3:removeSelf()
        label4:removeSelf()
        label5:removeSelf()
        label6:removeSelf()
        label7:removeSelf()
        label8:removeSelf()
        label9:removeSelf()
        label10:removeSelf()
        label11:removeSelf()
        label12:removeSelf()
        label13:removeSelf()
        label14:removeSelf()
        label15:removeSelf()
        label16:removeSelf()
        targetPoint:removeSelf()
        sceneGroup:removeSelf()
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end

-- destroy()
function scene:destroy( event )
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    composer.removeScene()
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners - LOC :
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--------------------------------------------------------------------------------------
return scene