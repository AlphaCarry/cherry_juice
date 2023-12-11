local QBCore = exports['qb-core']:GetCoreObject()
local CopsConnected       	   = 0
local PlayersPickingCherry   = {}
local PlayersCherryJuice = {}
local PlayersSellingCherryJuice      = {}

--[[
------------- Cherry -------------------
local function PickCherry(source)
		SetTimeout(Config.TimeToPickCherry, function()
		if PlayersPickingCherry[source] == true then
			local xPlayer = QBCore.Functions.GetPlayer(source)
			xPlayer.Functions.AddItem('cherry', 1)
			--PickCherry(source)
		end
    end)
end


RegisterServerEvent('alpha:startPickCherry')
AddEventHandler('alpha:startPickCherry', function()


	PlayersPickingCherry[source] = true

	TriggerClientEvent('QBCore:Notify', source,  "~y~Toplama işlemi başladı~s~. Hareket etmeyin", "success")

	PickCherry(source)

end)

RegisterServerEvent('alpha:stopPickCherry')
AddEventHandler('alpha:stopPickCherry', function()

	PlayersPickingCherry[source] = false

end)
]]

local function CherryJuice(source)
	SetTimeout(Config.TimeToCherryJuice, function()
		if PlayersCherryJuice[source] == true then
  			local Player = QBCore.Functions.GetPlayer(source)
			if Player.Functions.GetItemByName('cherry') ~= nil then
				Player.Functions.RemoveItem('cherry', 1)
				TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["cherry"], "remove", 1 )
				Player.Functions.AddItem('cherry_juice', 1)
				TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["cherry_juice"], "add", 1 )
				CherryJuice(source)
			else
				TriggerClientEvent('QBCore:Notify', source,  "~r~Üstünde vişne yok~s~", "info")
			end
		end
	end)
end

RegisterServerEvent('alpha:startCherryJuice')
AddEventHandler('alpha:startCherryJuice', function()


	PlayersCherryJuice[source] = true

    TriggerClientEvent('QBCore:Notify', source,  "~y~İşlem başladı.~s~. Hareket etmeyin", "success")

	CherryJuice(source)

end)

RegisterServerEvent('alpha:stopCherryJuice')
AddEventHandler('alpha:stopCherryJuice', function()


	PlayersCherryJuice[source] = false

end)

local function SellCherryJuice(source)
	SetTimeout(Config.TimeToSellCherryJuice, function()
		if PlayersSellingCherryJuice[source] == true then
			local Player = QBCore.Functions.GetPlayer(source)
			local citizen = Player.PlayerData.citizenid 
			local id = source
			if Player.Functions.GetItemByName('cherry_juice') ~= nil then
			Player.Functions.RemoveItem('cherry_juice', 1)
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["cherry_juice"], "remove", 1 )
				Player.Functions.AddMoney('cash', Config.CherryJuicePrice)
				TriggerEvent('qb-log:server:CreateLog', 'visne', 'Vişne', 'red', " "..GetPlayerName(source) .. " (citizenid: "..citizen.." | id: "..id..")**" .. " " .. Config.CherryJuicePrice.. "$ Değerinde vişne sattı")
				--TriggerClientEvent('QBCore:Notify', source,  "~y~x1~s~ ~y~Vişne Suyu~s~ sattın", "success")
				SellCherryJuice(source)
			else
				TriggerClientEvent('QBCore:Notify', source,  "~r~Satmak için yeterli vişne suyu yok~s~", "info")
			end
		end
	end)
 end

RegisterServerEvent('alpha:startSellCherryJuice')
AddEventHandler('alpha:startSellCherryJuice', function()


	PlayersSellingCherryJuice[source] = true

	TriggerClientEvent('QBCore:Notify', source,  "~y~İşlem başladı.~s~. Hareket etmeyin", "success")

	SellCherryJuice(source)

 end)

RegisterServerEvent('alpha:stopSellCherryJuice')
AddEventHandler('alpha:stopSellCherryJuice', function()


	 PlayersSellingCherryJuice[source] = false

 end)

RegisterServerEvent('alpha:GetUserInventory')
AddEventHandler('alpha:GetUserInventory', function(currentZone) 
	local xPlayer = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('alpha:ReturnInventory', source, currentZone)
end)