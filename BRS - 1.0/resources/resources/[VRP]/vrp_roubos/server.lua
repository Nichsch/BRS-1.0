local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_roubos",func)
local idgens = Tools.newIDGenerator()
local blips = {}

local roubos = {
	 { ['id'] = 1, ['roubo'] = "registradora" },
	 { ['id'] = 2, ['roubo'] = "registradora" },
	 { ['id'] = 3, ['roubo'] = "registradora" },
	 { ['id'] = 4, ['roubo'] = "registradora" },
	 { ['id'] = 5, ['roubo'] = "registradora" },
	 { ['id'] = 6, ['roubo'] = "registradora" },
	 { ['id'] = 7, ['roubo'] = "registradora" },
	 { ['id'] = 8, ['roubo'] = "registradora" },
	 { ['id'] = 9, ['roubo'] = "registradora" },
	 { ['id'] = 10, ['roubo'] = "registradora" },
	 { ['id'] = 11, ['roubo'] = "registradora" },
	 { ['id'] = 12, ['roubo'] = "registradora" },
	 { ['id'] = 13, ['roubo'] = "registradora" },
	 { ['id'] = 14, ['roubo'] = "registradora" },
	 { ['id'] = 15, ['roubo'] = "registradora" },
	 { ['id'] = 16, ['roubo'] = "registradora" },
	 { ['id'] = 17, ['roubo'] = "registradora" },
	 { ['id'] = 18, ['roubo'] = "registradora" },
	 { ['id'] = 19, ['roubo'] = "registradora" },
	 { ['id'] = 20, ['roubo'] = "registradora" },
	 { ['id'] = 21, ['roubo'] = "registradora" },
	 { ['id'] = 22, ['roubo'] = "registradora" },
	 { ['id'] = 23, ['roubo'] = "registradora" },
	 { ['id'] = 24, ['roubo'] = "registradora" },
	 { ['id'] = 25, ['roubo'] = "registradora" },
	 { ['id'] = 26, ['roubo'] = "registradora" },
	 { ['id'] = 27, ['roubo'] = "registradora" },
	 { ['id'] = 28, ['roubo'] = "registradora" },
	 { ['id'] = 29, ['roubo'] = "registradora" },
	 { ['id'] = 30, ['roubo'] = "registradora" },
	 { ['id'] = 31, ['roubo'] = "registradora" },
	 { ['id'] = 32, ['roubo'] = "registradora" },
	 { ['id'] = 33, ['roubo'] = "registradora" },
	 { ['id'] = 34, ['roubo'] = "registradora" },
	 { ['id'] = 35, ['roubo'] = "registradora" },
	 { ['id'] = 36, ['roubo'] = "registradora" },
	 { ['id'] = 37, ['roubo'] = "registradora" },
	 { ['id'] = 38, ['roubo'] = "registradora" },
	 { ['id'] = 39, ['roubo'] = "registradora" },
	 { ['id'] = 40, ['roubo'] = "registradora" },
	 { ['id'] = 41, ['roubo'] = "registradora" },
	 { ['id'] = 42, ['roubo'] = "registradora" },
	 { ['id'] = 43, ['roubo'] = "registradora" },
	 { ['id'] = 44, ['roubo'] = "registradora" },
	 { ['id'] = 45, ['roubo'] = "registradora" },
	 { ['id'] = 46, ['roubo'] = "registradora" },
	 { ['id'] = 47, ['roubo'] = "registradora" },
	 { ['id'] = 48, ['roubo'] = "registradora" },
	 { ['id'] = 49, ['roubo'] = "registradora" },
	 { ['id'] = 50, ['roubo'] = "registradora" },
	 { ['id'] = 51, ['roubo'] = "registradora" },
	 { ['id'] = 52, ['roubo'] = "registradora" },
	 { ['id'] = 53, ['roubo'] = "registradora" },
	 { ['id'] = 54, ['roubo'] = "registradora" },
	 { ['id'] = 55, ['roubo'] = "registradora" },
	 { ['id'] = 56, ['roubo'] = "registradora" },
	 { ['id'] = 57, ['roubo'] = "registradora" },
	 { ['id'] = 58, ['roubo'] = "registradora" },
	 { ['id'] = 59, ['roubo'] = "registradora" },
	 { ['id'] = 60, ['roubo'] = "registradora" },
	 { ['id'] = 61, ['roubo'] = "registradora" },
	 { ['id'] = 62, ['roubo'] = "registradora" },
	 { ['id'] = 63, ['roubo'] = "registradora" },
	 { ['id'] = 64, ['roubo'] = "registradora" },
	 { ['id'] = 65, ['roubo'] = "registradora" },
	 { ['id'] = 66, ['roubo'] = "registradora" },
	 { ['id'] = 67, ['roubo'] = "registradora" },
	 { ['id'] = 68, ['roubo'] = "registradora" },
	 { ['id'] = 69, ['roubo'] = "registradora" },
	 { ['id'] = 70, ['roubo'] = "registradora" },
	 { ['id'] = 71, ['roubo'] = "registradora" },
	 { ['id'] = 72, ['roubo'] = "registradora" },
	 { ['id'] = 73, ['roubo'] = "registradora" },
	 { ['id'] = 74, ['roubo'] = "registradora" },
-- CAIXA ELETRONICO
	{ ['id'] = 75, ['roubo'] = "caixa" },
	{ ['id'] = 76, ['roubo'] = "caixa" },
	{ ['id'] = 77, ['roubo'] = "caixa" },
	{ ['id'] = 78, ['roubo'] = "caixa" },
	{ ['id'] = 79, ['roubo'] = "caixa" },
	{ ['id'] = 80, ['roubo'] = "caixa" },
	{ ['id'] = 81, ['roubo'] = "caixa" },
	{ ['id'] = 82, ['roubo'] = "caixa" },
	{ ['id'] = 83, ['roubo'] = "caixa" },
	{ ['id'] = 84, ['roubo'] = "caixa" },
	{ ['id'] = 85, ['roubo'] = "caixa" },
	{ ['id'] = 86, ['roubo'] = "caixa" },
-- LOJINHA
	{ ['id'] = 87, ['roubo'] = "lojinha" },
	{ ['id'] = 88, ['roubo'] = "lojinha" },
	{ ['id'] = 89, ['roubo'] = "lojinha" },
	{ ['id'] = 90, ['roubo'] = "lojinha" },
	{ ['id'] = 91, ['roubo'] = "lojinha" },
	{ ['id'] = 92, ['roubo'] = "lojinha" },
	{ ['id'] = 93, ['roubo'] = "lojinha" },
	{ ['id'] = 94, ['roubo'] = "lojinha" },
	{ ['id'] = 95, ['roubo'] = "lojinha" },
	{ ['id'] = 96, ['roubo'] = "lojinha" },
	{ ['id'] = 97, ['roubo'] = "lojinha" },
	{ ['id'] = 98, ['roubo'] = "lojinha" },
-- AMMUNATION
	{ ['id'] = 99, ['roubo'] = "ammunation" },
	{ ['id'] = 106, ['roubo'] = "ammunation" },
-- JOALHERIA
	{ ['id'] = 100, ['roubo'] = "joalheria" },
	{ ['id'] = 101, ['roubo'] = "joalheria" },
	{ ['id'] = 102, ['roubo'] = "joalheria" },
	{ ['id'] = 103, ['roubo'] = "joalheria" },
	{ ['id'] = 104, ['roubo'] = "joalheria" },
	{ ['id'] = 105, ['roubo'] = "joalheria" },
-- BANCO
	{ ['id'] = 107, ['roubo'] = "banco" },
-- Niobio DESATIVADO ( Client and server)
	{ ['id'] = 109, ["roubo"] = "niobio" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(id,x,y,z,head,tempo,anim1,anim2,policiaMin)
	local source = source
	local user_id = vRP.getUserId(source) 
	if user_id then
		for k,v in pairs(roubos) do
			if id == v.id then
				if timers[id] == 0 or not timers[id] then
					if v.roubo == "registradora" then
						
						local policia = vRP.getUsersByPermission("perm.roubos")
						if #policia >= policiaMin then 
							timers[id] = 600
							vRPclient._playAnim(source,false,{{anim1, anim2}},true)
							TriggerClientEvent("progress",source,tempo*1000,"roubando")
							vRP.log("nzk_logs/player/registradora.txt", "O [ID: "..user_id.."] inicou assalto na caixa registradora.")
							TriggerClientEvent('Roubo:iniciando',source,head,x,y,z,tempo)
							TriggerClientEvent('chatMessage', source, '^9Você iniciou o roubo aguarde '..tempo..' segundos(s).')
							for l,w in pairs(policia) do
								local player = vRP.getUserSource(parseInt(w))
								if player then
									async(function()
										local ids = idgens:gen()
										blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
										vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
										TriggerClientEvent('chatMessage', player, "190",{64,64,255}, '^2O roubo começou na ^1Caixa Registradora^2, dirija-se até o local e intercepte o assaltante.')
										SetTimeout(tempo*1000+100,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
									end)
								end
							end

							SetTimeout(tempo*1000,function() 
								local pagamento = math.random(2000,9000)
								vRP._giveInventoryItem(user_id,"dirty_money",pagamento)
								TriggerClientEvent('chatMessage', source, '^2Roubo concluido você levou '..pagamento..'')
								vRP.log("nzk_logs/player/registradora.txt", "O [ID: "..user_id.."] terminou assalto na caixa registradora e levou "..pagamento..".")
								
							end)
						else
							TriggerClientEvent('chatMessage', source, '^9Número insuficiente de policiais no momento.')
						end

					elseif v.roubo == "caixa" then

						local policia = vRP.getUsersByPermission("perm.roubos")
						if #policia >= policiaMin then 
							timers[id] = 600
							vRPclient._playAnim(source,false,{{anim1, anim2}},true)
							TriggerClientEvent("progress",source,tempo*1000,"roubando")
							vRP.log("nzk_logs/player/caixaeletronico.txt", "O [ID: "..user_id.."] inicou assalto na caixa eletronico.")
							TriggerClientEvent('Roubo:iniciando',source,head,x,y,z,tempo)
							TriggerClientEvent('chatMessage', source, '^9Você iniciou o roubo aguarde '..tempo..' segundos(s).')
							for l,w in pairs(policia) do
								local player = vRP.getUserSource(parseInt(w))
								if player then
									async(function()
										local ids = idgens:gen()
										blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
										vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
										TriggerClientEvent('chatMessage', player,"190",{64,64,255}, '^2O roubo começou na ^1Caixa Eletronico^2, dirija-se até o local e intercepte o assaltante.')
										SetTimeout(tempo*1000+100,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
									end)
								end
							end

							SetTimeout(tempo*1000,function() 
								local pagamento = math.random(1000,5000)
								vRP._giveInventoryItem(user_id,"dirty_money",pagamento)
								TriggerClientEvent('chatMessage', source, '^2Roubo concluido você levou '..pagamento..'')
								vRP.log("nzk_logs/player/caixaeletronico.txt", "O [ID: "..user_id.."] terminou assalto na caixa eletronico e levou "..pagamento..".")
								
							end)
						else
							TriggerClientEvent('chatMessage', source, '^9Número insuficiente de policiais no momento.')
						end

					elseif v.roubo == "lojinha" then

						local policia = vRP.getUsersByPermission("perm.roubos")
						if #policia >= policiaMin then 
							timers[id] = 600
							vRPclient._playAnim(source,false,{{anim1, anim2}},true)
							TriggerClientEvent("progress",source,tempo*1000,"roubando")
							vRP.log("nzk_logs/player/lojinha.txt", "O [ID: "..user_id.."] inicou assalto na lojinha.")
							TriggerClientEvent('Roubo:iniciando',source,head,x,y,z,tempo)
							TriggerClientEvent('chatMessage', source, '^9Você iniciou o roubo aguarde '..tempo..' segundos(s).')
							for l,w in pairs(policia) do
								local player = vRP.getUserSource(parseInt(w))
								if player then
									async(function()
										local ids = idgens:gen()
										blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
										vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
										TriggerClientEvent('chatMessage', player,"190",{64,64,255}, '^2O roubo começou na ^1Loja^2, dirija-se até o local e intercepte o assaltante.')
										SetTimeout(tempo*1000+100,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
									end)
								end
							end

							SetTimeout(tempo*1000,function() 
								local pagamento = math.random(120000,500000)
								vRP._giveInventoryItem(user_id,"dirty_money",pagamento)
								TriggerClientEvent('chatMessage', source, '^2Roubo concluido você levou '..pagamento..'')
								vRP.log("nzk_logs/player/lojinha.txt", "O [ID: "..user_id.."] terminou assalto na lojinha e levou "..pagamento..".")
							end)
						else
							TriggerClientEvent('chatMessage', source, '^9Número insuficiente de policiais no momento.')
						end

					elseif v.roubo == "ammunation" then
						if vRP.tryGetInventoryItem(user_id, "solda", 1) then
							local policia = vRP.getUsersByPermission("perm.roubos")
							if #policia >= policiaMin then 
								timers[id] = 600
			
								TriggerClientEvent("progress",source,tempo*1000,"roubando")
								vRP.log("nzk_logs/player/ammunation.txt", "O [ID: "..user_id.."] inicou assalto no ammunation.")
								TriggerClientEvent('Roubo:iniciando',source,head,x,y,z,tempo)
								vRPclient._playAnim(source,false,{task=anim1},true)
								TriggerClientEvent('chatMessage', source, '^9Você iniciou o roubo aguarde '..tempo..' segundos(s).')
								for l,w in pairs(policia) do
									local player = vRP.getUserSource(parseInt(w))
									if player then
										async(function()
											local ids = idgens:gen()
											blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
											vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
											TriggerClientEvent('chatMessage', player,"190",{64,64,255}, '^2O roubo começou na ^1Ammunation^2, dirija-se até o local e intercepte o assaltante.')
											SetTimeout(tempo*1000+100,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
										end)
									end
								end

								SetTimeout(tempo*1000,function() 
									local id = math.random(1,8)
									local items = {
										[1] = { ['item'] = "wbody|WEAPON_PISTOL_MK2", ['qnt'] = 1, ['item2'] = "wammo|WEAPON_PISTOL_MK2", ['qnt2'] = 100 },
										[2] = { ['item'] = "wbody|WEAPON_PISTOL_MK2", ['qnt'] = 1, ['item2'] = "wammo|WEAPON_PISTOL_MK2", ['qnt2'] = 100 },
										[3] = { ['item'] = "wbody|WEAPON_PISTOL_MK2", ['qnt'] = 2, ['item2'] = "wammo|WEAPON_PISTOL_MK2", ['qnt2'] = 200 },
										[4] = { ['item'] = "body_armor", ['qnt'] = 2, ['item2'] = nil, ['qnt2'] = nil },
										[5] = { ['item'] = "body_armor", ['qnt'] = 1, ['item2'] = nil, ['qnt2'] = nil },
										[6] = { ['item'] = "wbody|WEAPON_SMG", ['qnt'] = 1, ['item2'] = "wammo|WEAPON_SMG", ['qnt2'] = 100 },
										[7] = { ['item'] = "wbody|WEAPON_PISTOL", ['qnt'] = 1, ['item2'] = "wammo|WEAPON_PISTOL", ['qnt2'] = 100 },
										[8] = { ['item'] = "wbody|WEAPON_PISTOL", ['qnt'] = 2, ['item2'] = "wammo|WEAPON_PISTOL", ['qnt2'] = 200 },
									} 
									vRP._giveInventoryItem(user_id,items[id].item,items[id].qnt)
									vRP._giveInventoryItem(user_id,items[id].item2,items[id].qnt2)
									TriggerClientEvent('chatMessage', source, '^2Roubo concluido.')
									vRP.log("nzk_logs/player/ammunation.txt", "O [ID: "..user_id.."] terminou assalto na ammunation .")
								end)


							else
								TriggerClientEvent('chatMessage', source, '^9Número insuficiente de policiais no momento.')
							end
						else
							TriggerClientEvent('chatMessage', source, '^9Você não possui uma solda')
						end
					elseif v.roubo == "joalheria" then
							local policia = vRP.getUsersByPermission("perm.roubos")
							if #policia >= policiaMin then 
								timers[id] = 400
			
								TriggerClientEvent("progress",source,tempo*1000,"roubando")
								vRP.log("nzk_logs/player/joalheria.txt", "O [ID: "..user_id.."] inicou assalto no joalheria.")
								TriggerClientEvent('Roubo:iniciando',source,head,x,y,z,tempo)
								vRPclient._playAnim(source,false,{{anim1, anim2}},true)
								TriggerClientEvent('chatMessage', source, '^9Você iniciou o roubo aguarde '..tempo..' segundos(s).')
								for l,w in pairs(policia) do
									local player = vRP.getUserSource(parseInt(w))
									if player then
										async(function()
											local ids = idgens:gen()
											blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
											vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
											TriggerClientEvent('chatMessage', player,"190",{64,64,255}, '^2O roubo começou na ^1Joalheria^2, dirija-se até o local e intercepte o assaltante.')
											SetTimeout(tempo*1000+100,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
										end)
									end
								end

								SetTimeout(tempo*1000,function() 
									local id = math.random(1,6)
									local items = {
										[1] = { ['item'] = "joia", ['qnt'] = 8},
										[2] = { ['item'] = "relogio", ['qnt'] = 8},
										[3] = { ['item'] = "colar", ['qnt'] = 8},
										[4] = { ['item'] = "brincos", ['qnt'] = 6},
										[5] = { ['item'] = "esmeralda", ['qnt'] = 3},
										[6] = { ['item'] = "barra", ['qnt'] = 2},
									} 
									vRP._giveInventoryItem(user_id,items[id].item,items[id].qnt)
									TriggerClientEvent('chatMessage', source, '^2Roubo concluido.')
									vRP.log("nzk_logs/player/joalheria.txt", "O [ID: "..user_id.."] terminou assalto na joalheria .")
								end)


							else
								TriggerClientEvent('chatMessage', source, '^9Número insuficiente de policiais no momento.')
							end

						elseif v.roubo == "banco" then
							if vRP.tryGetInventoryItem(user_id, "solda", 1) then
								local policia = vRP.getUsersByPermission("perm.roubos")
								if #policia >= policiaMin then 
									timers[id] = 600
				
									TriggerClientEvent("progress",source,tempo*1000,"roubando")
									vRP.log("nzk_logs/player/banco.txt", "O [ID: "..user_id.."] inicou assalto no banco.")
									TriggerClientEvent('Roubo:iniciando',source,head,x,y,z,tempo)
									TriggerClientEvent('chatMessage', source, '^9Você iniciou o roubo aguarde '..tempo..' segundos(s).')
									vRPclient._playAnim(source,false,{task=anim1},true)
									for l,w in pairs(policia) do
										local player = vRP.getUserSource(parseInt(w))
										if player then
											async(function()
												local ids = idgens:gen()
												blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
												vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
												TriggerClientEvent('chatMessage', player,"190",{64,64,255}, '^2O roubo começou no ^1Banco^2, dirija-se até o local e intercepte o assaltante.')
												SetTimeout(tempo*1000+100,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
											end)
										end
									end
	
									SetTimeout(tempo*1000,function() 
										local dinheiroSujo = math.random(400000,800000)
										vRP._giveInventoryItem(user_id,"dirty_money",dinheiroSujo)
										TriggerClientEvent('chatMessage', source, '^2Roubo concluido.')
										vRP.log("nzk_logs/player/banco.txt", "O [ID: "..user_id.."] terminou assalto no banco .")
									end)
	
	
								else
									TriggerClientEvent('chatMessage', source, '^9Número insuficiente de policiais no momento.')
								end
							else
								TriggerClientEvent('chatMessage', source, '^9Você não possui uma solda')
							end
					end
				else
					TriggerClientEvent('chatMessage', source, '^2Este local ja foi roubado recentemente aguarde '..timers[id]..' segundos para roubar novamente.')
				end
			end
		end
	end
end 