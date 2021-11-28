local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_venderminerios")
vRP = Proxy.getInterface("vRP")

local servico = false
local processo = false
local selecionado = 0
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local locs = {
  [1] = { ['x'] = -624.58, ['y'] = -230.99, ['z'] = 38.05, ['heading'] = 299.51},
  [2] = { ['x'] = -623.89099121094, ['y'] = -228.09997558594, ['z'] = 38.057041168213, ['heading'] = 206.76 },
  [3] = { ['x'] = -621.06909179688, ['y'] = -228.41653442383, ['z'] = 38.057041168213, ['heading'] = 119.74 },
  [4] = { ['x'] = -619.32214355469, ['y'] = -230.49073791504, ['z'] = 38.057041168213, ['heading'] = 121.47 },
  [5] = { ['x'] = -619.96240234375, ['y'] = -233.38554382324, ['z'] = 38.057041168213, ['heading'] = 40.21 },
  [6] = { ['x'] = -620.23175048828, ['y'] = -227.42030334473, ['z'] = 38.057033538818, ['heading'] = 302.86 },
  [7] = { ['x'] = -617.67486572266, ['y'] = -230.79019165039, ['z'] = 38.057022094727, ['heading'] = 313.22 },
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INICIAR COLETA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz,cdz = GetGroundZFor_3dCoord(-630.97,-229.20,38.05)
        local distance = GetDistanceBetweenCoords(-630.97,-229.20,cdz,x,y,z,true)
        if not servico then
            if distance <= 30.0 then
                DrawMarker(25,-630.97,-229.20,38.05-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,50,0,0,0,0)
                if distance <= 2.5 then
                    drawTxt("Pressione ~b~[E]~w~ para iniciar as vendas",4,0.5,0.93,0.50,255,255,255,180)
                    if IsControlJustPressed(0,38) then
                        if emP.checkPermission() then
                                servico = true
                                selecionado = 1
                                TriggerEvent('NZK:bloquearH',true)
                        end
                    end
                end
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COLETAR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if servico then
            local ped = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(ped))
            local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
            local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

            if distance <= 30.0 then
                DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z,0,0,0,0,180.0,130.0,1.0,1.0,0.5,255,255,255,100,1,0,0,1)
                if distance <= 1.5 and not processo then
                    drawTxt("PRESSIONE ~b~[E]~w~ PARA VENDER",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
                            TriggerEvent('NZK:bloquearH',true)
							SetEntityHeading(ped, locs[selecionado].heading)
							SetEntityCoords(PlayerPedId(),locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.95)
							vRP._playAnim(false,{{"mp_common","givetake1_a"}},true)
							processo = true
							TriggerEvent("progress",1000,"vendendo")
							SetTimeout(1000, function()
								emP.checkPayment()
								processo = false
								TriggerEvent('cancelando',false)
								ClearPedTasks(GetPlayerPed(-1))
							end)
							if selecionado == 7 then
								selecionado = 1
							else
								selecionado = selecionado+1
							end
                    end
                end
            end
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
                servico = false
                TriggerEvent('NZK:bloquearH',false)
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSAR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local processo2 = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz,cdz = GetGroundZFor_3dCoord(1109.15,-2007.37,30.95)
        local distance = GetDistanceBetweenCoords(1109.15,-2007.37,cdz,x,y,z,true)
        if distance <= 5 and not processo2 then
            drawTxt("PRESSIONE ~b~[E]~w~ PARA LAPIDAR",4,0.5,0.93,0.50,255,255,255,180)
            if IsControlJustPressed(0,38) and emP.checkPermission() then
				if emP.checkPayment2() then
                        TriggerEvent('NZK:bloquearH',true)
						processo2 = true
						TriggerEvent("progress",2000,"processando")
						SetTimeout(2000,function() processo2 = false TriggerEvent('NZK:bloquearH',false) end)
                end
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