local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_pescador")

local CoordenadaX = -1851.13
local CoordenadaY = -1232.98
local CoordenadaZ = 13.01

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local processo = false
local servico = false
local segundos = 0
local selecionado = 0

local pescaria = {
    [1] = { ['x'] = -1839.83, ['y'] = -1258.28, ['z'] = 8.61, ['heading'] = 142.192 },
    [2] = { ['x'] = -1843.18, ['y'] = -1255.63, ['z'] = 8.61, ['heading'] = 142.192 },
    [3] = { ['x'] = -1849.25, ['y'] = -1250.34, ['z'] = 8.61, ['heading'] = 142.192 },
    [4] = { ['x'] = -1851.87, ['y'] = -1247.86, ['z'] = 8.61, ['heading'] = 142.192 },
    [5] = { ['x'] = -1850.92, ['y'] = -1249.49, ['z'] = 8.61, ['heading'] = 143.56 },
    [6] = { ['x'] = -1837.46, ['y'] = -1260.72, ['z'] = 8.61, ['heading'] = 140.83 },
    [7] = { ['x'] = -1832.98, ['y'] = -1264.42, ['z'] = 8.61, ['heading'] = 139.41 },
    [8] = { ['x'] = -1827.45, ['y'] = -1269.46, ['z'] = 8.61, ['heading'] = 139.52 },
    [9] = { ['x'] = -1825.00, ['y'] = -1268.56, ['z'] = 8.61, ['heading'] = 231.79 },
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
					drawTxt("PRESSIONE  ~b~[E]~w~ PARA INICIAR A PESCARIA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPermission() then
								servico = true
                                selecionado = math.random(9)
                                CriandoBlip(pescaria,selecionado)
								TriggerEvent('chatMessage',"^2Você iniciou a pesca. Pressione [F7] para parar a pescaria.")
								TriggerEvent('NZK:bloquearH',true)
						end
					end
				end		
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PESCANDO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not processo and servico then
            local ped = PlayerPedId()
                local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped), pescaria[selecionado].x,pescaria[selecionado].y,pescaria[selecionado].z)
                if distancia <= 30.0 then
                    DrawMarker(21,pescaria[selecionado].x,pescaria[selecionado].y,pescaria[selecionado].z,0,0,0,0,180.0,130.0,1.0,1.0,0.5, 25,140,255,180 ,1,0,0,1)
                    if distancia <= 1 then
                        drawTxt("PRESSIONE ~b~[E]~w~ PARA PESCAR",4,0.5,0.93,0.50,255,255,255,180)
                        if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
                            if emP.checkPermission() then
                                    if selecionado == 9 then
                                        selecionado = math.random(9)
                                    else
                                        selecionado = math.random(9)
                                    end

                                    SetEntityHeading(ped, pescaria[selecionado].heading)
                                    processo = true
                                    segundos = 30
                                    CriandoBlip(pescaria,selecionado)
                                    if not IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
                                        vRP._CarregarObjeto("amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",15,60309)
                                    end
                                    TriggerEvent('cancelando',true)
                                    TriggerEvent('NZK:bloquearH',true)
                            end
                        end
                    end
                end
        end
        if processo then
            drawTxt("AGUARDE ~b~"..segundos.."~w~ SEGUNDOS ATÉ FISGAR UM PEIXE",4,0.5,0.93,0.50,255,255,255,180)
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
				processo = false
                servico = false
				RemoveBlip(blips)
				TriggerEvent('NZK:bloquearH',false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				if emP.checkPayment() then
					processo = false
					vRP._stopAnim(false)
					vRP._DeletarObjeto()
                    TriggerEvent('cancelando',false)
                    TriggerEvent('NZK:bloquearH',false)
				else
					processo = false
					vRP._stopAnim(false)
					vRP._DeletarObjeto()
                    TriggerEvent('cancelando',false)
                    TriggerEvent('NZK:bloquearH',false)
				end
			end
		end
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

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(pescaria[selecionado].x,pescaria[selecionado].y,pescaria[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.3)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar Rocha")
	EndTextCommandSetBlipName(blips)
end