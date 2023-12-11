local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local QBCore = exports['qb-core']:GetCoreObject()
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local isInZone                  = false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local PlayerData = QBCore.Functions.GetPlayerData()



AddEventHandler('alpha:hasEnteredMarker', function(zone)
  
	
	if zone == 'exitMarker' then
		CurrentAction     = zone
		CurrentActionMsg  = "Vişne toplamak için ~INPUT_PICKUP~ tuşuna basın"
		CurrentActionData = {}
	end
--[[	
	if zone == 'CherryField' then
	if PlayerData.job == "police" or  PlayerData.job == "ambulance" then
		QBCore.Functions.Notify("Devlet memurları bu işi yapamaz", "error")
	else
		CurrentAction     = zone
		CurrentActionMsg  = "Vişne toplamak için ~INPUT_PICKUP~ tuşuna basın"
		CurrentActionData = {}
	end
	end
	
	if zone == 'CherryField2' then
	if PlayerData.job == "police" or  PlayerData.job == "ambulance" then
		QBCore.Functions.Notify("Devlet memurları bu işi yapamaz", "error")
	else
		CurrentAction     = zone
		CurrentActionMsg  = "Vişne toplamak için ~INPUT_PICKUP~ tuşuna basın"
		CurrentActionData = {}
	end
	end
	
	if zone == 'CherryField3' then
	if PlayerData.job == "police" or  PlayerData.job == "ambulance" then
		QBCore.Functions.Notify("Devlet memurları bu işi yapamaz", "error")
	else
		CurrentAction     = zone
		CurrentActionMsg  = "Vişne toplamak için ~INPUT_PICKUP~ tuşuna basın"
		CurrentActionData = {}
	end
	end
	
	if zone == 'CherryField4' then
	if PlayerData.job == "police" or  PlayerData.job == "ambulance" then
		QBCore.Functions.Notify("Devlet memurları bu işi yapamaz", "error")
	else
		CurrentAction     = zone
		CurrentActionMsg  = "Vişne toplamak için ~INPUT_PICKUP~ tuşuna basın"
		CurrentActionData = {}
	end
	end
]]
	if zone == 'CherryProcessing' then
		if PlayerData.job == "police" or  PlayerData.job == "ambulance" then
		QBCore.Functions.Notify("Devlet memurları bu işi yapamaz", "info")
		else
			CurrentAction     = zone
			CurrentActionMsg  = "Vişne suyu yapmak için ~INPUT_PICKUP~ tuşuna basın"
			CurrentActionData = {}
		end
	end

	if zone == 'CherryJuiceDealer' then
		if PlayerData.job == "police" or  PlayerData.job == "ambulance" then
		QBCore.Functions.Notify("Devlet memurları bu işi yapamaz", "info")
		else
			CurrentAction     = zone
			CurrentActionMsg  = "Vişne suyu satmak için ~INPUT_PICKUP~ tuşuna basın"
			CurrentActionData = {}
		end
	end
end)


AddEventHandler('alpha:hasExitedMarker', function(zone)
	CurrentAction = nil

--	TriggerServerEvent('alpha:stopPickingCherry')
	TriggerServerEvent('alpha:stopCherryJuice')
	TriggerServerEvent('alpha:stopSellCherryJuice')
end)

-- melon Effect
RegisterNetEvent('alpha:oncherry')
AddEventHandler('alpha:oncherry', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(600000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- Render markers
Citizen.CreateThread(function()
    while true do

        Wait(0)

        local coords = GetEntityCoords(GetPlayerPed(-1))

        for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
                DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
        end

    end
end)

-- Create Blips
Citizen.CreateThread(function()
	if Config.DisableBlip == false then
	for i=1, #Config.Map, 1 do
		
		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
		SetBlipSprite (blip, Config.Map[i].id)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, Config.Map[i].color)
		SetBlipScale  (blip, Config.Map[i].scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)
	end
  end
end)

-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('alpha:ReturnInventory')
AddEventHandler('alpha:ReturnInventory', function(currentZone)
	TriggerEvent('alpha:hasEnteredMarker', currentZone)
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 2) then
				isInMarker  = true
				currentZone = k
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerServerEvent('alpha:GetUserInventory', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('alpha:hasExitedMarker', lastZone)
		end

		if isInMarker and isInZone then
			TriggerEvent('alpha:hasEnteredMarker', 'exitMarker')
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'exitMarker' then
					TriggerEvent('alpha:hasExitedMarker', lastZone)
					Citizen.Wait(1000)
				--[[	
				elseif CurrentAction == 'CherryField' then
					TriggerServerEvent('alpha:startPickCherry')
				elseif CurrentAction == 'CherryField2' then
					TriggerServerEvent('alpha:startPickCherry')
				elseif CurrentAction == 'CherryField3' then
					TriggerServerEvent('alpha:startPickCherry')
				elseif CurrentAction == 'CherryField4' then
					TriggerServerEvent('alpha:startPickCherry')
					]]
				elseif CurrentAction == 'CherryProcessing' then
					TriggerServerEvent('alpha:startCherryJuice')
				elseif CurrentAction == 'CherryJuiceDealer' then
					TriggerServerEvent('alpha:startSellCherryJuice')
				else
					isInZone = false -- not a alpha zone
				end
				CurrentAction = nil
			end
		end
	end
end)



----------------------------------------------------------
--------------------STOP PICK/JUICE/SELL-----------
----------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed( -1 )
			if IsControlJustPressed(0, 32) or IsControlJustPressed(0, 33) then
			--	TriggerServerEvent('alpha:stopPickingCherry')
	            TriggerServerEvent('alpha:stopCherryJuice')
	            TriggerServerEvent('alpha:stopSellCherryJuice')
		end
	end
end)

-- Disable Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId(-1)

		if HasAlreadyEnteredMarker then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
		else
			Citizen.Wait(500)
		end
	end
end)
