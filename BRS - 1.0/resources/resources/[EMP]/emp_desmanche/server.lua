local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_desmanche",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if user_id ~= nil then 
		if vRP.hasPermission(user_id,"perm.driftking") or vRP.hasPermission(user_id, "perm.motoclube") then
			return true
		else
			TriggerClientEvent('chatMessage', source, "^2Você não faz parte de uma facção.")
		end
	end
end

function emP.checkVehicle()
	local source = source
	local user_id = vRP.getUserId(source)
	local mPlaca,mName,mPrice,mBanido = vRPclient.ModelName2(source)
	local placa_user = vRP.getUserByRegistration(mPlaca)
	if placa_user then
		local rows = vRP.query("vRP/get_detido",{ user_id = placa_user, vehicle = mName })
		if #rows <= 0 then
			TriggerClientEvent('chatMessage', source, "^2Veículo não encontrado na lista do proprietário.")
			return
		end 
		if mName then
			if parseInt(rows[1].detido) == 1 or parseInt(rows[1].detido) == 2 then
				TriggerClientEvent('chatMessage', source, "^2Veículo encontra-se apreendido na seguradora.")
				return
			end
			if mBanido then
				TriggerClientEvent('chatMessage', source, "^2Veículos de serviço ou alugados não podem ser desmanchados.")
				return
			end
		end
		return true
	end
end

function emP.removeVehicles(mPlaca,mName,mPrice,mNet)
    local source = source
    local user_id = vRP.getUserId(source)
    local placa_user = vRP.getUserByRegistration(mPlaca)
    if placa_user then
        local dinheiroPago = parseInt(mPrice)*0.13
        vRP.execute("vRP/set_detido",{ user_id = placa_user, vehicle = mName, detido = 1 })
        vRP.giveInventoryItem(user_id,"dirty_money",dinheiroPago)
        TriggerClientEvent('syncdeleteveh',-1,mNet)
        TriggerClientEvent('chatMessage', source, "^2Você enviou um veiculo para o desmanche e recebeu ^5".. dinheiroPago .."^2 dinheiro sujo.")
        vRP.log("nzk_logs/player/desmanche.txt", "O [ID: "..user_id.."] desmanchou o veiculo no modelo "..mName.." pelo valor ".. dinheiroPago .." do [ID: "..placa_user.."] ")
    end
end