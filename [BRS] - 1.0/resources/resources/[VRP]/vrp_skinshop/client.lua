-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_skinshop",src)
vSERVER = Tunnel.getInterface("vrp_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
	{72.2545394897461,-1399.10229492188,29.3761386871338},
	{-703.77685546875,-152.258544921875,37.4151458740234},
	{-167.863754272461,-298.969482421875,39.7332878112793},
	{428.694885253906,-800.1064453125,29.4911422729492},
	{-829.413269042969,-1073.71032714844,11.3281078338623},
	{-1193.42956542969,-772.262329101563,17.3244285583496},
	{-1447.7978515625,-242.461242675781,49.8207931518555},
	{11.6323690414429,6514.224609375,31.8778476715088},
	{1696.29187011719,4829.3125,42.0631141662598},
	{123.64656829834,-219.440338134766,54.5578384399414},
	{618.093444824219,2759.62939453125,42.0881042480469},
	{1190.55017089844,2713.44189453125,38.2226257324219},
	{-3172.49682617188,1048.13330078125,20.8632030487061},
	{-1108.44177246094,2708.92358398438,19.1078643798828},
	{-308.10720825195,-1056.7779541016,73.885612487793},
	{104.93124389648,-1303.5306396484,28.768798828125},
	{389.16,279.72,95.0},
	{-811.67,175.09,76.75},
	{9.45,528.64,170.64},
	{-1531.79,142.8,55.67},
	{-1887.32,2070.09,145.58},
	{-3218.89,784.09,14.09},
	{-3218.56,800.55,14.09},
	{643.23,-343.51,34.04},
	{116.68,-732.51,242.16},
	{456.72,-989.36,30.69},
	{1078.23,3590.0,35.26},
	{340.29,3560.74,34.83},
	{2014.95,3920.31,35.62},
	{-198.43,2965.34,31.17},
	{-600.85,6259.04,14.4},
	{1436.87,6558.32,16.55},
	{2026.97,3328.41,48.6},
	{186.28,6835.49,24.24},
	{1363.04,4499.81,60.75},
	{-129.3,2982.63,36.38},
	{-2619.45,1711.59,146.33},
	{-1981.41,-499.86,20.74},
	{2067.97,3405.74,48.36},
	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
			for _,func in pairs(localidades) do 
				local ped = PlayerPedId()
				local x,y,z = table.unpack(func)
				local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
				if distancia <= 5 then
					DrawMarker(23,x,y,z-0.9,0,0,0,0.0,0,0,2.0,2.0,0.4,0,95,140,50,0,0,0,1)
					if distancia <= 2 and IsControlJustPressed(0,38) and not vRP.isHandcuffed() and not IsPedInAnyVehicle(ped) then	
						TriggerEvent("skinshop:toggleMenu")
						TriggerEvent('chatMessage',"^9LOJA: ^2Pressione [A]/[D] para rotacionar, Pressione [<] [>] Para mudar a cor, Pressione [DEL] para resetar a skin ou [ESC] para sair.")
					end
				end
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN NUI
-----------------------------------------------------------------------------------------------------------------------------------------
local cor = 0
local menuactive = false
local old_custom = {}
RegisterNetEvent("skinshop:toggleMenu")
AddEventHandler("skinshop:toggleMenu",function()
	menuactive = not menuactive
	if menuactive then
		old_custom = vRP.getCustomization(source)
		SetNuiFocus(true,true)
		local ped = PlayerPedId()
		if IsPedModel(ped,0x705E61F2) then
			SendNUIMessage({ showMenu = true, masc = true })
		else
			SendNUIMessage({ showMenu = true, masc = false })
		end
	else
		cor = 0
		dados,tipo = nil
		SetNuiFocus(false)
		SendNUIMessage({ showMenu = false, masc = true })
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if menuactive then InvalidateIdleCam() end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTER NUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate",function(data,cb)
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	if data == "left" then
		SetEntityHeading(ped,heading+25)
	elseif data == "right" then
		SetEntityHeading(ped,heading-25)
	elseif data == "resetarRoupa" then
		if(GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) then
				SetPedComponentVariation(ped, 3, 15,0,2)
				SetPedComponentVariation(ped, 5, 0,0,0)
				SetPedComponentVariation(ped, 7, 0,0,0)
				SetPedComponentVariation(ped, 8, 15,0,2)
				SetPedComponentVariation(ped, 9, 0,1,2)
				SetPedComponentVariation(ped, 11, 252,0,2)
				SetPedComponentVariation(ped, 4, 61,0,2)
				SetPedComponentVariation(ped, 5, 0,0,0)
				SetPedComponentVariation(ped, 7, 0,0,0)
				SetPedComponentVariation(ped, 9, 0,1,2)
				SetPedComponentVariation(ped, 5, 0,0,0)
				SetPedComponentVariation(ped, 6, 34,0,2)
				SetPedComponentVariation(ped, 7, 0,0,0)
				SetPedComponentVariation(ped, 9, 0,1,2)
				SetPedComponentVariation(ped,1,0,0,2)
				ClearPedProp(ped,0)
				ClearPedProp(ped,1)
				ClearPedProp(ped,2)
				ClearPedProp(ped,3)
				ClearPedProp(ped,4)
				ClearPedProp(ped,5)
				ClearPedProp(ped,6)
				ClearPedProp(ped,10)
		else
			if(GetEntityModel(ped) == GetHashKey("mp_f_freemode_01")) then
				SetPedComponentVariation(ped,1,0,0,2)
				SetPedComponentVariation(ped, 3, 15,0,2)
				SetPedComponentVariation(ped, 5, 0,0,0)
				SetPedComponentVariation(ped, 7, 0,0,0)
				SetPedComponentVariation(ped, 8, 3,0,2)
				SetPedComponentVariation(ped, 9, 0,1,2)
				SetPedComponentVariation(ped, 11, 82,0,2)
				SetPedComponentVariation(ped, 4, 17,0,2)
				SetPedComponentVariation(ped, 5, 0,0,0)
				SetPedComponentVariation(ped, 7, 0,0,0)
				SetPedComponentVariation(ped, 9, 0,1,2)
				SetPedComponentVariation(ped, 5, 0,0,0)
				SetPedComponentVariation(ped, 6, 35,0,2)
				SetPedComponentVariation(ped, 7, 0,0,0)
				SetPedComponentVariation(ped, 9, 0,1,2)
				ClearPedProp(ped,0)
				ClearPedProp(ped,1)
				ClearPedProp(ped,2)
				ClearPedProp(ped,3)
				ClearPedProp(ped,4)
				ClearPedProp(ped,5)
				ClearPedProp(ped,6)
				ClearPedProp(ped,10)
			end
		end
	end
end)

RegisterNUICallback("color",function(data,cb)
	if data == "left" then
		if cor ~= 0 then cor = cor - 1 else cor = 25 end
	elseif data == "right" then
		if cor ~= 25 then cor = cor + 1 else cor = 0 end
	end
	if dados and tipo then setClothes(dados,tipo,cor) end
end)

RegisterNUICallback("update",function(data,cb)
	dados = tonumber(json.encode(data[1]))
	tipo = tonumber(json.encode(data[2]))
	cor = 0
	setClothes(dados,tipo,cor)
end)

RegisterNUICallback("exit",function()
	vSERVER.shopBuy(old_custom)
	TriggerEvent("skinshop:toggleMenu")	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function setClothes(dados,tipo,cor)
	local ped = PlayerPedId()
	if dados < 100 then		

		print(dados,tipo,cor.." TIPO 1")
		SetPedComponentVariation(ped,dados,tipo,cor,1) 
	else
		print(dados,tipo,cor.." TIPO 2")
		SetPedPropIndex(ped,dados-100,tipo,cor,1)
	end
end