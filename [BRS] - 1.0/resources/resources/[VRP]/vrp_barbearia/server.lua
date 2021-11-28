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
Tunnel.bindInterface("vrp_barbearia",src)
vCLIENT = Tunnel.getInterface("vrp_barbearia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateSkin(custom)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryFullPayment(user_id, 120) then
			vRP.setUData(user_id,"currentCharacterMode",json.encode(custom))
			TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$"..vRP.format(120).." </b> ",5)
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem dinheiro suficiente",5)
			vRP._carregarRosto(user_id)
		end
	end
end 

function src.openBarberShop()
	local source = source
	local user_id = vRP.getUserId(source)
	local getRosto = vRP.getUData(user_id,"currentCharacterMode")
	if getRosto ~= nil then
		local custom = json.decode(getRosto) or {}
		vCLIENT.updateCustom(source, custom)
		return true
	end
end

function src.oldCustom()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP._carregarRosto(user_id)
	end
end