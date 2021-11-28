local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
lojaCoins = {}
Tunnel.bindInterface("vrp_vip",lojaCoins)

vRP.prepare("vRP/get_coins","SELECT coins FROM vrp_users WHERE id = @id")
vRP.prepare("vRP/update_coins","UPDATE vrp_users SET coins = @coins WHERE id = @id")
vRP.prepare("vRP/get_payments","SELECT id,amount,is_activated,email,pay,user_id FROM vrp_payments WHERE validate_hash = @validate_hash")
vRP.prepare("vRP/update_payments","UPDATE vrp_payments SET is_activated = @is_activated, user_id = @user_id WHERE id = @id")

RegisterCommand('ativar', function(source, args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] then
			local rows = vRP.query("vRP/get_payments",{ validate_hash = args[1] })
			if #rows > 0 then
				local id = rows[1].id
				local email = rows[1].email
				local valorCoins = rows[1].amount
				local checkAtivado = rows[1].is_activated
				local pay = rows[1].pay
				if pay then
					if not checkAtivado then
						vRP.execute("vRP/update_payments",{ id = id, is_activated = 1, user_id = user_id })
						lojaCoins.giveCoins(user_id, valorCoins)
						TriggerClientEvent('chatMessage', source, 'COINS', {28, 141, 1},"^2Você recebeu ^5"..valorCoins.. "BC's ^2e agora possui: ^5"..lojaCoins.getCoins(user_id).."BC's")
						TriggerClientEvent('chatMessage', source, "^9Dados da COMPRA:^2\nE-mail: "..email.."\n Quantidade: "..valorCoins.." BC's \n Ativado: [ID:"..user_id.."] ")
						vRP.log("nzk_logs/loja-coins/ativarCoins.txt", "O [ID: "..user_id.."] ativou a key "..args[1].." na quantidade de "..valorCoins.." BC's")
					else
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Esta key ja foi utilizada pelo ^5[ID: "..rows[1].user_id.."]")
					end
				else
					TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Esta key está em processamento qualquer duvida contate um administrador.")
				end

			else
				TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Esta key que digitou não existe.")
			end
		end
	end
end)

function lojaCoins.getCoins(user_id)
	if user_id then
		local rows = vRP.query("vRP/get_coins",{ id = user_id })
		if #rows > 0 then
			return rows[1].coins
		else
			return false
		end
	end
end

function lojaCoins.giveCoins(user_id, quantidade)
	if user_id then
		local Totalcoins = lojaCoins.getCoins(user_id)
		vRP.execute("vRP/update_coins",{ id = user_id, coins = Totalcoins+quantidade })
	end
end

function lojaCoins.tryCoinsPayment(user_id, coins)
	local source = vRP.getUserSource(user_id)
	local Totalcoins = lojaCoins.getCoins(user_id)
	if user_id then 
		if Totalcoins >= coins then 
			vRP.execute("vRP/update_coins",{ id = user_id, coins = Totalcoins-coins })
			return true
		else
			TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Você precisa de ^5"..coins.." BC's^2 para comprar isso. Você Possui ^5"..Totalcoins.." BC's ")
			return false
		end
	end
end

function lojaCoins.getCoinsClient()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Você possui ^5"..lojaCoins.getCoins(user_id).." BC's.")
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('darbcs', function(source, args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "admin.permissao") then
			if args[1] and args[2] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					lojaCoins.giveCoins(parseInt(args[1]), parseInt(args[2]))
					TriggerClientEvent('chatMessage', source, 'COINS', {28, 141, 1},"^2Você deu "..parseInt(args[2]).." BC's para o [ID: "..parseInt(args[1]).."]")
					TriggerClientEvent('chatMessage', nplayer, 'COINS', {28, 141, 1},"^2Você recebeu ^5"..parseInt(args[2]).." BC's^2 e agora possui ^5"..lojaCoins.getCoins(parseInt(args[1])).." BC's ^2.")
					vRP.log("nzk_logs/admin/darNCS.txt", "O Admin [ID: "..user_id.."] deu "..parseInt(args[2]).." BCs para o [ID: "..parseInt(args[1]).."]")
				end
			end
		end
	end
end)

