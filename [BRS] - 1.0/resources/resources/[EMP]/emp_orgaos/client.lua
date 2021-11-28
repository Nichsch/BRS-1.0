local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_orgaos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local processando = false
local vendendo = false
local segundos = 0
local list = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
local cadaver = {
	{1,-1708.19,-227.65,56.28 },
	{2,-1710.42,-228.22,56.28 },
	{3, -1712.21,-228.41,56.30 },
	{4,-1712.21,-228.41,56.30 },
	{5, -1719.08,-227.92,56.31 },
	{6, -1720.345,-227.60,56.33 },
	{7, -1721.74,-227.75,56.33 },
	{8, -1716.65,-228.80,56.30 },
	{9, -1715.04,-228.85,56.31 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FABRICAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not processo then
			for _,func in pairs(cadaver) do
				local ped = PlayerPedId()
				local i,x,y,z = table.unpack(func)
				local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
				if distancia <= 50 and list[i] == nil then
					DrawMarker(21,x,y,z,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,25,1,0,0,1)
					if distancia <= 1.2 then
						drawTxt("PRESSIONE  ~b~[E]~w~  PARA DESENTERRAR O CORPO",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							if emP.checkPermission() then
								if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_KNIFE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SWITCHBLADE") then
									list[i] = true
									processo = true
									segundos = 5
									emP.checkPayment()
									SetEntityCoords(ped,x,y,z-1)
									SetEntityHeading(ped,100.0)
									vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@base","base_female"}},true)
									TriggerEvent('cancelando',true)
									TriggerEvent('NZK:bloquearH',true)
								end
							end
						end
					end
				end
			end
		end
		if processo then
			drawTxt("AGUARDE ~b~"..segundos.."~w~ SEGUNDOS ATÉ DESENTERRAR O CORPO",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not processando then
			local ped = PlayerPedId()
			local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),981.76,-2120.69,30.47)
			if distancia <= 50 then
				DrawMarker(21,981.76,-2120.69,30.47,0,0,0,0,180.0,130.0,0.6,0.8,0.5,98,163,41,25,1,0,0,1)
				if distancia <= 1.2 then
					drawTxt("PRESSIONE  ~b~[E]~w~  PARA ESQUARTEJAR O CORPO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPermission() then
							emP.checkPayment2() 
							processando = true
							segundos = 8
							TriggerEvent('cancelando',true)
							TriggerEvent('NZK:bloquearH',true)
						end
					end
				end
			end
		end
		if processando then
			drawTxt("AGUARDE ~b~"..segundos.."~w~ ATÉ ESQUARTEJAR O CORPO",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not vendendo then
			local ped = PlayerPedId()
			local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),1275.8,-1710.66,54.78)
			if distancia <= 50 then
				DrawMarker(21,1275.8,-1710.66,54.78,0,0,0,0,180.0,130.0,0.6,0.8,0.5,98,163,41,25,1,0,0,1)
				if distancia <= 1.2 then
					drawTxt("PRESSIONE  ~b~[E]~w~  PARA VENDER OS ORGÃOS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPermission() then
							emP.checkPayment3() 
							vendendo = true
							segundos = 5
							TriggerEvent('cancelando',true)
							TriggerEvent('NZK:bloquearH',true)
						end
					end
				end
			end
		end
		if vendendo then
			drawTxt("AGUARDE ~b~"..segundos.."~w~ PARA TERMINAR DE VENDER",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if processo or processando or vendendo then
			if IsControlJustPressed(0,168) then
				processo = false
				processando = false
				vendendo = false
				vRP._stopAnim(false)
				TriggerEvent('NZK:bloquearH',false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if processo or processando or vendendo then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					processo = false
					processando = false
					vendendo = false
					vRP._stopAnim(false)
					TriggerEvent('cancelando',false)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(180000)
		list = {}
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