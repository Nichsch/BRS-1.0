local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_tartaruga")
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
local tartaruga = {
	{1,-1413.86,5228.08,2.03 },
	{2,-1405.54,5236.47,2.25 },
	{3,-1399.93,5244.38,1.94 },
	{4,-1394.09,5263.55,1.9 },
	{5,-1385.18,5312.67,1.94 },
	{6,-1393.82,5348.73,1.54 },
	{7,-1373.85,5375.02,1.65 },
	{8,-1328.75,5375.22,1.78 },
	{9,-1276.24,5385.75,1.63 },
	{10,-1180.04,5391.2,2.03 }

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FABRICAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not processo then
			for _,func in pairs(tartaruga) do
				local ped = PlayerPedId()
				local i,x,y,z = table.unpack(func)
				local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z)
				if distancia <= 50 and list[i] == nil then
					DrawMarker(21,x,y,z,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,25,1,0,0,1)
					if distancia <= 1.2 then
						drawTxt("PRESSIONE  ~b~[E]~w~  PARA PEGAR A TARTARUGA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							if emP.checkPermission() then
								if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_KNIFE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SWITCHBLADE") then
									list[i] = true
									processo = true
									segundos = 5
									emP.checkPayment()
									SetEntityCoords(ped,x,y,z-1)
									SetEntityHeading(ped,100.0)
									vRP._playAnim(false,{{"melee@hatchet@streamed_core","plyr_front_takedown_b"}},true)
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
			drawTxt("AGUARDE ~b~"..segundos.."~w~ SEGUNDOS ATÉ ACERTAR A TARTARUGA",4,0.5,0.93,0.50,255,255,255,180)
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
			local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),-103.88,6206.67,31.03)
			if distancia <= 50 then
				DrawMarker(21,-103.88,6206.67,31.03,0,0,0,0,180.0,130.0,0.6,0.8,0.5,98,163,41,25,1,0,0,1)
				if distancia <= 1.2 then
					drawTxt("PRESSIONE  ~b~[E]~w~  PARA REMOVER O CASCO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPermission() then
							emP.checkPayment2() 
							processando = true
							segundos = 10
							TriggerEvent('cancelando',true)
							TriggerEvent('NZK:bloquearH',true)
						end
					end
				end
			end
		end
		if processando then
			drawTxt("AGUARDE ~b~"..segundos.."~w~ ATÉ REMOVER O CASCO",4,0.5,0.93,0.50,255,255,255,180)
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