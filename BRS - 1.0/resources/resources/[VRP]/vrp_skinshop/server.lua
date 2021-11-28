-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_skinshop",src)
vCLIENT = Tunnel.getInterface("vrp_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.shopBuy(old_custom)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local custom = vRPclient.getCustomization(source)
		local price = 0
		custom.modelhash = nil
		for k,v in pairs(custom) do				
			local old = old_custom[k]

			if v[1] ~= old[1] and k ~= 12 then
				price = price + 80
			end
			if v[2] ~= old[2] and k ~= 12 then
				price = price + 40
			end
		end

		if vRP.tryFullPayment(user_id,price) then
			if price > 0 then
				TriggerClientEvent('chatMessage', source, 'LOJA', {63, 127, 191},"^5Comprou $"..vRP.format(parseInt(price)).." em roupas e acessórios.")
			end
		else
			TriggerClientEvent('chatMessage', source, 'LOJA', {63, 127, 191},"^9Dinheiro insuficiente.")
			vRPclient._setCustomization(source,old_custom)
		end
	end
end