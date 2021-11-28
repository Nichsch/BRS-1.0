local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_coletardrogas")
vRP = Proxy.getInterface("vRP")

local blips = false
local servico = false
local selecionado = 0
local drogasColetando = false
local maconhaColetando = false
local cocainaColetando = false
local mdColetando = false
-- TIPOS
-- 1 MACONHA
-- 2 COCAINA
-- 3 MD
local locs = {
  [1] = { ['x'] = 2217.38, ['y'] = 5579.60, ['z'] = 53.96, ['name'] = "MACONHA", ['tipo'] = 1},
  [2] = { ['x'] = 2220.71, ['y'] = 5579.43, ['z'] = 53.95, ['name'] = "MACONHA", ['tipo'] = 1},
  [3] = { ['x'] = 2227.96, ['y'] = 5578.77, ['z'] = 53.91, ['name'] = "MACONHA", ['tipo'] = 1},
  [4] = { ['x'] = 2227.96, ['y'] = 5578.77, ['z'] = 53.91, ['name'] = "MACONHA", ['tipo'] = 1},
  [5] = { ['x'] = 2215.25, ['y'] = 5577.52, ['z'] = 53.99, ['name'] = "MACONHA", ['tipo'] = 1},
  [6] = { ['x'] = 2217.86, ['y'] = 5577.55, ['z'] = 53.82, ['name'] = "MACONHA", ['tipo'] = 1},
  [7] = { ['x'] = 2224.64, ['y'] = 5574.71, ['z'] = 53.76, ['name'] = "MACONHA", ['tipo'] = 1},
  [8] = { ['x'] = 2227.96, ['y'] = 5578.77, ['z'] = 53.91, ['name'] = "MACONHA", ['tipo'] = 1},
  [9] = { ['x'] = 2226.65, ['y'] = 5576.87, ['z'] = 53.83, ['name'] = "MACONHA", ['tipo'] = 1},
  [10] = { ['x'] = 2227.67, ['y'] = 5578.84, ['z'] = 53.91, ['name'] = "MACONHA", ['tipo'] = 1},
  [11] = { ['x'] = 2231.10, ['y'] = 5576.59, ['z'] = 53.98, ['name'] = "MACONHA", ['tipo'] = 1},
  [12] = { ['x'] = 2233.10, ['y'] = 5574.20, ['z'] = 53.98, ['name'] = "MACONHA", ['tipo'] = 1},
  [13] = { ['x'] = 2236.09, ['y'] = 5574.14, ['z'] = 53.92, ['name'] = "MACONHA", ['tipo'] = 1},
  [14] = { ['x'] = 2235.81, ['y'] = 5578.58, ['z'] = 54.10, ['name'] = "MACONHA", ['tipo'] = 1},
  [15] = { ['x'] = 2237.86, ['y'] = 5573.95, ['z'] = 53.87, ['name'] = "MACONHA", ['tipo'] = 1},
  [16] = { ['x'] = 2222.39, ['y'] = 5579.27, ['z'] = 53.92, ['name'] = "MACONHA", ['tipo'] = 1},
  [17] = { ['x'] = 2228.00, ['y'] = 5578.22, ['z'] = 53.09, ['name'] = "MACONHA", ['tipo'] = 1},
  [18] = { ['x'] = 2229.73, ['y'] = 5574.08, ['z'] = 53.83, ['name'] = "MACONHA", ['tipo'] = 1},
  [19] = { ['x'] = 499.21, ['y'] = 6466.14, ['z'] = 30.83, ['name'] = "COCAINA", ['tipo'] = 2 },
  [20] = { ['x'] = 499.24, ['y'] = 6468.82, ['z'] = 30.86, ['name'] = "COCAINA", ['tipo'] = 2 },
  [21] = { ['x'] = 499.33, ['y'] = 6473.36, ['z'] = 30.79, ['name'] = "COCAINA", ['tipo'] = 2 },
  [22] = { ['x'] = 499.3, ['y'] = 6475.81, ['z'] = 30.8, ['name'] = "COCAINA", ['tipo'] = 2 },
  [23] = { ['x'] = 499.42, ['y'] = 6479.59, ['z'] = 30.82, ['name'] = "COCAINA", ['tipo'] = 2 },
  [24] = { ['x'] = 501.24, ['y'] = 6479.76, ['z'] = 30.84, ['name'] = "COCAINA", ['tipo'] = 2 },
  [25] = { ['x'] = 501.06, ['y'] = 6476.98, ['z'] = 30.82, ['name'] = "COCAINA", ['tipo'] = 2 },
  [26] = { ['x'] = 501.05, ['y'] = 6472.44, ['z'] = 30.81, ['name'] = "COCAINA", ['tipo'] = 2 },
  [27] = { ['x'] = 501.05, ['y'] = 6468.3, ['z'] = 30.86, ['name'] = "COCAINA", ['tipo'] = 2 }, 
  [28] = { ['x'] = 501.22, ['y'] = 6464.52, ['z'] = 30.87, ['name'] = "COCAINA", ['tipo'] = 2 },
  [29] = { ['x'] = 503.5, ['y'] = 6465.1, ['z'] = 30.86, ['name'] = "COCAINA", ['tipo'] = 2 },
  [30] = { ['x'] = 503.3, ['y'] = 6468.87, ['z'] = 30.82, ['name'] = "COCAINA", ['tipo'] = 2 },
  [31] = { ['x'] = 503.32, ['y'] = 6472.71, ['z'] = 30.82, ['name'] = "COCAINA", ['tipo'] = 2 },
  [32] = { ['x'] = 503.35, ['y'] = 6479.5, ['z'] = 30.85, ['name'] = "COCAINA", ['tipo'] = 2 },
  [33] = { ['x'] = 503.26, ['y'] = 6482.44, ['z'] = 30.89, ['name'] = "COCAINA", ['tipo'] = 2 },
  [34] = { ['x'] = 2432.77, ['y'] = 4970.39, ['z'] = 42.35, ['name'] = "MD", ['tipo'] = 3 },
  [35] = { ['x'] = 2432.72, ['y'] = 4972.12, ['z'] = 42.35, ['name'] = "MD", ['tipo'] = 3 },
  [36] = { ['x'] = 2430.81, ['y'] = 4970.3, ['z'] = 42.35, ['name'] = "MD", ['tipo'] = 3 }, 
  [37] = { ['x'] = 2433.95, ['y'] = 4969.27, ['z'] = 42.35, ['name'] = "MD", ['tipo'] = 3 },
  [38] = { ['x'] = 2431.91, ['y'] = 4967.68, ['z'] = 42.35, ['name'] = "MD", ['tipo'] = 3 },
  [39] = { ['x'] = 2436.09, ['y'] = 4965.54, ['z'] = 42.35, ['name'] = "MD", ['tipo'] = 3 },
  [40] = { ['x'] = 2434.52, ['y'] = 4964.04, ['z'] = 42.35, ['name'] = "MD", ['tipo'] = 3 },
}

