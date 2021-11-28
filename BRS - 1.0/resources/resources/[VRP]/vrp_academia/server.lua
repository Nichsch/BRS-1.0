local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
acaD = {}
Tunnel.bindInterface("vrp_academia",acaD)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ACADEMIA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function acaD.treinando()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then
		TriggerClientEvent('chatMessage', source, "^2Você ganhou +15xp de força")
		vRP._varyExp(user_id,"physical","strength",15.0) 
	end
end

function acaD.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryPayment(user_id,2000) then
				TriggerClientEvent('chatMessage', source, "^2Você pagou a academia va treinar!")
				return true
			else
				TriggerClientEvent('chatMessage', source, "^2Você não possui dinheiro")
				return false
		end
	end
end