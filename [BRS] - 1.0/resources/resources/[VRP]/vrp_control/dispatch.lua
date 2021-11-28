-----------------------------------------------------------------------------------------------------------------------------------------
-- DANO DAS ARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
 Citizen.CreateThread(function()
	while true do
			Citizen.Wait(1)
			-- https://gtamods.com/wiki/Weapon_Types
			N_0x4757f00bc6323cfe(-544306709, 0.0) 
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.1)
			N_0x4757f00bc6323cfe(487013001, 0.0)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"), 1.2) 
			N_0x4757f00bc6323cfe(171789620, 0.0)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPDW"), 1.3) 
			N_0x4757f00bc6323cfe(-1074790547, 0.0)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"), 1.6) 
			N_0x4757f00bc6323cfe(3219281620, 0.0)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL_MK2"), 1.3) 
			N_0x4757f00bc6323cfe(-656458692, 0.0)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"), 3.0) 
	end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,120 do 
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS DO DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		players = {}
		for i = 0,256 do
			if NetworkIsPlayerActive(i) then
				table.insert(players,i)
			end
		end
		SetDiscordAppId(744318562944024618)
		SetDiscordRichPresenceAsset('brs')
		SetRichPresence("discord.gg/brsrp")
	end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS DO DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		players = {}
		for i = 0,256 do
			if NetworkIsPlayerActive(i) then
				table.insert(players,i)
			end
		end
		SetDiscordAppId(744318562944024618)
		SetDiscordRichPresenceAsset('brs')
		SetRichPresence("Jogadores Online: "..#players)
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVAR WEAPONS NPCS E DROP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do
	Citizen.Wait(1)
		DisablePlayerVehicleRewards(PlayerId())
	end
end)

Citizen.CreateThread(function()
    while true do
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
        Citizen.Wait(3000)
    end
end)

Citizen.CreateThread(function()
	while true do
		local handle, ped = FindFirstPed()
		local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
		repeat
			if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) then
				SetEntityAsMissionEntity(ped,true,true)
				SetEntityAsNoLongerNeeded(ped)
				local model = GetEntityModel(ped)
				SetModelAsNoLongerNeeded(model)
				SetEntityAsMissionEntity(ped,true,true)
				DeleteEntity(ped)
			end
			finished, ped = FindNextPed(handle) -- first param returns true while entities are found
			if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) then
				SetEntityAsMissionEntity(ped,true,true)
				SetEntityAsNoLongerNeeded(ped)
				local model = GetEntityModel(ped)
				SetModelAsNoLongerNeeded(model)
				SetEntityAsMissionEntity(ped,true,true)
				DeleteEntity(ped)
			end
			if not IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) then
				RemoveAllPedWeapons(ped, true) -- prevents mod menu npcs
			end
			
		until not finished
		EndFindPed(handle)
		Citizen.Wait(60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId() 
		local vehicle = GetVehiclePedIsIn(ped)
		local speed = GetEntitySpeed(vehicle)*3.6
			if vehicle then
				if speed <= 60 then
					SetPlayerCanDoDriveBy(PlayerId(),true)
				elseif GetPedInVehicleSeat(vehicle, -1) == ped then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				else
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
				if GetEntityModel(vehicle) == GetHashKey("thrust") then
						SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			local speed = GetEntitySpeed(vehicle) * 2.236936
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				if speed <= 80.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RAGDOLL SE JOGAR NO CHÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local blockH = false

RegisterNetEvent('NZK:bloquearH')
AddEventHandler('NZK:bloquearH',function(status)
	blockH = status
end)

Citizen.CreateThread(function()
	local source = source
	while true do 
	Citizen.Wait(0)
		if IsControlJustPressed(0,104) and not IsPauseMenuActive() and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not blockH then
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			TriggerEvent("NZK:cancelarAcademia", source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STAMINA INFINITA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
	while true do
		 Citizen.Wait(0)
		 RestorePlayerStamina(PlayerId(), 1.0)
	 end
 end)
 ----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
-----------------------------------------------------------------------------------------------------------------------------------------
local radar = {
	shown = false,
	freeze = false,
	info = "INICIANDO O SISTEMA DO RADAR",
	info2 = "INICIANDO O SISTEMA DO RADAR"
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(1,306) and IsPedInAnyPoliceVehicle(PlayerPedId()) then
			if radar.shown then
				radar.shown = false
			else
				radar.shown = true
			end
		end

		if IsControlJustPressed(1,301) and IsPedInAnyPoliceVehicle(PlayerPedId()) then
			if radar.freeze then
				radar.freeze = false
			else
				radar.freeze = true
			end
		end

		if radar.shown then
			if radar.freeze == false then
				local veh = GetVehiclePedIsIn(PlayerPedId(),false)
				local coordA = GetOffsetFromEntityInWorldCoords(veh,0.0,1.0,1.0)
				local coordB = GetOffsetFromEntityInWorldCoords(veh,0.0,105.0,0.0)
				local frontcar = StartShapeTestCapsule(coordA,coordB,3.0,10,veh,7)
				local a,b,c,d,e = GetShapeTestResult(frontcar)

				if IsEntityAVehicle(e) then
					local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
					local fvspeed = GetEntitySpeed(e)*2.236936
					local fplate = GetVehicleNumberPlateText(e)
					radar.info = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MPH",fplate,fmodel,math.ceil(fvspeed))
				end

				local bcoordB = GetOffsetFromEntityInWorldCoords(veh,0.0,-105.0,0.0)
				local rearcar = StartShapeTestCapsule(coordA,bcoordB,3.0,10,veh,7)
				local f,g,h,i,j = GetShapeTestResult(rearcar)

				if IsEntityAVehicle(j) then
					local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
					local bvspeed = GetEntitySpeed(j)*2.236936
					local bplate = GetVehicleNumberPlateText(j)
					radar.info2 = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MPH",bplate,bmodel,math.ceil(bvspeed))
				end
			end
			drawTxt(radar.info,4,0.5,0.905,0.50,255,255,255,180)
			drawTxt(radar.info2,4,0.5,0.93,0.50,255,255,255,180)
		end

		if not IsPedInAnyVehicle(PlayerPedId()) and radar.shown then
			radar.shown = false
		end
	end
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end