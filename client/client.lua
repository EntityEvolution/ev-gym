local CreateThread = CreateThread

isCardActive = false
ESX = nil

CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Wait(250)
	end
	while ESX.GetPlayerData() == nil or ESX.GetPlayerData().inventory == nil do
	  Wait(100)
	end
	xPlayer = ESX.GetPlayerData()
	for i=1, #xPlayer.inventory, 1 do
	  	if xPlayer.inventory[i].name == 'gymcard' and  xPlayer.inventory[i].count > 0 then
			isCardActive = true
		  break
	  	end
	end
end)
  
RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item)
	if item == 'gymcard' then
	    isCardActive = true
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item)
	if item == 'gymcard' then
	    isCardActive = false
	end
end)