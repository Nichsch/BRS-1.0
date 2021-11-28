local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_minerador",emP) 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MINERADOR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("rocha") <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id, "rocha", math.random(1,3)) 
			TriggerClientEvent('NZK:mineradorNewRoute', source)
		else
			TriggerClientEvent('chatMessage', source, "^5Inventario Cheio.")
		end
	end
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then
		if not vRP.hasPermission(user_id,"perm.tequilala") and not vRP.hasPermission(user_id,"perm.yakuza") and not vRP.hasPermission(user_id,"perm.bratva") and not vRP.hasPermission(user_id,"perm.ballas") and not vRP.hasPermission(user_id,"perm.vagos") and vRP.hasPermission(user_id,"perm.minerador") then
			return true
		else
			TriggerClientEvent('chatMessage', source, "^2Você não é um minerador.")
		end
	end
end