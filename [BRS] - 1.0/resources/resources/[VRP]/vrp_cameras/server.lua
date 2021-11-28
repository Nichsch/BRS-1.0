local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

caM = {}
Tunnel.bindInterface("vrp_cameras",caM)


function caM.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"perm.policia.civil") then
			return true
		else
			TriggerClientEvent('chatMessage', source, "^2Você não pode acessar as cameras.")
		end
	end
end