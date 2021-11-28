local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_pescador",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local peixes = {
	[1] = { x = "dourado" },
	[2] = { x = "corvina" },
	[3] = { x = "salmao" },
	[4] = { x = "pacu" },
	[5] = { x = "pintado" },
	[6] = { x = "pirarucu" },
	[7] = { x = "tilapia" },
	[8] = { x = "tucunare" }
}

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dourado") <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id,"isca",1) then
				if math.random(100) >= 98 then
					vRP.giveInventoryItem(user_id,"lambari",1)
					return true
				else
					vRP.giveInventoryItem(user_id,peixes[math.random(8)].x,1)
					return true
				end
			else
				TriggerClientEvent('chatMessage', source, "^9Fica dificil pescar um peixe sem isca né meu camarada?.")
				return false
			end
		end
	end
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"perm.pescador") then
			return true
		else
			TriggerClientEvent('chatMessage', source, "^2Você não é um pescador.")
		end
	end
end