local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vrp_legacyfuel:pagamento43414")
AddEventHandler("vrp_legacyfuel:pagamento43414",function(price,galao)
	local user_id = vRP.getUserId(source)
	if user_id and price > 0 then
		if vRP.tryPayment(user_id,price) then
			if galao then
				TriggerClientEvent('vrp_legacyfuel:galao43414',source) 
				TriggerClientEvent('chatMessage', source, "^5Pagou $"..vRP.format(price).." dólares pelo Galão.")
			else
				TriggerClientEvent('chatMessage', source, "^5Pagou $"..vRP.format(price).." dólares em combustível.")
			end
		else
			TriggerClientEvent('vrp_legacyfuel:insuficiente43414',source)
			TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
		end
	end
end)