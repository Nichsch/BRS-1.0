local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_produzir")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
--------------------------------------- --------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 2041.79, ['y'] = 3013.53, ['z'] = -72.70, ['heading'] = 51.83, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x ~b~RG Falso", ['tempoproduzir'] = 20, ['aMain'] = "amb@prop_human_parking_meter@female@idle_a", ['aIdle'] = "idle_a_female", ['distanciaView'] = 2.0},
	{ ['id'] = 2, ['x'] = 2018.21, ['y'] = 3018.44, ['z'] = -72.70, ['heading'] = 131.43, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x ~b~Escudo", ['tempoproduzir'] = 80, ['aMain'] = "amb@prop_human_parking_meter@female@idle_a", ['aIdle'] = "idle_a_female", ['distanciaView'] = 2.0}, 
	
	{ ['id'] = 3, ['x'] = 319.15, ['y'] = -600.90, ['z'] = 48.22, ['heading'] = 251.12, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x ~b~Dipiroca", ['tempoproduzir'] = 40, ['aMain'] = "amb@prop_human_parking_meter@female@idle_a", ['aIdle'] = "idle_a_female", ['distanciaView'] = 1.2},
	{ ['id'] = 4, ['x'] = 312.99, ['y'] = -593.76, ['z'] = 48.22, ['heading'] = 63.95, ['text'] = "PRESSIONE ~v~[E]~w~ PARA PRODUZIR 1x ~b~Navagina", ['tempoproduzir'] = 40, ['aMain'] = "amb@prop_human_parking_meter@female@idle_a", ['aIdle'] = "idle_a_female", ['distanciaView'] = 1.2},
	
	{ ['id'] = 5, ['x'] = -573.66, ['y'] = -1601.72, ['z'] = 27.08, ['heading'] = 272.95, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x ~b~Pacote", ['tempoproduzir'] = 20, ['aMain'] = "amb@prop_human_parking_meter@female@idle_a", ['aIdle'] = "idle_a_female", ['distanciaView'] = 1.2},
	{ ['id'] = 6, ['x'] = -599.70, ['y'] = -1607.89, ['z'] = 27.01, ['heading'] = 359.78, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x ~b~Lock Pick", ['tempoproduzir'] = 25, ['aMain'] = "amb@prop_human_parking_meter@female@idle_a", ['aIdle'] = "idle_a_female", ['distanciaView'] = 1.2},
	{ ['id'] = 7, ['x'] = -601.32, ['y'] = -1607.70, ['z'] = 27.24, ['heading'] = 359.10, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x ~b~Ticket", ['tempoproduzir'] = 25, ['aMain'] = "amb@prop_human_parking_meter@female@idle_a", ['aIdle'] = "idle_a_female", ['distanciaView'] = 1.2},
	
	{ ['id'] = 8, ['x'] = 899.30, ['y'] = -3223.63, ['z'] = -98.26, ['heading'] = 33.64, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x Five Seven", ['tempoproduzir'] = 15, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 9, ['x'] = 897.66, ['y'] = -3221.44, ['z'] = -98.24, ['heading'] = 212.34, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR Munição de Five Seven", ['tempoproduzir'] = 10, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 10, ['x'] = 896.03, ['y'] = -3218.71, ['z'] = -98.22, ['heading'] = 66.16, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x AK-47", ['tempoproduzir'] = 20, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 11, ['x'] = 897.46, ['y'] = -3216.05, ['z'] = -98.22, ['heading'] = 69.56, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR Munição de AK-47", ['tempoproduzir'] = 10, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 12, ['x'] = 907.04, ['y'] = -3230.42, ['z'] = -98.29, ['heading'] = 183.61, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x MTAR-21", ['tempoproduzir'] = 20, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 13, ['x'] = 904.56, ['y'] = -3230.54, ['z'] = -98.29, ['heading'] = 183.61, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR Munição de MTAR-21", ['tempoproduzir'] = 10, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 14, ['x'] = 907.93, ['y'] = -3211.50, ['z'] = -98.22, ['heading'] = 21.46, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x Shotgun", ['tempoproduzir'] = 20, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 15, ['x'] = 910.01, ['y'] = -3210.17, ['z'] = -98.22, ['heading'] = 31.29, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR Munição de Shotgun", ['tempoproduzir'] = 10, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 17, ['x'] = 887.35, ['y'] = -3209.65, ['z'] = -98.19, ['heading'] = 202.97, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x Pack de Componente", ['tempoproduzir'] = 15, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 18, ['x'] = 892.03, ['y'] = -3197.51, ['z'] = -98.19, ['heading'] = 12.76, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR Componentes", ['tempoproduzir'] = 10, ['distanciaView'] = 2.0},
	{ ['id'] = 19, ['x'] = -331.79, ['y'] = -2444.7, ['z'] = 7.36, ['heading'] = 231.25, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PROCESSAR 1x COCAINA", ['tempoproduzir'] = 2, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 20, ['x'] = -111.96, ['y'] = -7.1, ['z'] = 70.52, ['heading'] = 70.102, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PROCESSAR 1x MACONHA", ['tempoproduzir'] = 2, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 3.0},
	{ ['id'] = 22, ['x'] = 901.62, ['y'] = -3219.29, ['z'] = -98.24, ['heading'] = 296.44, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x Fuzil Avançado", ['tempoproduzir'] = 20, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 23, ['x'] = 892.28, ['y'] = -3221.61, ['z'] = -98.22, ['heading'] = 29.01, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR Munição de Fuzil Avançado", ['tempoproduzir'] = 10, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 24, ['x'] = 905.58, ['y'] = -3211.79, ['z'] = -98.22, ['heading'] = 316.05, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR 1x HK310M", ['tempoproduzir'] = 15, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 25, ['x'] = 893.76, ['y'] = -3220.77, ['z'] = -98.23, ['heading'] = 40.53, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PRODUZIR Munição de HK310M", ['tempoproduzir'] = 30, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 26, ['x'] = 910.01806640625, ['y'] = -3222.248046875, ['z'] = -98.265869140625, ['heading'] = 288.91, ['text'] = "PRESSIONE ~b~[E]~w~ PARA PRODUZIR 1x Colete", ['tempoproduzir'] = 20, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},
	{ ['id'] = 28, ['x'] = 890.91, ['y'] = -959.11, ['z'] = 39.28, ['heading'] = 178.26, ['text'] = "PRESSIONE ~y~[E]~w~ PARA PROCESSAR 1x MD", ['tempoproduzir'] = 2, ['aMain'] = "mini@repair", ['aIdle'] = "fixing_a_player", ['distanciaView'] = 2.0},

}

Citizen.CreateThread(function()
	while true do
		local nichsch = 1000
		for k,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= v.distanciaView and not processo then
				nichsch = 5
				DrawMarker(27,v.x,v.y,v.z-0.97,0,0,0,0,0,0,3.5,3.5,0.5,255,0,255,50,0,0,0,0)
				drawTxt(v.text,4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) then
					
					if emP.checkPayment(v.id) then
						TriggerEvent('NZK:bloquearH',true)
						SetEntityHeading(ped, v.heading)
						print(v.heading)
						SetEntityCoords(PlayerPedId(),v.x,v.y,v.z-0.95)
						vRP._playAnim(false,{{v.aMain,v.aIdle}},true)
						processo = true
						TriggerEvent('cancelando',true)
						TriggerEvent("progress",v.tempoproduzir*1000,"produzindo")
						SetTimeout(v.tempoproduzir*1000,function()
							processo = false
							TriggerEvent('cancelando',false)
							ClearPedTasks(GetPlayerPed(-1))
							TriggerEvent('NZK:bloquearH',false)
						end)
					end
				end
			end
		end
		Citizen.Wait(nichsch)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
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