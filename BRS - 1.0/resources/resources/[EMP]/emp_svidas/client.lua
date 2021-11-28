local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_svidas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local CoordenadaX = -1491.58
local CoordenadaY = -1026.33
local CoordenadaZ = 6.29
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DE ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
local entregas = { 
	[1] = { x=-1534.61,y=-1223.58, z=2.19 },
	[2] = { x=-1491.26,y=-1325.43,z=2.55 },
	[3] = { x=-1456.32,y=-1402.25,z=2.58 },
	[4] = { x=-1384.89,y=-1556.93,z=2.61 },
	[5] = { x=-1295.75,y=-1712.17, z=2.59 },
	[6] = { x=-1777.71,y=-901.21,z=6.59 },
	[7] = { x=-1850.64,y=-797.19,z=5.89 },
	[8] = { x=-1979.12,y=-646.62,z=4.79 },
	[9] = { x=-2044.23,y=-557.06,z=7.15 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not emservico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,255,0,0,0,0)
				if distance <= 1.2 then
					drawTxt("PRESSIONE ~b~[E]~w~ PARA INICIAR O SERVIÇO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPermission() then
								TriggerEvent('chatMessage',"^2Você iniciou o expediente. Pressione [F7] para sair do expediente. (obs: você precisa estar com o quadriciculo)")
								emservico = true
								destino = 1
								CriandoBlip(entregas,destino)
								TriggerEvent('NZK:bloquearH',true)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if emservico then
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
            if distance <= 50 then
                DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.70,0,0,0,0,180.0,130.0,2.0,2.0,1.0,211,176,72,100,1,0,0,1)
                if distance <= 2.5 then
                    drawTxt("PRESSIONE ~b~[E]~w~ PARA IR PARA A PROXIMA PESSOA",4,0.5,0.93,0.50,255,255,255,180)
                    local vehicle = GetPlayersLastVehicle()
					if IsControlJustPressed(0,38) then
							if IsVehicleModel(vehicle,GetHashKey("blazer2")) and not IsPedInAnyVehicle(PlayerPedId()) then
								RemoveBlip(blip)
								vRP._playAnim(false,{{"amb@medic@standing@tendtodead@idle_a","idle_a"}},true)
								if destino == 9 then
									if emP.checkPayment() then
										emservico = false
										TriggerEvent('chatMessage',"^2Acabou seu turno por agora, volte a central para pegar mais kits de primeiros socorros.")
									end
								else
									if emP.checkPayment() then
										destino = destino + 1
									end
								end
								CriandoBlip(entregas,destino)
								TriggerEvent('NZK:bloquearH',true)
							end
                    end
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if emservico then
			if IsControlJustPressed(0,168) then
				emservico = false
				RemoveBlip(blip)
				TriggerEvent('NZK:bloquearH',false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCOES
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

function CriandoBlip(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Salva Vidas")
	EndTextCommandSetBlipName(blip)
end