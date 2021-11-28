local weapon_list = {}				  
local state_ready = false
local scubaGearOn = false

AddEventHandler("playerSpawned",function()
  state_ready = false
  removeAttachedProp()
  removeAttachedProp2()
  scubaGearOn = false
  Citizen.CreateThread(function() Citizen.Wait(10000) state_ready = true end)
end)


function tvRP.playerStateReady(state)
	state_ready = state
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if IsPlayerPlaying(PlayerId()) and state_ready then
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
			vRPserver._updatePos(x,y,z)
			vRPserver._updateHealth(tvRP.getHealth())
			vRPserver._updateWeapons(tvRP.getWeapons())
			vRPserver._updateCustomization(tvRP.getCustomization())
			vRPserver._updateArmor(tvRP.getArmour())
		end
	end
end)

local weapon_types = {
	"WEAPON_KNIFE",
	"WEAPON_KNUCKLE",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_PROXMINE",
	"WEAPON_BZGAS",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_SNOWBALL",
	"WEAPON_FLARE",
	"WEAPON_BATTLEAXE",
	"WEAPON_STONE_HATCHET",
	"GADGET_PARACHUTE",
	"WEAPON_BALL",
	"WEAPON_REVOLVER",
	"WEAPON_POOLCUE",
	"WEAPON_PIPEWRENCH",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_FIREWORK",
	"WEAPON_STICKYBOMB",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_RAYPISTOL",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RAILGUN",
	"WEAPON_RAYCARBINE",
	"WEAPON_GRENADE",
	"WEAPON_PIPEBOMB",
	"WEAPON_RPG",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_MINIGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_CERAMICPISTOL",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_AUTOSHOTGUN",
	--[[BLACKLIST]]
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_STUNGUN",
	"WEAPON_PISTOL50",
	"WEAPON_NIGHTSTICK",
	"WEAPON_FLASHLIGHT",
}

function tvRP.getWeapons()
	local player = PlayerPedId()
	local ammo_types = {}
	local weapons = {}
	for k,v in pairs(weapon_types) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(player,hash) then
			local weapon = {}
			weapons[v] = weapon
			local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74,player,hash)
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapon.ammo = GetAmmoInPedWeapon(player,hash)
			else
				weapon.ammo = 0
			end
		end
	end
	weapons = tvRP.legalWeaponsChecker(weapons)

	return weapons
end

function tvRP.replaceWeapons(weapons)
	local old_weapons = tvRP.getWeapons()
	tvRP.giveWeapons(weapons,true)
	return old_weapons
end

function tvRP.giveWeapons(weapons,clear_before)
	local player = PlayerPedId()
	if clear_before then
		RemoveAllPedWeapons(player,true)
		weapon_list = {}
	end

	for k,weapon in pairs(weapons) do
		local hash = GetHashKey(k)
		local ammo = weapon.ammo or 0
		GiveWeaponToPed(player,hash,ammo,false)
		weapon_list[k] = weapon
	end
end

function tvRP.getWeaponsLegal()
	return weapon_list
end

function tvRP.legalWeaponsChecker(weapon)
	local source = source
	local weapon = weapon
	local weapons_legal = tvRP.getWeaponsLegal()
	local ilegal = false
	for v, b in pairs(weapon) do
	  if not weapon_list[v] then
		ilegal = true 
	  end
	end
	if ilegal then
	  tvRP.giveWeapons(weapons_legal, true)
		weapon = {}
		TriggerServerEvent("AC:ac_Armas:ACC49129120", source)
	end
	return weapon
end

function tvRP.setArmour(amount)
	--SetPedArmour(PlayerPedId(),amount)
	TriggerEvent("EatFood",amount)
end

function tvRP.getArmour()
	return GetPedArmour(PlayerPedId())
end

local function parse_part(key)
	if type(key) == "string" and string.sub(key,1,1) == "p" then
		return true,tonumber(string.sub(key,2))
	else
		return false,tonumber(key)
	end
end

function tvRP.getDrawables(part)
	local isprop, index = parse_part(part)
	if isprop then
		return GetNumberOfPedPropDrawableVariations(PlayerPedId(),index)
	else
		return GetNumberOfPedDrawableVariations(PlayerPedId(),index)
	end
end

function tvRP.getDrawableTextures(part,drawable)
	local isprop, index = parse_part(part)
	if isprop then
		return GetNumberOfPedPropTextureVariations(PlayerPedId(),index,drawable)
	else
		return GetNumberOfPedTextureVariations(PlayerPedId(),index,drawable)
	end
end

function tvRP.getCustomPlayer()
    local ped = PlayerPedId()
    local custom = { GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1),GetPedDrawableVariation(ped,5),GetPedTextureVariation(ped,5),GetPedDrawableVariation(ped,7),GetPedTextureVariation(ped,7),GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3),GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4),GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8),GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6),GetPedDrawableVariation(ped,11),GetPedTextureVariation(ped,11),GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9),GetPedDrawableVariation(ped,10),GetPedTextureVariation(ped,10),GetPedPropIndex(ped,0),GetPedPropTextureIndex(ped,0),GetPedPropIndex(ped,1),GetPedPropTextureIndex(ped,1),GetPedPropIndex(ped,2),GetPedPropTextureIndex(ped,2),GetPedPropIndex(ped,6),GetPedPropTextureIndex(ped,6),GetPedPropIndex(ped,7),GetPedPropTextureIndex(ped,7) }
    return custom
