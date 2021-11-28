local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_inventario")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data)
	StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        if IsControlJustPressed(0,246) then
            if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) then
                if not invOpen then
                	StartScreenEffect("MenuMGSelectionIn", 0, true)
                    invOpen = true
                    SetNuiFocus(true,true)
                    SendNUIMessage({ action = "showMenu" })
                else
                	StopScreenEffect("MenuMGSelectionIn")
                    SetNuiFocus(false,false)
                    SendNUIMessage({ action = "hideMenu" })
                    invOpen = false
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEANCHOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vehicleanchor')
AddEventHandler('vehicleanchor',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    FreezeEntityPosition(vehicle,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	vRPNserver.dropItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	vRPNserver.sendItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	vRPNserver.useItem(data.item,data.type,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,peso,maxpeso = vRPNserver.Mochila()
	if inventario then
		cb({ inventario = inventario, peso = peso, maxpeso = maxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NZK:Update")
AddEventHandler("NZK:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPAR ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local dropList = {}

RegisterNetEvent('DropSystem:remove')
AddEventHandler('DropSystem:remove',function(id)
	if dropList[id] ~= nil then
		dropList[id] = nil
	end
end)

RegisterNetEvent('DropSystem:createForAll')
AddEventHandler('DropSystem:createForAll',function(id,marker)
	dropList[id] = marker
end)

local cooldown = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(dropList) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 150 then
				DrawMarker(25,v.x,v.y,cdz+0.01,0,0,0,0,0,0,0.4,0.4,0.5,255,255,255,15,0,0,2,0,0,0,0)
				DrawMarker(21,v.x,v.y,cdz+0.60,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
				if distance <= 1.2 and v.count ~= nil and v.name ~= nil and not IsPedInAnyVehicle(ped) then
					drawTxt("APERTE  ~b~[E]~w~  PARA PEGAR~g~ "..string.upper(v.name).." "..v.count.." x",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(1,38) and not cooldown then
						cooldown = true
						TriggerServerEvent('DropSystem:take8828123',k)
						SetTimeout(3000,function()
							cooldown = false
						end)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENERGETICO
-----------------------------------------------------------------------------------------------------------------------------------------
local energetico = false
RegisterNetEvent("NZK:ENERGETICO")
AddEventHandler("NZK:ENERGETICO",function(status)
	energetico = status
	if energetico then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if energetico then
            RestorePlayerStamina(PlayerId(),1.0)
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