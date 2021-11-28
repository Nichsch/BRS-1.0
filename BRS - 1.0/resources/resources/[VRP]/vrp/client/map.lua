local Tools = module("vrp","lib/Tools")

function tvRP.addBlip(x,y,z,idtype,idcolor,text,scale)
	local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001)
	SetBlipSprite(blip,idtype)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,idcolor)
	SetBlipScale(blip,scale)

	if text ~= nil then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

local named_blips = {}

function tvRP.setNamedBlip(name,x,y,z,idtype,idcolor,text)
  tvRP.removeNamedBlip(name)

  named_blips[name] = tvRP.addBlip(x,y,z,idtype,idcolor,text, 0.4)
  return named_blips[name]
end

function tvRP.removeNamedBlip(name)
  if named_blips[name] ~= nil then
    tvRP.removeBlip(named_blips[name])
    named_blips[name] = nil
  end
end

function tvRP.setBlipRoute(id)
  SetBlipRoute(id,true)
end

function tvRP.removeBlip(id)
	RemoveBlip(id)
end

function tvRP.setGPS(x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PROCURADO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local standby = 0
function tvRP.setStandBY(timer)
	standby = standby + timer
end

function tvRP.getStandBY()
	if standby <= 0 then
		return true
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if standby > 0 then
			standby = standby - 1
		end
	end
end)

RegisterCommand("procurado",function(source,args)
	if standby > 0 then
		TriggerEvent('chatMessage',"^2Aguarde ^5"..standby.." segundos^2 até que tudo se acalme.")
	else
		TriggerEvent('chatMessage',"^2Você não está sendo procurado.")
	end
end)

local markers = {}
local marker_ids = Tools.newIDGenerator()
local named_markers = {}

function tvRP.addMarker(m,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
	local marker = { m = m, x = x, y = y, z = z, sx = sx, sy = sy, sz = sz, r = r, g = g, b = b, a = a, visible_distance = visible_distance }

	if marker.sx == nil then marker.sx = 2.0 end
	if marker.sy == nil then marker.sy = 2.0 end
	if marker.sz == nil then marker.sz = 0.7 end

	if marker.r == nil then marker.r = 0 end
	if marker.g == nil then marker.g = 155 end
	if marker.b == nil then marker.b = 255 end
	if marker.a == nil then marker.a = 200 end

	marker.x = marker.x+0.001
	marker.y = marker.y+0.001
	marker.z = marker.z+0.001
	marker.sx = marker.sx+0.001
	marker.sy = marker.sy+0.001
	marker.sz = marker.sz+0.001

	if marker.visible_distance == nil then marker.visible_distance = 150 end

	local id = marker_ids:gen()
	markers[id] = marker

	return id
end

function tvRP.removeMarker(id)
	if markers[id] then
		markers[id] = nil
		marker_ids:free(id)
	end
end

function tvRP.setNamedMarker(name,m,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
	tvRP.removeNamedMarker(name)
	named_markers[name] = tvRP.addMarker(m,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
	return named_markers[name]
end

function tvRP.removeNamedMarker(name)
	if named_markers[name] then
		tvRP.removeMarker(named_markers[name])
		named_markers[name] = nil
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(markers) do
			local px,py,pz = tvRP.getPosition()
			if GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= v.visible_distance then
				DrawMarker(v.m,v.x,v.y,v.z,0,0,0,0,0,0,v.sx,v.sy,v.sz,v.r,v.g,v.b,v.a,0,0,0,1)
			end
		end
	end
end)

local areas = {}
function tvRP.setArea(name,x,y,z,radius,height)
	local area = { x = x+0.001, y = y+0.001, z = z+0.001, radius = radius, height = height }
	if area.height == nil then area.height = 6 end
	areas[name] = area
end

function tvRP.removeArea(name)
	if areas[name] then
		areas[name] = nil
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if tvRP.getStandBY() then
			local px,py,pz = tvRP.getPosition()
			for k,v in pairs(areas) do
				local player_in = (GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= v.radius and math.abs(pz-v.z) <= v.height)

				if v.player_in and not player_in then
					vRPserver._leaveArea(k)
					v.player_in = false
				end

				if IsControlJustPressed(0,38) then
					if not v.player_in and player_in then
						tvRP.closeMenu()
						Citizen.Wait(100)
						vRPserver._enterArea(k)
						v.player_in = player_in
					end
				end

				if IsControlJustPressed(0,194) or IsControlJustPressed(0,25) or IsControlJustPressed(0,200) then
					if v.player_in and player_in then
						vRPserver._leaveArea(k)
						v.player_in = false
					end
				end
			end
		end
	end
end) 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SAFE ZONE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local zones = {
	{ ['x'] = 321.42, ['y'] = -594.46, ['z'] = 43.29, ['distance'] = 40.0}, --Hospital

}

local dentroSafe = false
local foraSafe = false
local closestZone = 1

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		if dist <= zones[closestZone].distance then 
			if not dentroSafe then
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				dentroSafe = true
				foraSafe = false
			end
		else
			if not foraSafe then
				NetworkSetFriendlyFireOption(true)
				foraSafe = true
				dentroSafe = false
			end
		end
		if dentroSafe then
			DisableControlAction(2, 37, true)
			DisablePlayerFiring(player,true)
			SetPlayerCanDoDriveBy(player,false) 
			
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)

			if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				TriggerEvent('chatMessage',"^2Você não pode fazer isso em uma ^9SAFE-ZONE")
			end
		end
	end
end)

function tvRP.isInSafeZone()
	return dentroSafe
end

function tvRP.checkHospital()
	local ped = PlayerPedId()
	local distance = GetDistanceBetweenCoords(326.36,-593.54,43.28,GetEntityCoords(ped),true)
	if distance <= 50.0 then    
		return true
	end
end