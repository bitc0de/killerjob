local place = {x = 2317.86, y = 2550.18, z = 43.69}
local ped = {x = 2317.86, y = 2550.18, z = 46.69, h = 307.89}
local target = {
    [1] = {x = 2701.31, y = 1690.37, z = 23.61},
    [2] = {x = 1598.18, y = 3878.61, z = 30.36},
    [3] = {x = 1311.73, y = 4307.57, z = 36.93},
    [4] = {x = 451.02, y = -4.3, z = 113.45},
    [5] = {x = 963.42, y = -1895.99, z = 30.15},
    [6] = {x = -666.8, y = -675.89, z = 30.36},
    [7] = {x = -525.97, y = -1009.66, z = 22.09},
}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		DrawMarker(1, place.x, place.y, place.z - 1 , 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,52,155,0, 200, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(place.x, place.y, place.z - 1, x,y,z) < 1.5 then
			ESX.ShowHelpNotification("'Hey! I need you to do a little job for me... Can you take care of a guy?' ~g~Press [E]")
			if IsControlJustPressed(1,38) then
				objetivo()
			end
		end
	end
end)

Citizen.CreateThread(function()
	local hash = GetHashKey("g_m_y_lost_01")
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVFEMALE", "g_m_y_lost_01", ped.x, ped.y, ped.z, ped.h, false, true)
	PlayEntityAnim(ped, "base", "amb@world_human_cop_idles@male@base", 8.0, true, 1, 0, 0, 0)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
end)

function objetivo()
	local wait = true
	local hash2 = GetHashKey("s_m_m_fiboffice_01")
	while not HasModelLoaded(hash2) do
		RequestModel(hash2)
		Wait(20)
	end
	local result = target[math.random(#target)]
	ped2 = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_fiboffice_01", result.x, result.y, result.z, false, true)
	AddBlipForEntity(ped2)
	SetBlockingOfNonTemporaryEvents(ped2, true)
	FreezeEntityPosition(ped2, true)
	while wait do
		Citizen.Wait(0)
		if IsPedDeadOrDying(ped2,true) then
			cobrar()
			DeleteEntity(ped2)
			wait = false
		end
	end
end

function cobrar()
	local wait2 = true
	while wait2 do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		DrawMarker(1, place.x, place.y, place.z - 1 , 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,52,155,0, 200, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(place.x, place.y, place.z - 1, x,y,z) < 1.5 then
			ESX.ShowHelpNotification("'Perfect, thanks for taking care of him. Take some money for your trouble!' ~g~Press [E]")
				if IsControlJustPressed(1,38) then
					wait2 = false
					TriggerServerEvent('killerjob:cobrarpasta')
					Citizen.Wait(120000)
					
				
			end
		end
	end
	
end



