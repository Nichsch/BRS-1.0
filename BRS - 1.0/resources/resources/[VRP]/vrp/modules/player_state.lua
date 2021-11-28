local cfg = module("cfg/player_state")

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)

	if first_spawn then
		local colete = data.colete
		SetTimeout(10000,function()
			if data.colete then
				source = vRP.getUserSource(user_id)
				if(source~=nil)then
					vRPclient.setArmour(source,colete)
				end
			end
		end)

		if data.customization == nil then
			data.customization = cfg.default_customization
		end

		if data.position then
			vRPclient.teleport(source,data.position.x,data.position.y,data.position.z)
		end

		if data.customization then
			vRPclient.setCustomization(source,data.customization) 
			if data.weapons then
				vRPclient.giveWeapons(source,data.weapons,true)

				if data.health then
					vRPclient.setHealth(source,data.health)
					SetTimeout(5000,function()
						if vRPclient.isInComa(source) then
							vRPclient.killComa(source)
						end
					end)
				end
			end
		else
			if data.weapons then
				vRPclient.giveWeapons(source,data.weapons,true)
			end

			if data.health then
				vRPclient.setHealth(source,data.health)
			end
		end
	else
		if data.customization then
			--vRPclient._setSexo(source)
			
			
			vRPclient._setCustomization(source,data.customization)
		end

		vRP.clearInventory(user_id)
		vRPclient._setHandcuffed(source,false)
		vRP.setMoney(user_id, 0)
		vRP.setUData(user_id,"vRP:corona", (json.encode(0)))
		if not vRP.hasPermission(user_id,"perm.inventario") then
			data.gaptitudes = {}
		end


	end
	
	vRP.carregarRosto(user_id)
	vRPclient._playerStateReady(source,true)
end)

function tvRP.updatePos(x,y,z)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local tmp = vRP.getUserTmpTable(user_id)
		if data and (not tmp or not tmp.home_stype) then
			data.position = { x = tonumber(x), y = tonumber(y), z = tonumber(z) }
		end
	end
end

function vRP.insertPoliceRecord(user_id, line)
	if user_id ~= nil then
		local valor = vRP.getUData(user_id,"vRP:ficha:criminal")
		if valor ~= nil then
			local records = valor..line.."<br />"
			vRP.setUData(user_id,"vRP:ficha:criminal",records)
		end
  end
end

function tvRP.updateArmor(armor)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.colete = armor
		end
	end
end

function tvRP.updateWeapons(weapons)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.weapons = weapons
		end
	end
end

function tvRP.updateCustomization(customization)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.customization = customization
		end
	end
end

function tvRP.updateHealth(health)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.health = health
		end
	end
end
 
function vRP.carregarRosto(user_id)
	local source = vRP.getUserSource(user_id)
	if source then
		local data = vRP.getUData(user_id,"vRP:spawnController")
		local sdata = json.decode(data) or 0
		if sdata == 2 then
			local data2 = vRP.getUData(user_id,"currentCharacterMode")
			local custom = json.decode(data2) or 0

			if custom ~= nil then
				vRPclient.updateRosto(source, custom)
			end

		end
	end
end 
-----------------------------------------------------------------------------------------------------------------------------------------
-- MALA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trymala")
AddEventHandler("trymala",function(nveh)
	TriggerClientEvent("syncmala",-1,nveh)
end)