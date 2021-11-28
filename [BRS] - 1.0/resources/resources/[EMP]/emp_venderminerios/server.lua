local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_venderminerios",emP)

local item = {
	[1] = { ['item'] = "bronze", ['itemqtd'] = 2, ['price'] = math.random(300,375) },
	[2] = { ['item'] = "ferro", ['itemqtd'] = 2, ['price'] = math.random(375,450) },
	[3] = { ['item'] = "ouro", ['itemqtd'] = 2, ['price'] = math.random(475,575) },
	[4] = { ['item'] = "diamantelap", ['itemqtd'] = 2, ['price'] = math.random(575,800) },
}

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

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then
		for k,v in pairs(item) do
			if vRP.getInventoryItemAmount(user_id, v.item) >= 2 then
				vRP.tryGetInventoryItem(user_id, v.item, 2)
				vRP.giveMoney(user_id, v.price)
				TriggerClientEvent('chatMessage', source, "^2Você vendeu "..v.itemqtd.."x ^5"..vRP.getItemName(v.item).."^2 por ^5$"..v.price.." dólares.")
				return true
			end
		end
	end
end

function emP.checkPayment2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id, "rocha", 1) then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("bronze") <= vRP.getInventoryMaxWeight(user_id) and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("ferro") <= vRP.getInventoryMaxWeight(user_id) and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("ouro") <= vRP.getInventoryMaxWeight(user_id) and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("diamantelap") <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id, "bronze", math.random(1,3)) vRP.giveInventoryItem(user_id, "ferro", math.random(1,3)) vRP.giveInventoryItem(user_id, "ouro", math.random(1,3)) vRP.giveInventoryItem(user_id, "diamantelap", 1)
				return true
			else
				TriggerClientEvent('chatMessage', source, "^9Mochila Cheia.")
			end
		else
			TriggerClientEvent('chatMessage', source, "^2Você não possui rocha.")
		end
	end
end