local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_entregador",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
			vRPclient._playAnim(source,false,{{"mp_common","givetake1_a"}},true)
			TriggerClientEvent('cancelando',source,true)
			TriggerClientEvent("progress",source,8000,"entregando")
			SetTimeout(8000, function()
				local gorgeta = math.random(60,90)
				vRP.giveMoney(user_id,800+gorgeta)
				TriggerClientEvent('chatMessage', source, "^2Você recebeu de entrega ^5$ 800 e ^5 $"..gorgeta.."^2 de gorgeta.^2.")
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
		if vRP.hasPermission(user_id,"perm.entregador") then
			return true
		else
			TriggerClientEvent('chatMessage', source, "^2Você não é um entregador.")
		end
	end
end