end

function tvRP.getMaskPlayer(mascara)
	local ped = PlayerPedId()
	if GetPedDrawableVariation(ped, 1) == mascara then
		return true
	end
end

function tvRP.getCustomization()
	local ped = PlayerPedId()
	local custom = {}
	custom.modelhash = GetEntityModel(ped)

	for i = 0,20 do
		custom[i] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
	end

	for i = 0,10 do
		custom["p"..i] = { GetPedPropIndex(ped,i),math.max(GetPedPropTextureIndex(ped,i),0) }
	end
	return custom
end

function  tvRP.setSexo()
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	for k,v in pairs(data.customization) do
	  if k == "modelhash" then
		local i = 0
		while not HasModelLoaded(v) and i < 10000 do
			RequestModel(v)
			Citizen.Wait(10)
		end

		if HasModelLoaded(mhash) then
			SetPlayerModel(PlayerId(),v)
			SetModelAsNoLongerNeeded(v)
		end
	  end
	end 
end

function tvRP.setCustomization(custom)
	local r = async()
	Citizen.CreateThread(function()
		if custom then
			local ped = PlayerPedId()
			local mhash = nil

			if custom.modelhash then
				mhash = custom.modelhash
			elseif custom.model then
				mhash = GetHashKey(custom.model)
			end

			if mhash then
				local i = 0
				while not HasModelLoaded(mhash) and i < 10000 do
					RequestModel(mhash)
					Citizen.Wait(10)
				end

				if HasModelLoaded(mhash) then
					local weapons = tvRP.getWeapons()
					local armour = GetPedArmour(ped)
					local health = tvRP.getHealth()
					SetPlayerModel(PlayerId(),mhash)
					tvRP.setHealth(health)
					tvRP.giveWeapons(weapons,true)
					tvRP.setArmour(armour)
					SetModelAsNoLongerNeeded(mhash)
				end
			end

			ped = PlayerPedId()
			SetPedMaxHealth(ped,300)

			for k,v in pairs(custom) do
				if k ~= "model" and k ~= "modelhash" then
					local isprop, index = parse_part(k)
					if isprop then
						if v[1] < 0 then
							ClearPedProp(ped,index)
						else
							SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
						end
					else
						SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
					end
					TriggerEvent("reloadtattos")
				end
			end
		end
		r()
	end)
	return r:wait()
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SCUBA GEAR
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local attachedProp = 0
local attachedProp2 = 0
local latestScubaModel = 0

function removeAttachedProp()
	DeleteEntity(attachedProp)
	attachedProp = 0
end
function removeAttachedProp2()
	DeleteEntity(attachedProp2)
	attachedProp2 = 0
end

function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp()
	local attachModel = GetHashKey(attachModelSent)
	local boneNumber = boneNumberSent
	local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumberSent)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	SetEntityCollision(attachedProp, false, 0)
	AttachEntityToEntity(attachedProp, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

function attachProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp2()
	local attachModel = GetHashKey(attachModelSent)
	local boneNumber = boneNumberSent
	local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumberSent)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	SetEntityCollision(attachedProp2, false, 0)
	AttachEntityToEntity(attachedProp2, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end

RegisterNetEvent("nzk:scubaGearClear")
AddEventHandler("nzk:scubaGearClear", function()
	removeAttachedProp()
	removeAttachedProp2()
	latestScubaModel = 0
	scubaGearOn = false
end)

RegisterNetEvent("nzk:scubaGear")
AddEventHandler("nzk:scubaGear", function()
	if latestScubaModel ~= GetEntityModel(GetPlayerPed(-1)) then
	    latestScubaModel = GetEntityModel(GetPlayerPed(-1))
		removeAttachedProp()
		removeAttachedProp2()
		scubaGearOn = false
	end

    scubaGearOn = not scubaGearOn
	if scubaGearOn then
	  attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
	  attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
	  latestScubaModel = GetEntityModel(GetPlayerPed(-1))
	else
	  removeAttachedProp()
	  removeAttachedProp2()
	end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if IsPlayerPlaying(PlayerId()) and state_ready then
  		if scubaGearOn then
  			SetEnableScuba(GetPlayerPed(-1), true)
  			SetPedMaxTimeUnderwater(GetPlayerPed(-1), 100000.00)
  			SetPedDiesInWater(GetPlayerPed(-1), false)
  		else
  			SetEnableScuba(GetPlayerPed(-1), false)
  			SetPedMaxTimeUnderwater(GetPlayerPed(-1), 10.00)
  			SetPedDiesInWater(GetPlayerPed(-1), true)
  		end
    end
  end
end)
---------------------
-- HS
---------------------
Citizen.CreateThread(function()
    while true do
        Wait(5)

        SetPedSuffersCriticalHits(PlayerPedId(), true)
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function tvRP.toggleSpec(idSent)
	local id = idSent
	local sonid = GetPlayerFromServerId(id)
	local targetPed = GetPlayerPed(sonid)

  NetworkSetInSpectatorMode(1, targetPed)

  local x,y,z = table.unpack(GetEntityCoords(targetPed, true))

  RequestCollisionAtCoord(x, y, z)
  while not HasCollisionLoadedAroundEntity(targetPed) do
    RequestCollisionAtCoord(x, y, z)
    Citizen.Wait(10)
  end
end

function tvRP.stopSpec()
	NetworkSetInSpectatorMode(0, GetPlayerPed(-1))
end
