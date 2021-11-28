local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_entregador")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local CoordenadaX = 90.74
local CoordenadaY = 298.20
local CoordenadaZ = 110.21
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DE ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
local entregas = { 
    [1] = { x=250.46446228027,y=-1026.8046875, z=29.260652542114 },
    [2] = { x=285.33871459961,y=-160.48837280273,z=64.617111206055 },
    [3] = { x=-207.9102935791,y=163.50952148438,z=74.053115844727 },
    [4] = { x=561.08154296875,y=92.539459228516,z=96.064598083496 },
    [5] = { x=561.28900146484,y=92.65747833252, z=96.071823120117 },
    [6] = { x=-660.67724609375,y=-900.85656738281,z=24.612661361694 },
    [7] = { x=-1360.8308105469,y=-353.89926147461,z=36.678939819336 },
    [8] = { x=-1206.6668701172,y=-1263.5361328125,z=6.9641089439392 },
    [9] = { x=-81.314994812012,y=-1326.0635986328,z=29.264898300171 },
    [10] = { x=999.99737548828, y=-594.18713378906,z=59.638584136963 },
    [11] = { x=1090.4321289063,y=-484.35293579102,z=65.660194396973 },
    [12] = { x=-73.776908874512,y=428.78973388672,z=113.03832244873 },
    [13] = { x=-635.68579101563,y=44.660675048828,z=42.699493408203 },
    [14] = { x=393.90701293945, y=-896.11175537109,z=29.418685913086 },
    [15] = { x=358.66076660156,y=88.952041625977,z=100.36209869385 },
    [16] = { x=1327.7725830078,y=-1552.8608398438,z=54.051544189453 }
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
					drawTxt("PRESSIONE ~b~[E]~w~ PARA INICIAR A CORRIDA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
							if emP.checkPermission() then
									TriggerEvent('chatMessage',"^2Você iniciou o expediente. Pressione [F7] para sair do expediente. (obs: você precisa estar com a moto de entregador)")
									emservico = true
									destino = 1
									CriandoBlip(entregas,destino)
									TriggerEvent('NZK:bloquearH', true)
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
					drawTxt("PRESSIONE ~b~[E]~w~ PARA IR A PROXIMA CORRIDA",4,0.5,0.93,0.50,255,255,255,180)
					local vehicle = GetPlayersLastVehicle()
					if IsControlJustPressed(0,38) then
							if IsVehicleModel(vehicle,GetHashKey("enduro")) then
									RemoveBlip(blip)
									if destino == 16 then
										if emP.checkPayment() then
											emservico = false
											TriggerEvent('chatMessage',"^2Acabou as entregas por agora, volte a central para pegar mais.")
										end
									else
										if emP.checkPayment() then
											destino = destino + 1
										end
									end
									CriandoBlip(entregas,destino)
									else
										TriggerEvent('chatMessage',"^2Desconfiaram que você não era um entregador e não quiseram o pedido.")
									end
								end
							end
							TriggerEvent('NZK:bloquearH', true)
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
				TriggerEvent('NZK:bloquearH', false)
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
	AddTextComponentString("Entregas de comidas")
	EndTextCommandSetBlipName(blip)
end