RegisterCommand('verbcs', function(source, args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "admin.permissao") then
			if args[1] then
				local verNcs = lojaCoins.getCoins(parseInt(args[1]))
				TriggerClientEvent('chatMessage', source, 'ADMIN', {28, 141, 1},"^2O [ID: "..parseInt(args[1]).."] Possui ^5"..verNcs.." BC's ^2.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local pacotesConfig = {
-- VIP
    { tipo = "esmeralda", pagar = 400, receber = 1200000},
	{ tipo = "prata", pagar = 50, receber = 250000},
	{ tipo = "ouro", pagar = 75, receber = 350000},
	{ tipo = "diamante", pagar = 100, receber = 500000},
	{ tipo = "platina", pagar = 200, receber = 800000},

	-- DINHEIRO
	{ tipo = "dinheiro_200k", pagar = 20, receber = 50000},
	{ tipo = "dinheiro_400k", pagar = 35, receber = 80000},
	{ tipo = "dinheiro_600k", pagar = 55, receber = 120000},
	{ tipo = "dinheiro_800k", pagar = 75, receber = 250000},
-- VEICULOS
	{ tipo = "volatus", pagar = 30, receber = nil},
	{ tipo = "frogger", pagar = 30, receber = nil},
	{ tipo = "blazer5", pagar = 30, receber = nil},
	{ tipo = "shotaro", pagar = 30, receber = nil},
    { tipo = "", pagar = 30, receber = nil},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("nzk_coins_comprar")
AddEventHandler("nzk_coins_comprar",function(tipo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(pacotesConfig) do
			if tipo == v.tipo then
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VIPS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					if v.tipo == "esmeralda" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.addUserGroup(user_id, "Esmeralda")
						vRP.giveBankMoney(user_id, v.receber)
						vRP.setUData(parseInt(user_id), "vRP:vip", json.encode(tonumber(31)))
						TriggerClientEvent('chatMessage', -1, 'VIP', {28, 141, 1},"^2O [ID: "..user_id.."] acaba de ativar seu VIP "..string.upper(v.tipo)..".")
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Você recebeu ^5$ "..vRP.format(parseInt(v.receber)).."^2 dólares.")
						vRP.log("nzk_logs/loja-coins/ativouVip.txt", "O [ID: "..user_id.."] ativou o VIP "..string.upper(v.tipo))
					end
				elseif v.tipo == "prata" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.addUserGroup(user_id, "Prata")
						vRP.giveBankMoney(user_id, v.receber)
						vRP.setUData(parseInt(user_id), "vRP:vip", json.encode(tonumber(31)))
						TriggerClientEvent('chatMessage', -1, 'VIP', {28, 141, 1},"^2O [ID: "..user_id.."] acaba de ativar seu VIP "..string.upper(v.tipo)..".")
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Você recebeu ^5$ "..vRP.format(parseInt(v.receber)).."^2 dólares.")
						vRP.log("nzk_logs/loja-coins/ativouVip.txt", "O [ID: "..user_id.."] ativou o VIP "..string.upper(v.tipo))
					end
				elseif v.tipo == "ouro" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.addUserGroup(user_id, "Ouro")
						vRP.giveBankMoney(user_id, v.receber)
						vRP.setUData(parseInt(user_id), "vRP:vip", json.encode(tonumber(31)))
						TriggerClientEvent('chatMessage', -1, 'VIP', {28, 141, 1},"^2O [ID: "..user_id.."] acaba de ativar seu VIP "..string.upper(v.tipo)..".")
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Você recebeu ^5$ "..vRP.format(parseInt(v.receber)).."^2 dólares.")
						vRP.log("nzk_logs/loja-coins/ativouVip.txt", "O [ID: "..user_id.."] ativou o VIP "..string.upper(v.tipo))
					end
				elseif v.tipo == "diamante" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.addUserGroup(user_id, "Diamante")
						vRP.giveBankMoney(user_id, v.receber)
						vRP.setUData(parseInt(user_id), "vRP:vip", json.encode(tonumber(31)))
						vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = 'coquette4' })
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Seu veiculo ja se encontra na garagem.")
						TriggerClientEvent('chatMessage', -1, 'VIP', {28, 141, 1},"^2O [ID: "..user_id.."] acaba de ativar seu VIP "..string.upper(v.tipo)..".")
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Você recebeu ^5$ "..vRP.format(parseInt(v.receber)).."^2 dólares.")
						vRP.log("nzk_logs/loja-coins/ativouVip.txt", "O [ID: "..user_id.."] ativou o VIP "..string.upper(v.tipo))
					end
				elseif v.tipo == "platina" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.addUserGroup(user_id, "Platina")
						vRP.giveBankMoney(user_id, v.receber)
						vRP.setUData(parseInt(user_id), "vRP:vip", json.encode(tonumber(31)))
						vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = 'furia' })
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Seu veiculo ja se encontra na garagem.")
						TriggerClientEvent('chatMessage', -1, 'VIP', {28, 141, 1},"^2O [ID: "..user_id.."] acaba de ativar seu VIP "..string.upper(v.tipo)..".")
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Você recebeu ^5$ "..vRP.format(parseInt(v.receber)).."^2 dólares.")
						vRP.log("nzk_logs/loja-coins/ativouVip.txt", "O [ID: "..user_id.."] ativou o VIP "..string.upper(v.tipo))
					end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
				elseif v.tipo == "volatus" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = 'volatus' })
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Seu veiculo ja se encontra na garagem.")
						vRP.log("nzk_logs/loja-coins/comprouVeiculo.txt", "O [ID: "..user_id.."] comprou o veiculo VOLATUS")
					end
				elseif v.tipo == "frogger" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = 'frogger' })
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Seu veiculo ja se encontra na garagem.")
						vRP.log("nzk_logs/loja-coins/comprouVeiculo.txt", "O [ID: "..user_id.."] comprou o veiculo FROGGER")
					end
				elseif v.tipo == "18performante" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = '18performante' })
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Seu veiculo ja se encontra na garagem.")
						vRP.log("nzk_logs/loja-coins/comprouVeiculo.txt", "O [ID: "..user_id.."] comprou o veiculo HURACAN")
					end
				elseif v.tipo == "blazer5" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = 'blazer5' })
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Seu veiculo ja se encontra na garagem.")
						vRP.log("nzk_logs/loja-coins/comprouVeiculo.txt", "O [ID: "..user_id.."] comprou o veiculo BLAZER5")
					end
				elseif v.tipo == "shotaro" then
					if lojaCoins.tryCoinsPayment(user_id, v.pagar) then
						vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = 'shotaro' })
						TriggerClientEvent('chatMessage', source, 'LOJA', {28, 141, 1},"^2Seu veiculo ja se encontra na garagem.")
						vRP.log("nzk_logs/loja-coins/comprouVeiculo.txt", "O [ID: "..user_id.."] comprou o veiculo SHOTARO")
					end
				end
			end
		end
	end

end)