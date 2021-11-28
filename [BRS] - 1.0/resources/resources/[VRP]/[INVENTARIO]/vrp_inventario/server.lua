local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_inventario",vRPN)
Proxy.addInterface("vrp_inventario",vRPN)

local markers_ids = Tools.newIDGenerator()
local items = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local inventario = {}
	if data and data.inventory then
		for k,v in pairs(data.inventory) do
			if vRP.itemBodyList(k) then
				table.insert(inventario,{ amount = parseInt(v.amount), name = vRP.getItemName(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
			end
		end
		return inventario,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.sendItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		local identity = vRP.getUserIdentity(user_id)
		local identitynu = vRP.getUserIdentity(nuser_id)
		if nuser_id and vRP.itemIndexList(itemName) then
			if parseInt(amount) > 0 then
				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,itemName,amount) then
							vRP.giveInventoryItem(nuser_id,itemName,amount)
							vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
							vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
							TriggerClientEvent("chatMessage",source,"Você enviou ^1"..vRP.getItemName(itemName).." x"..vRP.format(amount).."^0.")
							TriggerClientEvent("chatMessage",nplayer,"Você recebeu ^1"..vRP.getItemName(itemName).." x"..vRP.format(amount).."^0.")
							vRP.log("nzk_logs/player/enviaritensgeral.txt","**ITEM** O [ID:"..user_id.."] Enviou para o [ID:"..nuser_id.."] o Item: (" ..vRP.getItemName(itemName).." "..amount.."x )")
							TriggerClientEvent('NZK:Update',source,'updateMochila')
							TriggerClientEvent('NZK:Update',nplayer,'updateMochila')

							if string.match(itemName, "wbody") or string.match(itemName, "wammo") then
								vRP.log("nzk_logs/player/enviaritens.txt","**ARMAS** O [ID:"..user_id.."] Enviou para o [ID:"..nuser_id.."] o Item: (" ..vRP.getItemName(itemName).." "..amount.."x )")
							end

							if string.match(itemName, "dirty_money") then
								vRP.log("nzk_logs/player/enviaritens.txt","**DINHEIRO SUJO** O [ID:"..user_id.."] Enviou para o [ID:"..nuser_id.."] o Item: (" ..vRP.getItemName(itemName).." "..amount.."x )")
							end
						return true
					end
				end
			else
				TriggerClientEvent("chatMessage",source,"Digite um valor para enviar o item.")
			end
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.dropItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local x,y,z = vRPclient.getPosition(source)

		if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,itemName,amount) then
			if itemName == "mochila1" or itemName == "mochila2" or itemName == "mochila3" or itemName == "scubagear" or itemName == "ouro" or itemName == "ferro" or itemName == "bronze" then
				TriggerClientEvent("chatMessage",source,"^2Este foi Item destruido.")
				TriggerClientEvent('NZK:Update',source,'updateMochila')
			else
				TriggerEvent("DropSystem:create",itemName,amount,x,y,z,3600)
				vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
				vRP.log("nzk_logs/player/droparItens.txt","O [ID: "..user_id.."] Destruiu: ("..vRP.getItemName(itemName).." "..amount.."x) ")
				TriggerClientEvent('NZK:Update',source,'updateMochila')
				return true
			end
		else
			local data = vRP.getUserDataTable(user_id)
			for k,v in pairs(data.inventory) do
				if itemName == k then
					if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
						if itemName == "mochila1" or itemName == "mochila2" or itemName == "mochila3" or itemName == "scubagear" or itemName == "ouro" or itemName == "ferro" or itemName == "bronze" then
							TriggerClientEvent("chatMessage",source,"^2Este foi Item destruido.")
							TriggerClientEvent('NZK:Update',source,'updateMochila')
						else
							TriggerEvent("DropSystem:create",itemName,parseInt(v.amount),x,y,z,3600)
							vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
							vRP.log("nzk_logs/player/droparItens.txt","O [ID: "..user_id.."] Destruiu: ("..vRP.getItemName(itemName).." "..amount.."x) ")
							TriggerClientEvent('NZK:Update',source,'updateMochila')
							return true
						end
					end
				end
			end
		end

	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local pick = {}
local blips = {}
local checkTraje = {}

function vRPN.useItem(itemName,type,ramount)
local source = source
local user_id = vRP.getUserId(source)
	if user_id and ramount ~= nil and parseInt(ramount) >= 0 and not actived[user_id] and actived[user_id] == nil then
		if type == "none" then
			TriggerClientEvent("chatMessage",source,"^9Este item não pode ser usado.")
		elseif type == "usar" then
			if itemName == "lockpick" then
				if vRP.hasPermission(user_id, "perm.driftking") or vRP.hasPermission(user_id, "perm.motoclube")  then
					if not vRPclient.isInSafeZone(source) then
						local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(source,7)
						local mPlacaUser = vRP.getUserByRegistration(mPlaca)
						local x,y,z = vRPclient.getPosition(source)
						if vRP.tryGetInventoryItem(user_id,"lockpick", 1) and mName then
							
							if vRP.hasPermission(user_id,"perm.policia") then
								TriggerClientEvent("syncLock",-1,mNet)
								return
							end
	
							TriggerClientEvent("progress",source,30000,"roubando")
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
	
							SetTimeout(30000,function()
								TriggerClientEvent('cancelando',source,false)
								vRPclient._stopAnim(source,false)
	
								if not mPlacaUser then
									TriggerClientEvent("syncLock",-1,mNet)
									TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
								else
									if math.random(100) >= 70 then
										TriggerClientEvent("syncLock",-1,mNet)
										TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
										vRP.log("nzk_logs/player/lockpick.txt", "**SUCESSO** O [ID: "..user_id.."] Roubou o veiculo "..mModel.."(ID:"..mPlacaUser..") nas nas cordenadas: "..x..","..y..","..z)
									else
										vRP.log("nzk_logs/player/lockpick.txt", "**FALHOU** O [ID: "..user_id.."] Tentou roubar o veiculo "..mModel.."(ID:"..mPlacaUser..") nas cordenadas: "..x..","..y..","..z)
										TriggerClientEvent('chatMessage', source, "^9Roubo do veículo falhou e as autoridades foram acionadas.")
										local policia = vRP.getUsersByPermission("perm.policia")
										for k,v in pairs(policia) do
											local policiaA = vRP.getUserSource(parseInt(v))
											if policiaA then
												async(function()
													local id = idgens:gen()
													TriggerClientEvent('chatMessage',policiaA,"COPOM",{65,130,255},"Roubo na ^1"..mStreet.."^0 do veículo ^1"..mModel.."^0 de placa ^1"..mPlaca.."^0 verifique o ocorrido.")
													pick[id] = vRPclient.addBlip(policiaA,x,y,z,153,84,"Ocorrência",0.5,false)
													SetTimeout(60000,function() vRPclient.removeBlip(policiaA,pick[id]) idgens:free(id) end)
												end)
											end
										end
									end
								end
							end)
						else
							TriggerClientEvent('chatMessage', source, "^2Precisa de uma Lockpick para iniciar o roubo do veículo.")
						end
					else
						TriggerClientEvent('chatMessage', source, '^2Você não pode fazer isso em uma ^9SAFE-ZONE.')
					end
				else
					TriggerClientEvent('chatMessage', source, "^2Você não pode utilizar lock-pick.")	
				end
				TriggerClientEvent('NZK:Update',source,'updateMochila')
			elseif itemName == "mochila1" then
				TriggerClientEvent('nzk:mochila', source,1)
				vRP.setMochila(user_id,20)
				TriggerClientEvent('NZK:Update',source,'updateMochila')
			elseif itemName == "mochila2" then
				TriggerClientEvent('nzk:mochila', source,2)
				vRP.setMochila(user_id,40)
				TriggerClientEvent('NZK:Update',source,'updateMochila')
			elseif itemName == "mochila3" then
				TriggerClientEvent('nzk:mochila', source,3)
				vRP.setMochila(user_id,50)
				TriggerClientEvent('NZK:Update',source,'updateMochila')
			elseif itemName == "scubagear" then
				if checkTraje[user_id] then
					TriggerClientEvent("nzk:scubaGearClear", source)
					checkTraje[user_id] = false
				else
					TriggerClientEvent("nzk:scubaGear", source)
					checkTraje[user_id] = true
				end
			elseif itemName == "body_armor" then
				if vRP.tryGetInventoryItem(user_id, "body_armor", 1) then
					vRPclient.setArmour(source, 100)
					TriggerClientEvent('NZK:Update',source,'updateMochila')
				end
			elseif itemName == "night_vison" then
				local vestirOculos = { {"veh@bicycle@roadfront@base_fps","put_on_helmet",1}, }
				vRPclient.playAnim(source,true,vestirOculos,false)
				SetTimeout(1800, function()
					vRPclient.nightvision(source)
				end)
			elseif itemName == "weed" or itemName == "cocaine" or itemName == "metanfetamina" then
				if vRP.tryGetInventoryItem(user_id, itemName, tonumber(ramount)) then
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke", "mp_player_int_smoke"}},true)
					SetTimeout(10000,function()
						vRPclient._stopAnim(source, false)
						vRPclient._playScreenEffect(source, "RaceTurbo", 180)
						vRPclient._playScreenEffect(source, "DrugsTrevorClownsFight", 180)
					end)
					TriggerClientEvent('NZK:Update',source,'updateMochila')
				end 
			elseif itemName == "chave_algemas" then
				local nplayer = vRPclient.getNearestPlayer(source,2)
				if nplayer then
					if not vRPclient.isInSafeZone(source) then
						if vRPclient.isHandcuffed(nplayer) then
							if vRP.tryGetInventoryItem(user_id, itemName, 1) then
								vRPclient.toggleHandcuff(nplayer)
								TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
								TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
								vRP.giveInventoryItem(user_id, "algemas", 1)
								TriggerClientEvent("chatMessage",source,"^2Você desalgemou um jogador próximo.")
								TriggerClientEvent('NZK:Update',source,'updateMochila')
							else
								TriggerClientEvent("chatMessage",source,"^2Você não possui chave de algemas.")
							end
						else
							TriggerClientEvent("chatMessage",source,"^2O Jogador não está algemado.")
						end
	
					else
						TriggerClientEvent('chatMessage', source, '^2Você não pode fazer isso em uma ^9SAFE-ZONE.')
					end
				else
					TriggerClientEvent("chatMessage",source,"^2Nenhum jogador proximo.")
				end
			elseif itemName == "algemas" then
				if not vRPclient.isInSafeZone(source) then
				local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer then
						if not vRPclient.isHandcuffed(nplayer) then
							if vRP.tryGetInventoryItem(user_id, itemName, 1) then
								TriggerClientEvent('cancelando',source,true)
								TriggerClientEvent('cancelando',nplayer,true)
								TriggerClientEvent('carregar',nplayer,source)
								vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
								vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
								SetTimeout(3500,function()
									vRPclient._stopAnim(source,false)
									vRPclient.toggleHandcuff(nplayer)
									TriggerClientEvent('carregar',nplayer,source)
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('cancelando',nplayer,false)
									TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
									TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
								end)
								vRP.giveInventoryItem(user_id, "chave_algemas", 1)
								TriggerClientEvent('NZK:Update',source,'updateMochila')
							else
								TriggerClientEvent("chatMessage",source,"^2Você não possui algemas.")
							end
						else
							TriggerClientEvent("chatMessage",source,"^2O Jogador ja esta algemado.")
						end
		
					else
						TriggerClientEvent("chatMessage",source,"^2Nenhum jogador proximo.")
					end
				else
					TriggerClientEvent('chatMessage', source, '^2Você não pode fazer isso em uma ^9SAFE-ZONE.')
				end
			elseif itemName == "vendaolhos" then
				if not vRPclient.isInSafeZone(source) then
					if vRP.getInventoryItemAmount(user_id,"vendaolhos") >= 1 then
						local nplayer = vRPclient.getNearestPlayer(source,2)
						if nplayer then
							if vRPclient.isHandcuffed(nplayer) then
								vRPclient.setCapuz(nplayer)
								vRP.closeMenu(nplayer)
								TriggerClientEvent("chatMessage",source,"^5Capuz utilizado com sucesso.")
							else
								TriggerClientEvent("chatMessage",source,"^2O Jogador não está algemado.")
							end
						else
							TriggerClientEvent("chatMessage",source,"^2Nenhum jogador proximo.")
						end
						TriggerClientEvent('NZK:Update',source,'updateMochila')
					end
				else
					TriggerClientEvent('chatMessage', source, '^2Você não pode fazer isso em uma ^9SAFE-ZONE.')
				end

			end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		elseif type == "comer" then
			if vRP.tryGetInventoryItem(user_id, itemName, tonumber(ramount)) then
				vRP.varyHunger(user_id, vRP.itemFome(itemName))
				play_eat(source)
				TriggerClientEvent('NZK:Update',source,'updateMochila')
			end
		elseif type == "beber" then
			if itemName == "vodka" then
				if vRP.tryGetInventoryItem(user_id, itemName, tonumber(ramount)) then
					play_drink(source)
					vRP.varyHunger(user_id, 5)
					vRP.varyThirst(user_id, -5)
					SetTimeout(10000,function()
						vRPclient._stopAnim(source, false)
						vRPclient._playScreenEffect(source, "RaceTurbo", 180)
						vRPclient._playScreenEffect(source, "DrugsTrevorClownsFight", 180)
					end)
					TriggerClientEvent('NZK:Update',source,'updateMochila')
				end
			elseif itemName == "redgull" then
				if vRP.tryGetInventoryItem(user_id, itemName, tonumber(ramount)) then 
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)

					TriggerClientEvent('NZK:ENERGETICO',source, true)
					TriggerClientEvent('chatMessage', source, '^2Você bebeu um energetico.')
					TriggerClientEvent('NZK:Update',source,'updateMochila')
					SetTimeout(5*1000, function() vRPclient._DeletarObjeto(source) end)
					SetTimeout(60*1000, function() TriggerClientEvent('NZK:ENERGETICO',source, false) vRPclient._DeletarObjeto(source) TriggerClientEvent('chatMessage', source, '^2O efeito do energético passou e o coração voltou a bater normalmente.') end)
				end
			else
				if vRP.tryGetInventoryItem(user_id, itemName, tonumber(ramount)) then
					vRP.varyThirst(user_id, vRP.itemSede(itemName))
					play_drink(source)
					TriggerClientEvent('NZK:Update',source,'updateMochila')
				end
			end
		elseif type == "remedio" then
			if vRPclient.checkHospital(source) then
				if vRP.tryGetInventoryItem(user_id, itemName, tonumber(ramount)) then
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke", "mp_player_int_smoke"}},true)
					SetTimeout(3*1000, function()
						vRPclient._stopAnim(source, false)
						vRPclient.loadAnimSet(source, "MOVE_M@DRUNK@SLIGHTLYDRUNK")
						vRPclient.playScreenEffect(source, "Rampage", 25)
						vRPclient.varyHealth(source,vRP.itemVida(itemName))
						SetTimeout(25*1000, function()
							vRPclient.unloadAnimSet(source)
						end)
					end)
					TriggerClientEvent('NZK:Update',source,'updateMochila')
				end
			else
				TriggerClientEvent("chatMessage",source,"^9Este item não pode ser usado fora do hospital.")
			end
		elseif type == "equipar" then
			if vRP.tryGetInventoryItem(user_id,itemName,1) then
				local weapons = {}
				weapons[string.gsub(itemName,"wbody|","")] = { ammo = 0 }
				vRPclient._giveWeapons(source,weapons)
				TriggerClientEvent('NZK:Update',source,'updateMochila')
			end
		elseif type == "recarregar" then
			local uweapons = vRPclient.getWeapons(source)
			local weaponuse = string.gsub(itemName,"wammo|","")
			local weaponusename = "wammo|"..weaponuse
			if uweapons[weaponuse] then
				local itemAmount = 0
				local data = vRP.getUserDataTable(user_id)
				for k,v in pairs(data.inventory) do
					if weaponusename == k then
						if v.amount > 250 then
							v.amount = 250
						end
						itemAmount = v.amount
						if vRP.tryGetInventoryItem(user_id, weaponusename, parseInt(v.amount)) then
							local weapons = {}
							weapons[weaponuse] = { ammo = v.amount }
							itemAmount = v.amount
							vRPclient._giveWeapons(source,weapons,false)
							TriggerClientEvent('NZK:Update',source,'updateMochila')
						end
					end
				end
			end

		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function play_eat(source)
    local seq = {
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter", 1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger", 1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 1},
        {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger", 1}
    }
    vRPclient._playAnim(source, true, seq, false)
