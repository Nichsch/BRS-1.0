local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_inventario_carro",vRPN)
Proxy.addInterface("vrp_inventario_carro",vRPN)

vCLIENT = Tunnel.getInterface("vrp_adv_garages")

local inventory = module("vrp","cfg/inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local uchests = {}
local vchests = {}
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local mPlaca,mName,mNet,mPrice,mBanido,mLock = vRPclient.ModelName(source,7)
		if mPlaca then
			local placa_user_id = vRP.getUserByRegistration(mPlaca)
			if placa_user_id then
				local myinventory = {} 
				local myvehicle = {}
				local mala = "bauCarro:id:"..parseInt(placa_user_id).."veh:"..string.lower(mName)
				local data = vRP.getSData(mala)
				local sdata = json.decode(data) or {} 
				local max_veh = inventory.vehicle_chest_weights[mName] or 50
				if sdata then
					for k,v in pairs(sdata) do
						table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.getItemName(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
					end

					local data2 = vRP.getUserDataTable(user_id)
					if data2 and data2.inventory then
						for k,v in pairs(data2.inventory) do
							table.insert(myvehicle,{ amount = parseInt(v.amount), name = vRP.getItemName(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
						end
					end

					uchests[parseInt(user_id)] = mala
					vchests[parseInt(user_id)] = mName
				end
				return myinventory,myvehicle,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(sdata),parseInt(max_veh)
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.storeItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[user_id] == 0 or not actived[user_id] then
			if string.match(itemName,"dirty_money") then
				TriggerClientEvent('chatMessage', source, "^9Não pode guardar este item em veículos")
				return
			end

			local data = vRP.getSData(uchests[user_id])
			local items = json.decode(data) or {}
			if items then
				local max_veh = inventory.vehicle_chest_weights[vchests[user_id]] or 50
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(max_veh) then
						if vRP.tryGetInventoryItem(user_id,itemName,parseInt(amount)) then
							if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
								actived[parseInt(user_id)] = 4
							if items[itemName] ~= nil then
								items[itemName].amount = items[itemName].amount + parseInt(amount)
							else
								items[itemName] = { amount = parseInt(amount) }
							end
							vRP.log("nzk_logs/player/chestCar.txt", "**GUARDAR** O [ID: "..user_id.."] guardou "..vRP.getItemName(itemName).." "..amount.."x ")
							actived[parseInt(user_id)] = 2
						end
						end
					else
						TriggerClientEvent('chatMessage', source, "^9Porta malas Cheio.")
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(max_veh) then
								if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
									if items[itemName] ~= nil then
										items[itemName].amount = items[itemName].amount + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end
									vRP.log("nzk_logs/player/chestCar.txt", "**GUARDAR** O [ID: "..user_id.."] guardou "..vRP.getItemName(itemName).." "..amount.."x ")
									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent('chatMessage', source, "^9Porta malas Cheio.")
							end
						end
					end
				end
				vRP.setSData(uchests[parseInt(user_id)],json.encode(items))
				TriggerClientEvent('Creative:UpdateTrunk',source,'updateMochila')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.takeItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData(uchests[parseInt(user_id)])
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and items[itemName].amount >= parseInt(amount) then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
							if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
								actived[parseInt(user_id)] = 4
							vRP.giveInventoryItem(user_id,itemName,parseInt(amount))
							items[itemName].amount = items[itemName].amount - parseInt(amount)
							if items[itemName].amount <= 0 then
								items[itemName] = nil
							end
							end
							actived[parseInt(user_id)] = 2
							vRP.log("nzk_logs/player/chestCar.txt", "**RETIROU** O [ID: "..user_id.."] retirou "..vRP.getItemName(itemName).." "..amount.."x ")
							TriggerClientEvent('Creative:UpdateTrunk',source,'updateMochila')
							vRP.setSData(uchests[parseInt(user_id)],json.encode(items))
						else
							TriggerClientEvent('chatMessage', source, "^9Mochila Cheia.")
						end
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid = vRPclient.ModelName(source,7)
		if vehicle then
			vCLIENT.vehicleClientTrunk(-1,vnetid,true)
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.chestOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local mPlaca,mName,mNet,mPrice,mBanido,mLock = vRPclient.ModelName(source,7)
		if not mLock then
			if mPlaca then
				if mName then
					if mBanido then
						TriggerClientEvent('chatMessage', source, "^2Veículos de serviço ou alugados não podem utilizar o Porta-Malas.")
						return
					end
					local placa_user_id = vRP.getUserByRegistration(mPlaca)
					if placa_user_id then
						vCLIENT.vehicleClientTrunk(-1,mNet,false)
						TriggerClientEvent("trunkchest:Open",source)
					end
				end
			end
		end
	end 
end
