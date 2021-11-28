-- DEFAULT --
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP")
vRPhud = {}
Tunnel.bindInterface("vrp_hud",vRPhud)

local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent('hud:Server') 
AddEventHandler('hud:Server',function() 
		local source = source
		local user_id = vRP.getUserId(source) or "0"
    local fome = vRP.getHunger(user_id) or "0" 
		local sede = vRP.getThirst(user_id) or "0"
		TriggerClientEvent('hud:Client', source, fome, sede) 
end) 


function vRPhud.checkPermission()
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "ajudante.permissao") then
			vRP.abrirPoliciaMenu(source)
			return true
		end
	end
end


function vRPhud.checkNitro()
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id, "nitro", 1) then
			return true
		else
			TriggerClientEvent('chatMessage', source, "^9Você não possui um nitro.")
		end
	end
end