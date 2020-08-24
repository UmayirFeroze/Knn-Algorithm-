-- -----------------------------------------------------------------------------------------
-- --
-- -- HomeScreen.lua
-- -- Student Name: Umair Mohamed Feroze
-- -- Student ID: 10464891
-- -- Subject Code: CSP2108
-- --
-- -----------------------------------------------------------------------------------------

-- Obtain the required Libraries
local composer = require("composer")
local scene = composer.newScene()

local display = require ("display")
local native = require("native")
local widget = require("widget")

-----------------------------------------------------------------------------------------
-- Obtain USer Input - LOC: 12
-----------------------------------------------------------------------------------------
local function userMethodChoice()
    local userMethodSelection
    if (switchID == 'euclidean') then
        userMethodSelection = 1
    elseif (switchID == 'manhattan') then
        userMethodSelection = 2
    elseif (switchID == 'canberra') then
        userMethodSelection = 3
    elseif (switchID == 'taxiCab') then
        userMethodSelection = 4
    end
    return userMethodSelection
end

-----------------------------------------------------------------------------------------
-- Display the GUI - LOC: 147
-----------------------------------------------------------------------------------------
local function UserInterface1()

    -- Heading
    label1 = display.newText("KNN Algorithm",display.contentCenterX,display.contentCenterY*0.10,"Arial",24)

    -- Labels for X and Y values
    label2 = display.newText("Enter the X, Y and K Values: ",display.contentCenterX,display.contentCenterY*0.25,"Arial",18)
    label3 = display.newText("X Value: ",display.contentCenterX*0.55,display.contentCenterY*0.45,"Arial",18)
    label4 = display.newText("Y Value: ",display.contentCenterX*0.55,display.contentCenterY*0.65,"Arial",18)
    label5 = display.newText("K Value: ",display.contentCenterX*0.55,display.contentCenterY*0.85,"Arial",18)
    label10 = display.newText("Choose Your Distance Matrix: ",display.contentCenterX,display.contentCenterY*1.04,"Arial",18)

    -- Text box for obtaining respective x and y values
    xValueInput = native.newTextField(display.contentCenterX,display.contentCenterY*0.45,50,36)
    xValueInput.inputType = "decimal"
    yValueInput = native.newTextField(display.contentCenterX,display.contentCenterY*0.65,50,36)
    yValueInput.inputType = "decimal"
    kValueInput = native.newTextField(display.contentCenterX,display.contentCenterY*0.85,50,36)
    kValueInput.inputType = "number"

    radioButtons = display.newGroup()
    local function onSwitchPress(event)
        switch = event.target
        switchID = switch.id
        print( "Switch with ID '"..switchID.."' is on: "..tostring(switch.isOn) )
    end

    --Euclidean Radio Button
    local Euclidean = widget.newSwitch(
    {   left = display.contentCenterX*0.30,
        top = display.contentCenterY*1.15,
        style="radio",
        id = "euclidean",
        onPress = onSwitchPress
    }
    )
    radioButtons:insert(Euclidean)
    label6 = display.newText("Euclidean",display.contentCenterX*0.90,display.contentCenterY*1.22,"Arial",18)

    -- Manhattan Radio Button
    local Manhattan = widget.newSwitch(
    {   left = display.contentCenterX*0.30,
        top = display.contentCenterY*1.35,
        style="radio",
        id = "manhattan",
        onPress = onSwitchPress
    }
    )
    radioButtons:insert(Manhattan)
    label7 = display.newText("Manhattan",display.contentCenterX*0.91,display.contentCenterY*1.42,"Arial",18)

    --Canberra Radio Button
    local Canberra = widget.newSwitch(
        {
            left = display.contentCenterX*0.30,
            top = display.contentCenterY*1.55,
            style = "radio",
            id = "canberra",
            onPress = onSwitchPress
        }
    )
    radioButtons:insert(Canberra)
    label8 = display.newText("Canberra",display.contentCenterX*0.86,display.contentCenterY*1.62,"Arial",18)

    --Taxi Cab Radio Button
    local TaxiCab = widget.newSwitch(
        {
            left = display.contentCenterX*0.30,
            top = display.contentCenterY*1.75,
            style = "radio",
            id = "taxiCab",
            onPress = onSwitchPress
        }
    )
    radioButtons:insert(TaxiCab)
    label9 = display.newText("Taxi Cab",display.contentCenterX*0.85,display.contentCenterY*1.83,"Arial",18)

    -- Submit Button Event
    local function handleButtonEvent(event)
        local validation1 = true
        local validation2 = true
        local validation3 = true
        local validation4 = true
        if (event.phase == "ended" or event.phase == "submitted") then
            print("Button was presses and released")
            -- Validation
            if (xValueInput.text == nil or xValueInput.text == '') then
                native.showAlert("Error!","No empty fields allowed",{"OK"})
                validation1 = false
            else
                xUserValue = tonumber(xValueInput.text)
                if (xUserValue>=0 and xUserValue<=10) then
                    print ("x Value: Valid")
                else
                    print("x Value: Invalid")
                    native.showAlert("Error!","X Value should be between 0 and 10",{"OK"})
                    validation2 = false
                end
            end

            if (yValueInput.text == nil or yValueInput.text == '') then 
                native.showAlert("Error!","No empty fields allowed",{"OK"})
                validation3 = false
            else
                yUserValue = tonumber(yValueInput.text)
                if (yUserValue>=0 and yUserValue<=10) then
                    print ("y Value: Valid")
                else
                    print("y Value: Invalid")
                    native.showAlert("Error!","Y Value should be between 0 and 10",{"OK"})
                    validation2 = false
                end
            end

            if (kValueInput.text == nil or kValueInput.text == '') then
                native.showAlert("Error!","No empty fields allowed",{"OK"})
                validation4 = false
            else
                validation1 = true
                kUserValue = tonumber(kValueInput.text)
                if (kUserValue>=1 and kUserValue<=24) then
                    print ("k Value: Valid")
                else
                    print("k Value: Invalid")
                    native.showAlert("Error!","K Value should be between 0 and 24",{"OK"})
                    validation2 = false
                end
            end

            -- Code for calling the functions and knn algorithm
            if (validation1 == true and validation2 == true and validation3 == true and validation4 == true) then
                customParams = {
                    xUser = xUserValue,
                    yUser= yUserValue,
                    kUser = kUserValue,
                    userChoice = userMethodChoice()
                }
                composer.gotoScene( "SideScreen", { effect="crossFade", time=400, params=customParams } )
            else
                return
            end
        end
    end

    Submit = widget.newButton(
        {
            label="Submit >",
            onEvent = handleButtonEvent,
            top = display.contentCenterX,
            left = display.contentCenterY*2,
            emboss = false,
            shape = "roundedRect",
            width = 100,
            height = 30,
            cornerRadius = 2,
            fillColor = {default={0,0,0,0}, over={1,0,1,0,7,0,4}},
            strokeColor = {default={1,0,4,0,1}, over={0,8,0,9,1,1}},
            strokeWidth = 2
        }
    )
    Submit.x = display.contentWidth*0.8
    Submit.y = display.contentHeight
