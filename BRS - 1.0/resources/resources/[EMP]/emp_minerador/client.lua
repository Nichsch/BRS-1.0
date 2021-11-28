local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_minerador") 
vRP = Proxy.getInterface("vRP")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local minerando = false
local delay = false
local selecionado = 0
local CoordenadaX = 2958.15
local CoordenadaY = 2753.91
local CoordenadaZ = 43.70

local locs = {
	[1] = { ['x'] = 2972.7177734375, ['y'] = 2774.5397949219, ['z'] = 39.459648132324 },
	[2] = { ['x'] = 2981.0263671875, ['y'] = 2782.0947265625, ['z'] = 40.16722869873 },
	[3] = { ['x'] = 2982.2451171875, ['y'] = 2787.0241699219, ['z'] = 41.183250427246 },
	[4] = { ['x'] = 2979.6462402344, ['y'] = 2790.3930664063, ['z'] = 41.596611022949 },
	[5] = { ['x'] = 2976.9572753906, ['y'] = 2792.8498535156, ['z'] = 41.319744110107 },
	[6] = { ['x'] = 2976.4045410156, ['y'] = 2794.8647460938, ['z'] = 41.659385681152 },
	[7] = { ['x'] = 2976.4724121094, ['y'] = 2796.2780761719, ['z'] = 41.502723693848 },
	[8] = { ['x'] = 2972.4758300781, ['y'] = 2799.744140625, ['z'] = 42.174468994141 },
	[9] = { ['x'] = 2959.2470703125, ['y'] = 2819.7414550781, ['z'] = 43.700695037842 },
	[10] = { ['x'] = 2955.9260253906, ['y'] = 2819.9584960938, ['z'] = 43.18359375 },
	[11] = { ['x'] = 2951.2607421875, ['y'] = 2816.3415527344, ['z'] = 42.868480682373 },
	[12] = { ['x'] = 2948.134765625, ['y'] = 2820.693359375, ['z'] = 43.587429046631 },
	[13] = { ['x'] = 2944.7885742188, ['y'] = 2820.2719726563, ['z'] = 43.517150878906 },
	[14] = { ['x'] = 2944.2744140625, ['y'] = 2818.7370605469, ['z'] = 43.536727905273 },
	[15] = { ['x'] = 2938.2827148438, ['y'] = 2812.9704589844, ['z'] = 43.434886932373 },
	[16] = { ['x'] = 2937.03125, ['y'] = 2814.0549316406, ['z'] = 43.960079193115 },
	[17] = { ['x'] = 2931.5769042969, ['y'] = 2816.833984375, ['z'] = 45.5227394104 },
	[18] = { ['x'] = 2925.99609375, ['y'] = 2813.6528320313, ['z'] = 45.729145050049 },
	[19] = { ['x'] = 2918.1967773438, ['y'] = 2800.1560058594, ['z'] = 41.847324371338 },
	[20] = { ['x'] = 2925.435546875, ['y'] = 2796.1330566406, ['z'] = 41.421092987061 },
	[21] = { ['x'] = 2925.3974609375, ['y'] = 2794.7966308594, ['z'] = 41.547267913818 },
	[22] = { ['x'] = 2928.1179199219, ['y'] = 2790.5522460938, ['z'] = 40.856628417969 },
	[23] = { ['x'] = 2928.0178222656, ['y'] = 2788.8142089844, ['z'] = 40.604320526123 },
	[24] = { ['x'] = 2930.6042480469, ['y'] = 2786.8618164063, ['z'] = 40.114734649658 },
	[25] = { ['x'] = 2934.4692382813, ['y'] = 2783.9399414063, ['z'] = 39.964252471924 },
	[26] = { ['x'] = 2937.0749511719, ['y'] = 2774.5034179688, ['z'] = 39.724590301514 },
	[27] = { ['x'] = 2938.6174316406, ['y'] = 2774.0944824219, ['z'] = 39.740966796875 },
	[28] = { ['x'] = 2938.8818359375, ['y'] = 2768.8215332031, ['z'] = 39.677150726318 },
	[29] = { ['x'] = 2947.79296875, ['y'] = 2765.5524902344, ['z'] = 40.625110626221 },
	[30] = { ['x'] = 2948.0629882813, ['y'] = 2767.7692871094, ['z'] = 39.848472595215 },
	[31] = { ['x'] = 2947.6394042969, ['y'] = 2754.5344238281, ['z'] = 43.960182189941 },
	[32] = { ['x'] = 2943.1977539063, ['y'] = 2756.7839355469, ['z'] = 43.477352142334 },
	[33] = { ['x'] = 2942.3747558594, ['y'] = 2760.4953613281, ['z'] = 42.753929138184 },
	[34] = { ['x'] = 2930.7778320313, ['y'] = 2761.90234375, ['z'] = 45.085033416748 },
	[35] = { ['x'] = 2928.8059082031, ['y'] = 2765.5266113281, ['z'] = 44.653964996338 },
	[36] = { ['x'] = 2955.7275390625, ['y'] = 2756.1975097656, ['z'] = 44.441299438477 },
	[37] = { ['x'] = 2954.0515136719, ['y'] = 2754.4641113281, ['z'] = 43.96561050415 },
	[38] = { ['x'] = 2988.1442871094, ['y'] = 2754.2800292969, ['z'] = 43.492107391357 },
	[39] = { ['x'] = 2993.5485839844, ['y'] = 2753.6252441406, ['z'] = 43.686496734619 },
	[40] = { ['x'] = 2993.5793457031, ['y'] = 2751.9775390625, ['z'] = 44.088680267334 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIAR COLETA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)
			if not servico then
			if distance <= 30.0 then
				DrawMarker(25,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,255,0,0,0,0)
				if distance <= 2.5 then
					drawTxt("PRESSIONE  ~b~[E]~w~ PARA INICIAR A MINERAÇÃO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPermission() then
								servico = true
								selecionado = 1
								CriandoBlip(locs,selecionado)
								TriggerEvent('chatMessage',"^2Você iniciou a mineração. Pressione [F7] para parar a mineração.")
								TriggerEvent('NZK:bloquearH',true)
						end
					end
				end		
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLETAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z,0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)
				if distance <= 1.5 then
					drawTxt("PRESSIONE ~b~[E]~w~ PARA COLETAR A ROCHA",4,0.5,0.93,0.50,255,255,255,180)

					if IsControlJustPressed(0,38) then
						if not delay then
								vRP.CarregarObjeto("amb@world_human_const_drill@male@drill@base","base","prop_tool_jackham",15,28422)
								minerando = true
								delay = true
								TriggerEvent('NZK:bloquearH',true)
						end
					end

					if not minerando then
						vRP.DeletarObjeto()
						ClearPedTasks(GetPlayerPed(-1))
					end

				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NZK:mineradorNewRoute") 
AddEventHandler("NZK:mineradorNewRoute", function() 
		if selecionado == #locs then
			selecionado = 1
		else
			selecionado = selecionado + 1
		end
		CriandoBlip(locs,selecionado)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if minerando then
		local ped = PlayerPedId()
			if GetEntityHealth(ped) > 100 then
				Citizen.Wait(15*1000)
				emP.checkPayment()
				minerando = false
				delay = false
				RemoveBlip(blips)
				vRP.DeletarObjeto()
				ClearPedTasks(GetPlayerPed(-1))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent('NZK:bloquearH',false)
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawText3d(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

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

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.3)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar Rocha")
	EndTextCommandSetBlipName(blips)
end