local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_svidas",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
			TriggerClientEvent('cancelando',source,true)
			TriggerClientEvent("progress",source,8000,"Salvando")

			SetTimeout(8000, function()
				local valor = 120+math.random(500,600)
				vRP.giveMoney(user_id,valor)
				TriggerClientEvent('chatMessage', source, "^2Você recebeu ^5$"..valor.." ^2por salvar uma vida.")
				TriggerClientEvent('cancelando',source,false)
				vRPclient._stopAnim(source, false)
			end)
			return true
	end
end 

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then 
		if vRP.hasPermission(user_id,"perm.svidas") then
			return true
		else
			TriggerClientEvent('chatMessage', source, "^2Você não é um Salva Vidas.")
		end
	end
end