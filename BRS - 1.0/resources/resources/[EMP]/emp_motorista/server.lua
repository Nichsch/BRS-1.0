local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_motorista",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local bonus = math.random(450,650) -- 90
		local pagamento = math.random(250,450)+bonus
		vRP.giveMoney(user_id,pagamento)
		TriggerClientEvent('chatMessage', source, "^2Você recebeu ^5$ "..pagamento.."^2.")
	end
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"perm.motorista") then
			return true
		else
			TriggerClientEvent('chatMessage', source, "^2Você não é um motorista.")
		end
	end
end