local locsDrogas = {
  { ['x'] = 2206.53, ['y'] = 5578.20, ['z'] = 53.80, ['tipo'] = 1, ['name'] = "PRESSIONE  ~p~[E]~w~ PARA INICIAR A COLETA DE MACONHA" }, 
  { ['x'] = 501.28378295898, ['y'] = 6460.359375, ['z'] = 30.879884719849, ['tipo'] = 2, ['name'] = "PRESSIONE  ~p~[E]~w~ PARA INICIAR A COLETA DE COCAINA" },
  { ['x'] = 2430.142578125, ['y'] = 4966.9311523438, ['z'] = 42.347587585449, ['tipo'] = 3, ['name'] = "PRESSIONE ~p~[E]~w~ PARA INICIAR A COLETA DE MD" },
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INICIAR COLETA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
      local ped = PlayerPedId()
    for k,v in pairs(locsDrogas) do
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
        local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
        if not servico then
        if distance <= 30.0 then
          DrawMarker(25,v.x,v.y,v.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,50,0,0,0,0)
          if distance <= 2.5 then
            drawTxt(v.name,4,0.5,0.93,0.50,255,255,255,180)
            if IsControlJustPressed(0,38) then
              if emP.checkPermission() then
                if v.tipo == 1 then
                  servico = true
                  selecionado = 1
                  CriandoBlip(locs,selecionado)
                elseif v.tipo == 2 then               
                  servico = true
                  selecionado = 19
                  CriandoBlip(locs,selecionado)
                elseif v.tipo == 3 then               
                  servico = true
                  selecionado = 34
                  CriandoBlip(locs,selecionado)
                end
              end
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
				if distance <= 1.5 then
					drawTxt("PRESSIONE ~p~[E]~w~ PARA COLETAR A "..locs[selecionado].name,4,0.5,0.93,0.50,255,255,255,180)
          if not drogasColetando then
            if IsControlJustPressed(0,38) then
            local tipo = locs[selecionado].tipo

              if tipo == 1 then
                if selecionado == 18 then
                  vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@base","base_female"}},true)
                  maconhaColetando = true
                  drogasColetando = true
                  selecionado = 1
                else
                  vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@base","base_female"}},true)
                  maconhaColetando = true
                  drogasColetando = true
                end
              elseif tipo == 2 then
                if selecionado == 33 then
                  vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@base","base_female"}},true)
                  cocainaColetando = true
                  drogasColetando = true
                  selecionado = 19
                else
                  vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@base","base_female"}},true)
                  cocainaColetando = true
                  drogasColetando = true
                end
              elseif tipo == 3 then
                if selecionado == 40 then
                  vRP._playAnim(false,{{"mini@repair","fixing_a_player"}},true)
                  mdColetando = true
                  drogasColetando = true
                  selecionado = 34
                else
                  vRP._playAnim(false,{{"mini@repair","fixing_a_player"}},true)
                  mdColetando = true
                  drogasColetando = true
                end
            end
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
			if IsControlJustPressed(0,167) then
				servico = false
				RemoveBlip(blips)
			end
		end
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
    Citizen.Wait(1)
    if drogasColetando then
      TriggerEvent('cancelando',true)
      if maconhaColetando then
        Citizen.Wait(6*1000)
        TriggerEvent('cancelando',false)
        if emP.checkPayment(1) then
          RemoveBlip(blips)
          ClearPedTasks(GetPlayerPed(-1))
          maconhaColetando = false
          drogasColetando = false
          selecionado = selecionado+1
          CriandoBlip(locs,selecionado)  
        else
          ClearPedTasks(GetPlayerPed(-1))
          maconhaColetando = false
          drogasColetando = false
        end
      elseif cocainaColetando then
        Citizen.Wait(6*1000)
        TriggerEvent('cancelando',false)
        if emP.checkPayment(2) then
          RemoveBlip(blips)
          ClearPedTasks(GetPlayerPed(-1))
          cocainaColetando = false
          drogasColetando = false
          selecionado = selecionado+1
          CriandoBlip(locs,selecionado) 
        else
          ClearPedTasks(GetPlayerPed(-1))
          cocainaColetando = false
          drogasColetando = false
        end
      elseif mdColetando then
        Citizen.Wait(6*1000)
        TriggerEvent('cancelando',false)
        if emP.checkPayment(3) then
          RemoveBlip(blips)
          ClearPedTasks(GetPlayerPed(-1))
          mdColetando = false
          drogasColetando = false
          selecionado = selecionado+1
          CriandoBlip(locs,selecionado) 
        else
          ClearPedTasks(GetPlayerPed(-1))
          mdColetando = false
          drogasColetando = false
        end
    else
      drogasColetando = false
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
	AddTextComponentString("COLETAR ("..locs[selecionado].name..")")
	EndTextCommandSetBlipName(blips)
end