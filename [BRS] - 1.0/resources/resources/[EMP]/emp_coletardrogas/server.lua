local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_coletardrogas",emP)

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then 
		if vRP.hasPermission(user_id,"perm.trafico") then
			return true
		else
			TriggerClientEvent('chatMessage', source, "^2Você não faz parte de uma facção.")
		end
	end
end

function emP.checkPayment(drogas)
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then
		if drogas == 1 then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("seeds") <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id, "seeds", 1)  
				return true
			else
				TriggerClientEvent('chatMessage', source, "^5Mochila Cheia.")
				return false
			end
		elseif drogas == 2 then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("benzoilmetilecgonina") <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id, "benzoilmetilecgonina", 1) 
				return true
			else
				TriggerClientEvent('chatMessage', source, "^5Mochila Cheia.")
				return false
			end
		elseif drogas == 3 then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("anfetamina") <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id, "anfetamina", 1) 
				return true
			else
				TriggerClientEvent('chatMessage', source, "^5Mochila Cheia.")
				return false
			end
		end
	end
end