end

-----------------------------------------------------------------------------------------
-- Text Input Events - LOC: 18
-----------------------------------------------------------------------------------------

-- xValue TextBox Event
local function xValue(event)
    if (event.phase  == "ended" or event.phase=="submitted") then
        if (event.target.text == '' or event.target.text == nil) then
            native.showAlert("Error!","No empty fields allowed",{"OK"})
        else
            value = tonumber(event.target.text)
            if (value <0 or value > 10) then
                native.showAlert("Error!","X Value should be between 0 and 10",{"OK"})
            else
                local xUser = tonumber(event.target.text)
                print("User X Value: "..xUser)
            end
        end
    end
end

-- yValue TextBox Event
local function yValue(event)
    if (event.phase  == "ended" or event.phase=="submitted") then
        if (event.phase  == "ended" or event.phase=="submitted") then
            if (event.target.text == '' or event.target.text == nil) then
                native.showAlert("Error!","No empty fields allowed",{"OK"})
            else
                value = tonumber(event.target.text)
                if (value < 0 or value > 10) then
                    native.showAlert("Error!","Y Value should be between 0 and 10",{"OK"}) 
                else
                    local yUser = tonumber(event.target.text)
                    print("User Y Value: "..yUser)
                end
            end
        end
    end
end

-- kValue TextBox Event
local function kValue(event)
    if (event.phase  == "ended" or event.phase=="submitted") then
        if (event.target.text == '' or event.target.text == nil) then
            native.showAlert("Error!","No empty fields allowed",{"OK"})
        else
            value = tonumber(event.target.text)
            if (value < 1 or value > 24) then 
                native.showAlert("Error!","K Value should be between 1 and 24",{"OK"})
            else
                local kUser = tonumber(event.target.text)
                print("User K Value: "..kUser)
            end
        end
    end
end

-----------------------------------------------------------------------------------------
--Scene Handling - LOC: 61
-----------------------------------------------------------------------------------------
function scene:create(event)
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    userChoice = userMethodChoice()
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
    local params = event.params
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        require("Testing")
        print("----Scene 01----")
        UserInterface1()
        xValueInput:addEventListener("userInput",xValue)
        yValueInput:addEventListener("userInput",yValue)
        kValueInput:addEventListener("userInput",kValue)

        sceneGroup:insert(Submit)
        sceneGroup:insert(label1)
        sceneGroup:insert(label2)
        sceneGroup:insert(label3)
        sceneGroup:insert(label4)
        sceneGroup:insert(label5)
        sceneGroup:insert(label6)
        sceneGroup:insert(label7)
        sceneGroup:insert(label8)
        sceneGroup:insert(label9)
        sceneGroup:insert(label10)
        sceneGroup:insert(radioButtons)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
    end
end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        xValueInput:removeSelf()
        yValueInput:removeSelf()
        kValueInput:removeSelf()
        sceneGroup:removeSelf()
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end

function scene:destroy(event)
	local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's
end

-----------------------------------------------------------------------------------------
-- Event Function Listeners - LOC: 5
-----------------------------------------------------------------------------------------
scene:addEventListener("create",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("show",scene)
scene:addEventListener("destroy",scene)
-----------------------------------------------------------------------------------------
return scene