end

function play_drink(source)
    local seq = {
        {"mp_player_intdrink", "intro_bottle", 1},
        {"mp_player_intdrink", "loop_bottle", 1},
        {"mp_player_intdrink", "outro_bottle", 1}
    }

    vRPclient._playAnim(source, true, seq, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	actived[user_id] = nil
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPAR ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('DropSystem:create',function(item,count,px,py,pz,tempo)
	local id = markers_ids:gen()
	if id then
		items[id] = { item = item, count = count, x = px, y = py, z = pz, name = vRP.getItemName(item), tempo = tempo }
		TriggerClientEvent('DropSystem:createForAll',-1,id,items[id])
	end
end)

RegisterServerEvent('DropSystem:drop')
AddEventHandler('DropSystem:drop',function(item,count)
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,item,count)
		TriggerClientEvent('DropSystem:createForAll',-1)
	end
end)

RegisterServerEvent('DropSystem:take8828123')
AddEventHandler('DropSystem:take8828123',function(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if items[id] ~= nil then
			local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(items[id].item)*items[id].count
			if new_weight <= vRP.getInventoryMaxWeight(user_id) then
				if items[id] == nil then
					return
				end
				vRP.giveInventoryItem(user_id,items[id].item,items[id].count)
				vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
				vRP.log("nzk_logs/player/pegarItem.txt", "O [ID: "..user_id.."] pegou o item ".. vRP.getItemName(items[id].item).." ".. items[id].count.. "x")
				items[id] = nil
				markers_ids:free(id)
				TriggerClientEvent('DropSystem:remove',-1,id)
			else
				TriggerClientEvent("chatMessage",source,"^9Mochila cheia.")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(items) do
			if items[k].tempo > 0 then
				items[k].tempo = items[k].tempo - 1
				if items[k].tempo <= 0 then
					items[k] = nil
					markers_ids:free(k)
					TriggerClientEvent('DropSystem:remove',-1,k)
				end
			end
		end
	end
end)