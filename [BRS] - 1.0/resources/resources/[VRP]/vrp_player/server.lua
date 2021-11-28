local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPplayerC = {}
Tunnel.bindInterface("vrp_player",vRPplayerC)
Proxy.addInterface("vrp_player",vRPplayerC)

src = Proxy.getInterface("vrp_homes")

local idgens = Tools.newIDGenerator()
local blips = {}

vRP.prepare("vRP/get_vehicles_sell","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP.prepare("vRP/remove_vehicle_sell","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
--[[
local veiculosTypes = { 
  { ['veiculo'] = "ninef2", ['veiculoNome'] = "Nine", ['valor'] = 200000},
  { ['veiculo'] = "pturismo", ['veiculoNome'] = "Porshe Panamera", ['valor'] = 1500000},
  { ['veiculo'] = "dukes", ['veiculoNome'] = "Dukes", ['valor'] = 40000},
  { ['veiculo'] = "impaler", ['veiculoNome'] = "Impaler", ['valor'] = 70000},
  { ['veiculo'] = "sentinel", ['veiculoNome'] = "Sentinel", ['valor'] = 80000},
  { ['veiculo'] = "ferrariitalia", ['veiculoNome'] = "Ferrari Italia", ['valor'] = 4000000},
  { ['veiculo'] = "paganihuayra", ['veiculoNome'] = "Pagani Huayra", ['valor'] = 3300000},
  { ['veiculo'] = "amarok", ['veiculoNome'] = "Amarok V6", ['valor'] = 540000},
  { ['veiculo'] = "corsa05", ['veiculoNome'] = "Corsa Hatch Maxx", ['valor'] = 30000},
  { ['veiculo'] = "gronos6x6", ['veiculoNome'] = "Gronos 6X6", ['valor'] = 450000},
  { ['veiculo'] = "nissanskyliner34", ['veiculoNome'] = "Nissan Skyline", ['valor'] = 1300000},
  { ['veiculo'] = "LykanHypersport", ['veiculoNome'] = "Lykan HyperSport", ['valor'] = 4000000},
  { ['veiculo'] = "rs7", ['veiculoNome'] = "Audi RS7", ['valor'] = 600000},
  { ['veiculo'] = "trhawk", ['veiculoNome'] = "Jeep Compass ", ['valor'] = 800000},
  { ['veiculo'] = "vantage", ['veiculoNome'] = "Aston Martin Vantage", ['valor'] = 1000000},
  { ['veiculo'] = "velar", ['veiculoNome'] = "Land Rover Range Velar", ['valor'] = 870000},
  { ['veiculo'] = "vip8", ['veiculoNome'] = "Dodge Viper", ['valor'] = 900000},
  { ['veiculo'] = "vwstance", ['veiculoNome'] = "Passat", ['valor'] = 120000},
  { ['veiculo'] = "x6m", ['veiculoNome'] = "BMW X6M", ['valor'] = 920000}, 
  { ['veiculo'] = "windsor2", ['veiculoNome'] = "Windsor Rolls Royce", ['valor'] = 650000},
  { ['veiculo'] = "cheetah", ['veiculoNome'] = "Cheetah", ['valor'] = 1000000},
  { ['veiculo'] = "mk7", ['veiculoNome'] = "Golf M7", ['valor'] = 70000}, 
  { ['veiculo'] = "xa21", ['veiculoNome'] = "Jaguar C-X75", ['valor'] = 900000},
  { ['veiculo'] = "kamacho", ['veiculoNome'] = "Cannis 4x4", ['valor'] = 450000},
  { ['veiculo'] = "T18", ['veiculoNome'] = "TVR Graffith", ['valor'] = 600000},
  { ['veiculo'] = "c8", ['veiculoNome'] = "Corvette C8", ['valor'] = 1000000},
  { ['veiculo'] = "divo", ['veiculoNome'] = "Bugatti Divo", ['valor'] = 4000000},
  { ['veiculo'] = "nissantitan17", ['veiculoNome'] = "Nissan Titan 2017", ['valor'] = 1800000},
  { ['veiculo'] = "pistas", ['veiculoNome'] = "Ferrari 488", ['valor'] = 2000000},
  { ['veiculo'] = "FCT", ['veiculoNome'] = "Ferrari California", ['valor'] = 2000000},
  { ['veiculo'] = "zx10", ['veiculoNome'] = "Kawasaki Ninja", ['valor'] = 800000},
  { ['veiculo'] = "nh2r", ['veiculoNome'] = "H2R", ['valor'] = 1500000},
  { ['veiculo'] = "f4rr", ['veiculoNome'] = "Agusta", ['valor'] = 800000},
  { ['veiculo'] = "150", ['veiculoNome'] = "CG 150", ['valor'] = 100000},
  { ['veiculo'] = "xt66", ['veiculoNome'] = "XT 660", ['valor'] = 250000},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- /veiculos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('veiculos',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
    if user_id then

      local _pvehicles = vRP.query("vRP/get_vehicles_sell",{ user_id = user_id })
      local pvehicles = {}

      for k,v in pairs(_pvehicles) do
        for m,k in pairs(veiculosTypes) do

          if args[1] == "vender" then
            if args[2] == k.veiculo then
              if k.veiculo == v.vehicle then
                vRP.execute("vRP/remove_vehicle",{ user_id = user_id, vehicle = k.veiculo })
                TriggerClientEvent('chatMessage', source, "^2Você vendeu o veiculo ^5"..k.veiculoNome.."^2 por ^5$"..vRP.format(k.valor).."")
                vRP.giveBankMoney(user_id, k.valor)
                vRP.log("nzk_logs/player/sell-car-command.txt", "O [ID: "..user_id.."] vendeu o veiculo "..k.veiculoNome.." por "..vRP.format(k.valor).." ")
              end
            end
          else
            if k.veiculo == v.vehicle then
              local veiculo = k.veiculo
              local nomeVeiculo = k.veiculoNome
              local valor = k.valor
              
              local tratarVeiculos = "^2ID: ^5"..veiculo.."^2 | Veiculo: ^5"..nomeVeiculo.." ^2| Valor: ^5$"..vRP.format(valor).."^2 | Comando: ^5/veiculos vender "..veiculo
              TriggerClientEvent('chatMessage', source, " "..tratarVeiculos)
            end
          end

        end
      end
    end   
end)
]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STATUS
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status',function(source,args,rawCommand)
  local onlinePlayers = GetNumPlayerIndices()
  local policia = vRP.getUsersByPermission("perm.policia")
  local civil = vRP.getUsersByPermission("perm.pcivil")
  local paramedico = vRP.getUsersByPermission("perm.unizk")
  local mec = vRP.getUsersByPermission("perm.mecanico")
  local staff = vRP.getUsersByPermission("ticket.permissao")
  local ilegal = vRP.getUsersByPermission("ilegal.permissao")
  local user_id = vRP.getUserId(source)        
      TriggerClientEvent("Notify",source,"importante","<bold><b>Jogadores</b>: <b>"..onlinePlayers.."<br>Administração</b>: <b>"..#staff.."<br>Policiais</b>: <b>"..#policia.."<br>Policiais Civis</b>: <b>"..#civil.."<br>Ilegal</b>: <b>"..#ilegal.."<br>Paramédicos</b>: <b>"..#paramedico.."<br>Mecânicos</b> em serviço: <b>"..#mec.."</b></bold>.",9000)
  end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /reparar
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reparar',function(source,args,rawCommand)
local user_id = vRP.getUserId(source)
	if not vRPclient.isInVehicle(source) then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vRP.hasPermission(user_id,"perm.driftking") or vRP.hasPermission(user_id,"perm.motoclube")  then
			if vRPclient.checkOffSetAndHoodOpen(source,vehicle,true) then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
				TriggerClientEvent("progress",source,30000,"reparando")
				SetTimeout(30000,function() 
					TriggerClientEvent('cancelando',source,false) 
					TriggerClientEvent('reparar',source,vehicle) 
					vRPclient._stopAnim(source,false) 
					TriggerClientEvent('chatMessage', source, "^2Você reparou o veiculo.")
				end)
			else
				TriggerClientEvent('chatMessage', source, "^2Voce precisa estar na frente/traz do veiculo.")
			end
		end
	else
		TriggerClientEvent('chatMessage', source, "^2Precisa estar próximo ou fora do veículo para efetuar os reparos.")
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sequestrar
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestrar',function(source,args,rawCommand)
  if not vRPclient.isInSafeZone(source) then
    local nplayer = vRPclient.getNearestPlayer(source,5)
    if nplayer then
      if vRPclient.isHandcuffed(nplayer) then
        if not vRPclient.getNoCarro(source) then
          local vehicle = vRPclient.getNearestVehicle(source,7)
          if vehicle then
            if vRPclient.getCarroClass(source,vehicle) then
              vRPclient.setStandBY(source,parseInt(300))
              vRPclient.setMalas(nplayer)
              vRPclient.setCapuz(nplayer)
            end
          end
        elseif vRPclient.isMalas(nplayer) then
          vRPclient.setMalas(nplayer)
          vRPclient.setCapuz(nplayer)
        end
      else
        TriggerClientEvent('chatMessage', source, '^2A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.')
      end
    end
  else
    TriggerClientEvent('chatMessage', source, '^2Você não pode fazer isso em uma ^9SAFE-ZONE.')
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('garmas',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
  if user_id then
    if not vRP.hasPermission(user_id, "perm.policia.federal") or not vRP.hasPermission(user_id, "perm.policia") then
      local ok = vRP.request(source, "Você deseja guardar suas armas?", 20)
      if ok then
        local weapons = vRPclient.replaceWeapons(source,{})
        local tempog = math.random(15000,25000)
        TriggerClientEvent('chatMessage', source, '^2Você esta guardando suas armas.')
            Citizen.Wait(tempog)
            for k,v in pairs(weapons) do
              if not vRPclient.isInComa(source) then
                vRP.giveInventoryItem(user_id,"wbody|"..k,1)
                if v.ammo > 0 then
                  vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
                end
                TriggerClientEvent('chatMessage', source, '^2Você Guardou seu armamento na mochila.')
                vRP.log("nzk_logs/player/garmas.txt", "O [ID: "..user_id.."] guardou ("..vRP.getItemName(k).." 1x) (municao: "..v.ammo..")")
              end
            end
          end
      end
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Guardar COLETE 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gcolete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
    local armour = vRPclient.getArmour(source)
      if armour and armour >= 95 then
        vRPclient.setArmour(source, 0)
        vRP.giveInventoryItem(user_id, "body_armor", 1)
        TriggerClientEvent('chatMessage', source, '^2Você Guardou seu armamento na mochila.')
      else
        TriggerClientEvent('chatMessage', source, '^2Você não pode guardar um colete danificado.')
      end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(source,5)
		local nuser_id = vRP.getUserId(nplayer)
    if nplayer then
      TriggerClientEvent('chatMessage', source, '^2Você pediu para revistar o [ID:'..nuser_id..'].')
      local ok = vRP.request(nplayer, "Você está sendo revistado pelo [ID: "..user_id.."] deseja aceitar?", 100)
      if ok then
			local weapons = vRPclient.getWeapons(nplayer)
			if weapons then

				local money = vRP.getMoney(nuser_id)
        local items = ""
        local data = vRP.getUserDataTable(nuser_id)
        if data and data.inventory then
          for k,v in pairs(data.inventory) do
            local item_name = vRP.getItemName(k)
            if item_name then
              items = items.."<br />"..item_name.." ("..v.amount..")"
            end
          end
        end

        local weapons_info = ""
        for k,v in pairs(weapons) do
          weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
        end

        vRPclient.setDiv(source,"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 3px; margin: auto; margin-top: 10px; }","<em>Dinheiro: </em>$"..money.."<br /><br /><em>Inventário: </em>"..items.."<br /><br /><em>Armas Equipadas: </em>"..weapons_info.."")
				
				local ok = vRP.request(source,"Esconder revista",1000)
					if ok then
							vRPclient.removeDiv(source,{"police_check"})
						else
							vRPclient.removeDiv(source,{"police_check"})
					end
			end
    else
      TriggerClientEvent('chatMessage', source, '^2O Jogador não aceitou a revista')
    end
  else
    TriggerClientEvent('chatMessage', source, '^2Nenhum jogador proximo.')
  end
    
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBAR
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}

RegisterCommand('roubar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,1)
    if nplayer then
        local nuser_id = vRP.getUserId(nplayer)
        if vRPclient.isInComa(nplayer) and not vRPclient.isInComa(source) then
            if not vRPclient.isInSafeZone(source) then
                vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
                TriggerClientEvent('cancelando',source,true)
                TriggerClientEvent("progress",source,30000,"roubando")
                TriggerClientEvent('chatMessage', source, '^2Você está roubando.')
                TriggerClientEvent('chatMessage', nplayer, '^2Você está sendo roubado.')
                TriggerEvent("NZK:desequiparArmas", nplayer)
                SetTimeout(30000,function()
                    vRPclient.setStandBY(source,parseInt(500))
                    local ndata = vRP.getUserDataTable(nuser_id)
                    if ndata ~= nil then
                        if ndata.inventory ~= nil then
                            for k,v in pairs(ndata.inventory) do
                                if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
                                    if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
                                        vRP.giveInventoryItem(user_id,k,v.amount)
                                    end
                                else
                                    if k then
                                        TriggerClientEvent('cancelando',source,false)
                                        TriggerClientEvent('chatMessage', source, '^2Mochila não suporta '..vRP.format(parseInt(v.amount)) or 0 ..'x '..vRP.getItemName(k) or 0 ..' por causa do peso.')
                                        vRPclient._stopAnim(source,false)
                                        vRPclient._stopAnim(nplayer,false)
                                    else
                                        vRPclient._stopAnim(source,false)
                                        vRPclient._stopAnim(nplayer,false)
                                    end
                                end
                            end
                        end
                    end
                    local weapons = vRPclient.replaceWeapons(nplayer,{})
                    for k,v in pairs(weapons) do
                        vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
                                vRP.giveInventoryItem(user_id,"wbody|"..k,1)
                                vRP.log("nzk_logs/player/saquear.txt","**ARMAS** O [ID: "..user_id.."] Assaltou o [ID: "..nuser_id.."] e levou "..k.." 1x")
                            end
                        else
                            TriggerClientEvent('cancelando',source,false)
                            TriggerClientEvent('chatMessage', source, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                        end
                        if v.ammo > 0 then
                            vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
                            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
                                if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
                                    vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
                                    vRP.log("nzk_logs/player/saquear.txt","**MUNICAO** O [ID: "..user_id.."] Saqueou o [ID: "..nuser_id.."] e levou "..k.." ".. v.amount.."x")
                                end
                            else
                                TriggerClientEvent('cancelando',source,false)
                                TriggerClientEvent('chatMessage', source, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                            end
                        end
                    end

                    local nmoney = vRP.getMoney(nuser_id)
                    if vRP.tryPayment(nuser_id,nmoney) then
                        vRP.giveMoney(user_id,nmoney)
                        vRP.log("nzk_logs/player/saquear.txt","**DINHEIRO** O [ID: "..user_id.."] Saqueou o [ID: "..nuser_id.."] e levou "..nmoney.."")
                    end
                    vRPclient.setStandBY(source,parseInt(600))
                    vRPclient._stopAnim(source,false)
                    TriggerClientEvent('cancelando',source,false)
                    TriggerClientEvent('chatMessage', nplayer, '^9Você foi roubado pelo (ID:'..user_id..').')
                    TriggerClientEvent('chatMessage', source, '^5Roubo concluido com sucesso.')
                end)
            else
                TriggerClientEvent('chatMessage', source, '^2Você não pode fazer isso em uma ^9SAFE-ZONE.')
            end
        else
            if not vRPclient.isInSafeZone(source) then
                if not vRPclient.isInComa(source) then
                    if actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
                        actived[parseInt(user_id)] = 2
                        vRPclient._playAnim(source,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true)
                        vRPclient._playAnim(nplayer,false,{{"mp_arresting","idle",1}},true)
                        TriggerClientEvent('cancelando',source,true)
                        TriggerClientEvent("progress",source,30000,"roubando")
                        TriggerClientEvent('chatMessage', source, '^2Você está assaltando.')
                        TriggerClientEvent('chatMessage', nplayer, '^2Você está sendo assaltado.')
                        TriggerEvent("NZK:desequiparArmas", nplayer)
                        SetTimeout(30000,function()
                            vRPclient.setStandBY(source,parseInt(500))
                            local ndata = vRP.getUserDataTable(nuser_id)
                            if ndata ~= nil then
                                if ndata.inventory ~= nil then
                                    for k,v in pairs(ndata.inventory) do
                                        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
                                            if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
                                                vRP.giveInventoryItem(user_id,k,v.amount)
                                            end
                                        else
                                            if k then
                                                TriggerClientEvent('cancelando',source,false)
                                                TriggerClientEvent('chatMessage', source, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                                                vRPclient._stopAnim(source,false)
                                                vRPclient._stopAnim(nplayer,false)
                                            else
                                                vRPclient._stopAnim(source,false)
                                                vRPclient._stopAnim(nplayer,false)
                                            end
                                        end
                                    end
                                end
                            end

                            local weapons = vRPclient.replaceWeapons(nplayer,{})
                            for k,v in pairs(weapons) do
                                vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
                                if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
                                    if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
                                        vRP.giveInventoryItem(user_id,"wbody|"..k,1)
                                        vRP.log("nzk_logs/player/assaltar.txt","**ARMAS** O [ID: "..user_id.."] Assaltou o [ID: "..nuser_id.."] e levou "..k.." 1x")
                                    end
                                else
                                    TriggerClientEvent('cancelando',source,false)
                                    TriggerClientEvent('chatMessage', source, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                                end
                                if v.ammo > 0 then
                                    vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
                                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
                                        if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
                                            vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
                                            vRP.log("nzk_logs/player/assaltar.txt","**MUNICAO** O [ID: "..user_id.."] Assaltou o [ID: "..nuser_id.."] e levou "..k.." ".. v.amount.."x")
                                        end
                                    else
                                        TriggerClientEvent('cancelando',source,false)
                                        TriggerClientEvent('chatMessage', source, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                                    end
                                end
                            end
                            local nmoney = vRP.getMoney(nuser_id)
                            if vRP.tryPayment(nuser_id,nmoney) then
                                vRP.giveMoney(user_id,nmoney)
                                vRP.log("nzk_logs/player/assaltar.txt","**DINHEIRO** O [ID: "..user_id.."] Assaltou o [ID: "..nuser_id.."] e levou "..nmoney.."")
                            end
                            vRPclient.setStandBY(source,parseInt(600))
                            vRPclient._stopAnim(source,false)
                            vRPclient._stopAnim(nplayer,false)
                            TriggerClientEvent('cancelando',source,false)
                            TriggerClientEvent('chatMessage', nplayer, '^9Você foi roubado pelo (ID:'..user_id..').')
                            TriggerClientEvent('chatMessage', source, '^5Assalto concluido com sucesso.')
                        end)
                    end
                end
            else
                TriggerClientEvent('chatMessage', source, '^2Você não pode fazer isso em uma ^9SAFE-ZONE.')
            end
        end
    else
        TriggerClientEvent('chatMessage', source, '^2Nenhum jogador proximo.')
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 1
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GUARDAR ARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("NZK:desequiparArmas")
AddEventHandler("NZK:desequiparArmas", function(player)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local weapons = vRPclient.getWeapons(player)
    if weapons then

      for k,v in pairs(weapons) do
        vRP.giveInventoryItem(user_id, "wbody|"..k, 1)
        if v.ammo > 0 then
          vRP.giveInventoryItem(user_id, "wammo|"..k, v.ammo)
        end
      end

      vRPclient.giveWeapons(player,{},true)
    end 
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
  if nuser_id and parseInt(args[1]) > 0 then
    if nplayer then
      if vRP.tryPayment(user_id,parseInt(args[1])) then
        vRP.giveMoney(nuser_id,parseInt(args[1]))
        vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
        TriggerClientEvent('chatMessage', source, "^2Você Enviou ^5$"..vRP.format(parseInt(args[1])).."^2 dólares.")
        TriggerClientEvent('chatMessage', nplayer, "^2Recebeu ^5$"..vRP.format(parseInt(args[1])).."^2 dólares.")
        vRP.log("nzk_logs/player/enviardinho.txt", "O [ID:"..user_id.."] enviou "..vRP.format(parseInt(args[1])).." para o [ID: "..nuser_id.."].")
      else
        TriggerClientEvent('chatMessage', source, "^9Não tem a quantia que deseja enviar.")
      end
    end
  else
    TriggerClientEvent('chatMessage', source, "^2Nenhum jogador proximo.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OLX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('olx',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
    if user_id ~= nil then
      if args[1] then
        if args[1] == "VEICULO" then
          if vRP.tryPayment(user_id,1000) then
            local modeloVeiculo = vRP.prompt(source,"Digite o Modelo do veiculo","")
              local maxCharmodelVehicle = string.len(modeloVeiculo)
              if maxCharmodelVehicle >= 3 and maxCharmodelVehicle <= 15 then
                local precoVeiculo = vRP.prompt(source,"Digite o preço do veiculo","")
                  if parseInt(precoVeiculo) >= 1 and parseInt(precoVeiculo) <= 99999999 then
                    local identity = vRP.getUserIdentity(user_id)
                    if identity then
                      TriggerClientEvent('chatMessage', -1, 'OLX', {174,143,232}, ' O '..identity.name..' '..identity.firstname..' está anunciando um veiculo no modelo ^6'..string.upper(modeloVeiculo)..'^0 no valor de ^5$ '..tonumber(precoVeiculo)..'^0, meu contato: ^6'..identity.phone..'')
                    end
                  else
                    TriggerClientEvent('chatMessage', source, "^1ERRO: Insira um valor numérico	entre 1 a 8 caracters")
                  end
              else
                TriggerClientEvent('chatMessage', source, "^2 Digite entre 3 a 15 caracters")
              end
            else
              TriggerClientEvent('chatMessage', source, "^2 Você não possui $ 1.000 para anunciar.")
          end
        elseif args[1] == "PROPRIEDADE" then
          if vRP.tryPayment(user_id,1500) then
            local propriedadeValor = vRP.prompt(source,"Digite o valor da propriedade", "")
            if parseInt(propriedadeValor) >= 1 and parseInt(propriedadeValor) <= 99999999 then
              local identity = vRP.getUserIdentity(user_id)
              if identity then
                TriggerClientEvent('chatMessage', -1, 'OLX', {174,143,232}, ' O '..identity.name..' '..identity.firstname..' está anunciando uma propriedade no valor de ^5$ '..tonumber(propriedadeValor)..'^0, meu contato: ^6'..identity.phone..'')
              end
            else
              TriggerClientEvent('chatMessage', source, "^2 Insira um valor numérico	entre 1 a 8 caracters")
            end
          else
            TriggerClientEvent('chatMessage', source, "^2 Você não possui $ 1.500 para anunciar.")
          end
        end
      else
        TriggerClientEvent('chatMessage', source, "^2USE: /olx VEICULO | PROPRIEDADE")
      end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACAO
-----------------------------------------------------------------------------------------------------------------------------------------
local checkAcao = false
local checkAcaoIniciar = false
RegisterCommand('acao',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
    if user_id ~= nil then
      if args[1] == "INICIAR" then
        if checkAcaoIniciar then
          TriggerClientEvent('chatMessage', source, "^2Ja existe uma ação em andamento.")
        else

          if vRP.hasPermission(user_id, "perm.policia.civil") then
            TriggerClientEvent('chatMessage', -1, 'AÇÃO', {0,0,0}, 'Os policiais iniciaram uma ação')
            checkAcaoIniciar = true
            checkAcao = true
          else
            TriggerClientEvent('chatMessage', -1, 'AÇÃO', {0,0,0}, 'Os bandidos iniciaram uma ação')
            checkAcaoIniciar = true
            checkAcao = true
          end
        end
      elseif args[1] == "INFORMAR" then
        if checkAcao then
          if vRP.hasPermission(user_id, "perm.policia.civil") then
            local policiaisAcao = vRP.prompt(source,"Digite o numero de policias que estarao na açao","")
              if tonumber(policiaisAcao) then
                TriggerClientEvent('chatMessage', -1, 'AÇÃO', {0,0,0}, 'Numero de policiais na ação: ^1'..tonumber(policiaisAcao)..' ')
              else
                TriggerClientEvent('chatMessage', source, "^1ERRO: Insira um valor numérico.")
              end
          else
            local acaoPessoasDentro = vRP.prompt(source, "Digite o numero de pessoas dentro", "")
            if tonumber(acaoPessoasDentro) then
              local acaoPessoasFora = vRP.prompt(source, "Digite o numero de pessoas fora", "")
              if tonumber(acaoPessoasFora) then
                local acaoNumeroRefens = vRP.prompt(source, "Digite o numero de refens", "")
                if tonumber(acaoNumeroRefens) then
                  TriggerClientEvent('chatMessage', -1, 'AÇÃO', {0,0,0}, 'Numero de pessoas dentro: ^1'..tonumber(acaoPessoasDentro)..'^0 Numero de pessoas fora: ^1'..tonumber(acaoPessoasFora)..' ^0Numero de réfens: ^1'..tonumber(acaoNumeroRefens)..'')
                end
              else
                TriggerClientEvent('chatMessage', source, "^2 Insira um valor numérico.")
              end
            else
              TriggerClientEvent('chatMessage', source, "^2 Insira um valor numérico.")
            end
          end
        else
          TriggerClientEvent('chatMessage', source, '^2Nenhuma ação iniciada, use /acao INICIAR')
        end
      elseif args[1] == "VIVOS" then
        if checkAcao then
          if vRP.hasPermission(user_id, "perm.policia.civil") then
            local policiaisVivos = vRP.prompt(source, "Digite o numero de policias vivos", "")
            if tonumber(policiaisVivos) then
              TriggerClientEvent('chatMessage', -1, 'AÇÃO', {0,0,0}, 'Numero de policiais vivos: ^1'..tonumber(policiaisVivos))
            else
              TriggerClientEvent('chatMessage', source, "^2 Insira um valor numérico.")
            end
          else
            local bandidosVivos = vRP.prompt(source, "Digite o numero de bandidos vivos", "")
            if tonumber(bandidosVivos) then
              TriggerClientEvent('chatMessage', -1, 'AÇÃO', {0,0,0}, 'Numero de bandidos vivos: ^1'..tonumber(bandidosVivos))
            else
              TriggerClientEvent('chatMessage', source, "^2 Insira um valor numérico.")
            end
          end
        else
          TriggerClientEvent('chatMessage', source, '^2Nenhuma ação iniciada, use /acao INICIAR')
        end
      elseif args[1] == "FINALIZAR" then
        if checkAcao then
          if vRP.hasPermission(user_id, "perm.policia.civil") then
            TriggerClientEvent('chatMessage', -1, 'AÇÃO', {0,0,0}, 'A policia finalizou ação.')
						checkAcaoIniciar = false
            checkAcao = false
          else
            TriggerClientEvent('chatMessage', -1, 'AÇÃO', {0,0,0}, 'Os bandidos finalizaram a ação.')
						checkAcaoIniciar = false
						checkAcao = false
          end
        else
          TriggerClientEvent('chatMessage', source, '^2Nenhuma ação iniciada, use /acao INICIAR')
        end
      else
        TriggerClientEvent('chatMessage', source, "^2USE: /acao INFORMAR | VIVOS | FINALIZAR | INICIAR")
      end
    end
end)
-----
-- 
-----
local webhooksuspeito= "https://discordapp.com/api/webhooks/754523494699499570/2q-V5iGqQ7FzkgOPGzCHaFm2_yPR4YUqPvSykzymKuFVhc8tpWiqOwarqbBPZ_JwBI5a"

function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

RegisterServerEvent('LOG:ARMAS')
AddEventHandler('LOG:ARMAS', function()
    local user_id = vRP.getUserId(source)
    if user_id~=nil then
        SendWebhookMessage(webhooksuspeito, "[SUSPEITO] SPAWN DE ARMAS "..user_id)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVASAO
-----------------------------------------------------------------------------------------------------------------------------------------
local invasaoTypes = {
  { ['comando'] = "Vermelhos", ['permissaoCheck'] = "perm.vagos", ['x'] = 100.22, ['y'] = -1941.17, ['z'] = 20.79, ['radarName'] = "Invasao no Vermelhos", ['radius'] = 1.0, ['limiteOn'] = 5},
  { ['comando'] = "Verdes", ['permissaoCheck'] = "perm.ballas", ['x'] = 331.20, ['y'] = -2035.20, ['z'] = 21.03, ['radarName'] = "Invasao no Verdes", ['radius'] = 1.0, ['limiteOn'] = 5},
  { ['comando'] = "Mafia", ['permissaoCheck'] = "perm.yakuza", ['x'] = 1388.52, ['y'] = 1142.70, ['z'] = 114.33, ['radarName'] = "Invasao na Mafia", ['radius'] = 1.0, ['limiteOn'] = 5},
  { ['comando'] = "Galaxy", ['permissaoCheck'] = "perm.vanilla", ['x'] = -1884.76, ['y'] = 2059.91, ['z'] = 140.98, ['radarName'] = "Invasao na Galaxy", ['radius'] = 1.0, ['limiteOn'] = 5},
  { ['comando'] = "MC", ['permissaoCheck'] = "perm.bratva", ['x'] = 969.23, ['y'] = -120.65, ['z'] = 74.35, ['radarName'] = "Invasao no MotoClub", ['radius'] = 1.0, ['limiteOn'] = 5},
  { ['comando'] = "DK", ['permissaoCheck'] = "perm.driftking", ['x'] = -1144.83, ['y'] = -1988.69, ['z'] = 13.16, ['radarName'] = "Invasao na DriftKing", ['radius'] = 1.0, ['limiteOn'] = 5},
  { ['comando'] = "Bahamas", ['permissaoCheck'] = "perm.bahamas", ['x'] = 126.59, ['y'] = -1290.11, ['z'] = 29.27, ['radarName'] = "Invasao na Vanilla", ['radius'] = 1.0, ['limiteOn'] = 5},

}

RegisterCommand('invasao',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
    if user_id ~= nil then
      for k,v in pairs(invasaoTypes) do
        local checkPermission = vRP.getUsersByPermission(v.permissaoCheck)
        if args[1] == v.comando then
          if #checkPermission == v.limiteOn then            
            local users = vRP.getUsersByPermission("perm.user")
            for l,w in pairs(users) do
              local allUsers = vRP.getUserSource(parseInt(w))
              local ids = idgens:gen()
              vRP.log("nzk_logs/player/invasao.txt", "O [ID: "..tonumber(user_id).."] iniciou a invesao na organização "..v.comando.."")
              blips[ids] = vRPclient.addBlip(allUsers,v.x,v.y,v.z,9,79,v.radarName,v.radius,true)
              TriggerClientEvent('chatMessage', -1, "^3Alguma Organização/Facção ira invadir o(a) "..v.comando.." em ^515 minutos^2")
              SetTimeout(15*60*1000,function() 
                TriggerClientEvent('chatMessage', -1, "^3Alguma Organização/Facção ira invadir o(a) "..v.comando.." em ^55 minutos^2")
                blips[ids] = vRPclient.addBlip(allUsers,v.x,v.y,v.z,9,79,v.radarName,v.radius,true)
                SetTimeout(5*60*1000,function() 
                  TriggerClientEvent('chatMessage', -1, "^3A Invasão na "..v.comando.." começou, evitem passar na area vermelha. (Duração 60 Minutos)")
                  blips[ids] = vRPclient.addBlip(allUsers,v.x,v.y,v.z,9,79,v.radarName,v.radius,true)
                  SetTimeout(60*60*1000,function() vRPclient.removeBlip(allUsers,blips[ids]) idgens:free(ids) end)
                end)
              end)
            end
          else
            TriggerClientEvent('chatMessage', source, "^2Não possui "..v.limiteOn.." membro(s) da(o) "..v.comando.." para iniciar essa invasao.")
          end
        end
      end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('transferir',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
    if user_id ~= nil then
      local idPlayer = vRP.prompt(source, "Digite o ID: ", "")
      if tonumber(idPlayer) then
        local valorTransferir = vRP.prompt(source,"Digite o valor para transferir:", "")
        local nplayer = vRP.getUserSource(tonumber(idPlayer))
        if nplayer then
          if parseInt(valorTransferir) and parseInt(valorTransferir) > 0 then
            local bancoN = vRP.getBankMoney(tonumber(idPlayer))
            if tonumber(user_id) == tonumber(idPlayer) then
              TriggerClientEvent('chatMessage', source, "^2Você não pode transferir para si mesmo.")
            else
              if vRP.tryTransfer(user_id,parseInt(valorTransferir)) then
                vRP.setBankMoney(tonumber(idPlayer),parseInt(bancoN+parseInt(valorTransferir)))
                TriggerClientEvent('chatMessage', source, "^2Você transferiu ^5$ "..parseInt(valorTransferir).."^2 para o [ID: "..tonumber(idPlayer).."].")
                TriggerClientEvent('chatMessage', nplayer, "^2Você recebeu uma transferencia de ^5$ "..parseInt(valorTransferir).."^2 do [ID: "..user_id.."].")
                vRP.log("nzk_logs/player/transferir.txt", "O [ID: "..tonumber(user_id).."] transferiu $ "..parseInt(valorTransferir).." para o [ID: "..tonumber(idPlayer).."]")
              else
                TriggerClientEvent('chatMessage', source, "^2Você não possui essa quantia para transferir.")
              end
            end
          else
            TriggerClientEvent('chatMessage', source, "^2Valor Invalido!")
          end
        else
          TriggerClientEvent('chatMessage', source, "^2Este ID não se encontra na cidade no momento")
      end
      else
        TriggerClientEvent('chatMessage', source, "^2Valor Invalido!")
      end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Cancelar Missao
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ccm',function(source,args,rawCommand)
		local user_id = vRP.getUserId(source)
    vRP.stopMission(source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ptrans',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.policia.civil") then
    TriggerClientEvent('chatMessage', -1, "^7POLICIA: ^6A Policia irá iniciar a transferência de alguns prisoneiros dentro de alguns minutos.")
  end
end)

RegisterCommand('pblitz',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.policia.civil") then
    TriggerClientEvent('chatMessage', -1, "^7POLICIA: ^6A Policia está realizando uma Blitz.")
  end
end)

RegisterCommand('pcarga',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.policia.civil") then
    TriggerClientEvent('chatMessage', -1, "^7POLICIA: ^6A Policia irá iniciar a transferência de uma carga dentro de alguns minutos.")
  end
end)

function vRPplayerC.policeQTH()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    if vRP.hasPermission(user_id,"perm.policia") then
      if not vRPclient.isInComa(source) then
        local policia = vRP.getUsersByPermission("perm.policia")
        for l,w in pairs(policia) do
          local player = vRP.getUserSource(parseInt(w))
          local x,y,z = vRPclient.getPosition(source)
          if player then
            async(function()
              local identity = vRP.getUserIdentity(parseInt(w))
              if identity then 
                local ids = idgens:gen()
                blips[ids] = vRPclient.addBlip(player,x,y,z,161,63,"QTH: "..identity.firstname.." "..identity.name.."",0.5,true)
                TriggerClientEvent('chatMessage', player, '^1QTH: '..identity.firstname..' '..identity.name)
                SetTimeout(80000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
              end
            end)
          end
        end 
      end
    elseif vRP.hasPermission(user_id,"perm.pcivil") then
      if not vRPclient.isInComa(source) then
        local policia = vRP.getUsersByPermission("perm.pcivil")
        for l,w in pairs(policia) do
          local player = vRP.getUserSource(parseInt(w))
          local x,y,z = vRPclient.getPosition(source)
          if player then
            async(function()
              local identity = vRP.getUserIdentity(parseInt(w))
              if identity then 
                local ids = idgens:gen()
                blips[ids] = vRPclient.addBlip(player,x,y,z,161,28,"QTH: "..identity.firstname.." "..identity.name.."",0.5,true)
                TriggerClientEvent('chatMessage', player, '^1QTH: '..identity.firstname..' '..identity.name)
                SetTimeout(80000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
              end
            end)
          end
        end
      end
    end
  end
end


RegisterCommand('ficha',function(source)
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(source,"perm.policia") or vRP.hasPermission(source,"perm.policia.civil") then
      local consultarRG = vRP.prompt(source, "Digite o RG:", "")
      if consultarRG ~= nil and consultarRG ~= "" then
        local userRG = vRP.getUserByRegistration(consultarRG)

        if userRG then
            local consultarRG = vRP.getUData(user_id, "vRP:ficha:criminal", "")
            if consultarRG then
              vRPclient._setDiv(source,"police_pc",".div_police_pc{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",consultarRG)
              local ok = vRP.request(source, "Deseja fechar o registro criminal?", 999)
              if ok then
                vRPclient._removeDiv(source, "police_pc")
              else
                vRPclient._removeDiv(source, "police_pc")
              end
            end
          else
            TriggerClientEvent('chatMessage', source, "^9RG inexistente ou não se encontra agora pela cidade.")
        end
        
    end
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('extras',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"perm.pcivil") then
			TriggerClientEvent('extras',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYEXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryextras")
AddEventHandler("tryextras",function(index,extra)
	TriggerClientEvent("syncextras",-1,index,parseInt(extra))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPplayerC.Identidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local cash = vRP.getMoney(user_id)
		local banco = vRP.getBankMoney(user_id)
		local identity = vRP.getUserIdentity(user_id)
		local job = vRP.getUserGroupByType(user_id,"job") if (job == nil or job == "") then job = "Nenhum" end
		local org = vRP.getUserGroupByType(user_id,"org") if (org == nil or org == "") then org = "Nenhuma" end
		local vip = vRP.getUserGroupByType(user_id,"vip") if (vip == nil or vip == "") then vip = "Nenhum" end
		local cnh = vRP.hasGroup(user_id,"CNH") if cnh then cnh = "Possui" else cnh = "Não Possui" end
    local parmas = vRP.hasGroup(user_id,"Porte de Arma") if parmas then parmas = "Possui" else parmas = "Não Possui" end
    local value = vRP.getUData(user_id,"vRP:multas")
    local valormultas = json.decode(value) or 0
    local propriedades = src.getUserAddress(user_id)

    
    if #propriedades == 0 then
      propriedades = "Nenhuma"
    else
      propriedades = #propriedades
    end

    if identity then
      return vRP.format(parseInt(cash)),vRP.format(parseInt(banco)),identity.name,identity.firstname,identity.user_id,identity.registration,identity.age,identity.phone,job,org,cnh,parmas,vip,vRP.format(parseInt(valormultas)),propriedades
		end
	end
end

function vRPplayerC.fecharIdentidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
    local ok = vRP.request(source, "Deseja fechar o seu RG?", 120)
    if ok then
      vRPclient._removeDiv(source, "registro")
      return true
    else
      vRPclient._removeDiv(source, "registro")
      return true
    end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDIR RG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pedirrg',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
  local nplayer = vRPclient.getNearestPlayer(source,2)
  if nplayer then
    local nuser_id = vRP.getUserId(nplayer)
    local ok = vRP.request(nplayer,"Estão pedindo seu RG deseja mostrar?", 30)
    TriggerClientEvent('chatMessage', source, "^2Você pediu o rg aguarde...")
    if ok then
      if nuser_id then
        local identity = vRP.getUserIdentity(nuser_id)
        local carteira = vRP.getMoney(nuser_id)
				local value = vRP.getUData(nuser_id,"vRP:multas")
        local valormultas = json.decode(value) or 0
        
        vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #99cc00; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
        vRP.request(source,"Você deseja fechar o registro geral?",1000)
        vRPclient.removeDiv(source,"completerg")
      end
    else
      TriggerClientEvent('chatMessage', source, "^9O Jogador negou-se mostrar o RG.")
    end
  else
    TriggerClientEvent('chatMessage', source, "^2Nenhum jogador proximo.")
  end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SALARIOS 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local salarios = {
  { ['perm'] = "pagamento.diretor.news", ['nome'] = "Diretor NEWS", ['valor'] = 12000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.vice.news", ['nome'] = "Vice-Diretor NEWS", ['valor'] = 10000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.reporter.news", ['nome'] = "Reporter NEWS", ['valor'] = 8000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.camera.news", ['nome'] = "Camera NEWS", ['valor'] = 6000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.comandante.policia", ['nome'] = "Comandante", ['valor'] = 30000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.coronel.policia", ['nome'] = "Coronel", ['valor'] = 25000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.tencoronel.policia", ['nome'] = "Tenente Coronel", ['valor'] = 22000, ['tipo'] = 2 }, 
  { ['perm'] = "pagamento.major.policia", ['nome'] = "Major", ['valor'] = 20000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.capitao.policia", ['nome'] = "Capitao", ['valor'] = 18000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.tenente.policia", ['nome'] = "Tenente", ['valor'] = 16000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.sargento.policia", ['nome'] = "Sargento", ['valor'] = 12000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.cabo.policia", ['nome'] = "Cabo", ['valor'] = 10000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.soldado.policia", ['nome'] = "Soldado", ['valor'] = 8000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.piloto.policia", ['nome'] = "Piloto", ['valor'] = 10000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.recruta.policia", ['nome'] = "Recruta", ['valor'] = 8000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.comandante.pcivil", ['nome'] = "Comandante [CIVIL]", ['valor'] = 30000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.delegado.pcivil", ['nome'] = "Delegado [CIVIL]", ['valor'] = 25000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.corrigidor.pcivil", ['nome'] = "Corrigidor [CIVIL]", ['valor'] = 20000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.investigador.pcivil", ['nome'] = "Investigador [CIVIL]", ['valor'] = 16000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.operador.pcivil", ['nome'] = "Operador [CIVIL]", ['valor'] = 15000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.agente.pcivil", ['nome'] = "Agente [CIVIL]", ['valor'] = 12000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.escrivao.pcivil", ['nome'] = "Escrivao [CIVIL]", ['valor'] = 9000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.piloto.pcivil", ['nome'] = "Piloto [CIVIL]", ['valor'] = 6000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.diretor.unizk", ['nome'] = "Diretor HOSPITAL", ['valor'] = 37000, ['tipo'] = 2 }, 
  { ['perm'] = "pagamento.subdiretor.unizk", ['nome'] = "Sub-Diretor HOSPITAL", ['valor'] = 32000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.gestao.unizk", ['nome'] = "Gestão HOSPITAL", ['valor'] = 28000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.medicom.unizk", ['nome'] = "Medico Militar HOSPITAL", ['valor'] = 28000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.psicologo.unizk", ['nome'] = "Psicologo", ['valor'] = 22000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.medico.unizk", ['nome'] = "Médico HOSPITAL", ['valor'] = 18000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.enfermeiro.unizk", ['nome'] = "Enfermeiro HOSPITAL", ['valor'] = 12000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.socorrista.unizk", ['nome'] = "Socorrista", ['valor'] = 10500, ['tipo'] = 2 },
  { ['perm'] = "pagamento.farmaco.unizk", ['nome'] = "Farmaceutico", ['valor'] = 8000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.ministro", ['nome'] = "Ministro da Justiça", ['valor'] = 20000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.juiz", ['nome'] = "Juiz", ['valor'] = 17000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.promotor", ['nome'] = "Promotor de Justiça", ['valor'] = 14000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.advogado", ['nome'] = "Advogado", ['valor'] = 12000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.mecanico.lider", ['nome'] = "Mecanico Lider", ['valor'] = 2000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.mecanico.membro", ['nome'] = "Mecanico Membro", ['valor'] = 1000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.lscustom.lider", ['nome'] = "LS CUSTOM Lider", ['valor'] = 8000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.lscustom", ['nome'] = "LSCUSTOM Membro", ['valor'] = 5000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.cet.diretor", ['nome'] = "C.E.T", ['valor'] = 12000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.cet.superintendente", ['nome'] = "C.E.T", ['valor'] = 10000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.cet.guarda", ['nome'] = "C.E.T", ['valor'] = 8000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.cet.guardatransito", ['nome'] = "C.E.T", ['valor'] = 6000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.iaa", ['nome'] = "IAA", ['valor'] = 20000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.agente.iaa", ['nome'] = "IAA", ['valor'] = 15000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.corretor", ['nome'] = "Corretor", ['valor'] = 6000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.comandante.prf", ['nome'] = "Comandante [PRF]", ['valor'] = 30000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.agentees.prf", ['nome'] = "Agente Especial [PRF]", ['valor'] = 25000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.agentees1.prf", ['nome'] = "Agente Especial 1 classe [PRF]", ['valor'] = 18000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.agentees2.prf", ['nome'] = "Agente Especial 2 classe [PRF]", ['valor'] = 16000, ['tipo'] = 2 },
  { ['perm'] = "pagamento.agentees3.prf", ['nome'] = "Agente Especial 3 classe [PRF]", ['valor'] = 10000, ['tipo'] = 2 },
}

local salariosVIP = {
  { ['perm'] = "perm.prata", ['nome'] = "PRATA", ['valor'] = 4500 }, 
  { ['perm'] = "perm.ouro", ['nome'] = "OURO", ['valor'] = 6000 },
	{ ['perm'] = "perm.diamante", ['nome'] = "DIAMANTE", ['valor'] = 7500 },
  { ['perm'] = "perm.platina", ['nome'] = "PLATINA", ['valor'] = 10000 },
  { ['perm'] = "perm.esmeralda", ['nome'] = "ESMERALDA", ['valor'] = 15000 },
}

RegisterServerEvent('NZK:salarios')
AddEventHandler('NZK:salarios', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(user_id, v.perm) then
					TriggerClientEvent('chatMessage', source, 'SALARIO', { 226, 58, 58 }, '^0Você recebeu seu salario de(a) '..v.nome..' no valor de ^2'..v.valor..' ^0dólares.')  
					vRP.giveBankMoney(user_id, v.valor)
          TriggerClientEvent("vrp_sound:source",source,'paycheck',0.4)
          vRP.log("nzk_logs/player/salario.txt", "O [ID:"..user_id.."] recebeu o salario "..v.nome.." no valor de "..v.valor.." .")
 
          local propriedades = src.getUserAddress(user_id)
            if #propriedades >= 1 then
              local pagamentoProp = 500*#propriedades
              if vRP.tryFullPayment(user_id, pagamentoProp) then
                  TriggerClientEvent('chatMessage', source, '^2Você possui ^5'..#propriedades..' propriedade(s)^2 e pagou ^5 $ '..vRP.format(parseInt(pagamentoProp))..'^2 de impostos.')  
              end
            end
      end
		end
	end
end) 
 
RegisterServerEvent('NZK:salariosVIP')
AddEventHandler('NZK:salariosVIP', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(salariosVIP) do
			if vRP.hasPermission(user_id, v.perm) then
					vRP.giveBankMoney(user_id, parseInt(v.valor))
					TriggerClientEvent('chatMessage', source, 'SOCIO', { 226, 58, 58 }, '^0Você recebeu seu salario de socio '..v.nome..' no valor de ^2'..v.valor..' ^0dólares.')  
          TriggerClientEvent("vrp_sound:source",source,'paycheck',0.4) 
          vRP.log("nzk_logs/player/salarioVIP.txt", "O [ID:"..user_id.."] recebeu o salario "..v.nome.." no valor de "..v.valor.." .")
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONVIDAR & DEMITIR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local convidarOrgs = {
  { ['comando'] = "coronel", ['grupo'] = "Coronel [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "tenentecoronel", ['grupo'] = "Tenente Coronel [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "major", ['grupo'] = "Major [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "capitao", ['grupo'] = "Capitão [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "tenente", ['grupo'] = "Tenente [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "sargento", ['grupo'] = "Sargento [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "cabo", ['grupo'] = "Cabo [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "soldado", ['grupo'] = "Soldado [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "recruta", ['grupo'] = "Recruta [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "piloto", ['grupo'] = "Piloto [POLICIA]", ['grupolider'] = "Comandante [POLICIA]"},
  { ['comando'] = "delegado", ['grupo'] = "Delegado [CIVIL]", ['grupolider'] = "Comandante [CIVIL]"},
  { ['comando'] = "corregidor", ['grupo'] = "Corregedor [CIVIL]", ['grupolider'] = "Comandante [CIVIL]"}, 
  { ['comando'] = "investigador", ['grupo'] = "Investigador [CIVIL]", ['grupolider'] = "Comandante [CIVIL]"},
  { ['comando'] = "operador", ['grupo'] = "Operador [CIVIL]", ['grupolider'] = "Comandante [CIVIL]"},
  { ['comando'] = "agente", ['grupo'] = "Agente [CIVIL]", ['grupolider'] = "Comandante [CIVIL]"},
  { ['comando'] = "escrivao", ['grupo'] = "Escrivão [CIVIL]", ['grupolider'] = "Comandante [CIVIL]"},
  { ['comando'] = "piloto", ['grupo'] = "Piloto [CIVIL]", ['grupolider'] = "Comandante [CIVIL]"},
  { ['comando'] = "subdiretor", ['grupo'] = "Sub-diretor [HOSPITAL]", ['grupolider'] = "Diretor [HOSPITAL]"},
  { ['comando'] = "gestao", ['grupo'] = "Gestão [HOSPITAL]", ['grupolider'] = "Diretor [HOSPITAL]"},
  { ['comando'] = "medico", ['grupo'] = "Medico [HOSPITAL]", ['grupolider'] = "Diretor [HOSPITAL]"},
  { ['comando'] = "enfermeiro", ['grupo'] = "Enfermeiro [HOSPITAL]", ['grupolider'] = "Diretor [HOSPITAL]"},
  { ['comando'] = "psicologo", ['grupo'] = "Psicologo [HOSPITAL]", ['grupolider'] = "Diretor [HOSPITAL]"},
  { ['comando'] = "socorrista", ['grupo'] = "Socorrista [HOSPITAL]", ['grupolider'] = "Diretor [HOSPITAL]"},
  { ['comando'] = "juiz", ['grupo'] = "Juiz", ['grupolider'] = "Ministro"},
  { ['comando'] = "comandante", ['grupo'] = "Comandante [PRF]", ['grupolider'] = "Comandante [PRF]"},
  
  { ['comando'] = "promotor", ['grupo'] = "Promotor", ['grupolider'] = "Ministro"},
  { ['comando'] = "advogado", ['grupo'] = "Advogados", ['grupolider'] = "Ministro"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Diretor [NEWS]", ['grupolider'] = "Diretor [NEWS]"},
  { ['comando'] = "reporter", ['grupo'] = "Reporter [NEWS]", ['grupolider'] = "Diretor [NEWS]"},
  { ['comando'] = "camera", ['grupo'] = "Camera [NEWS]", ['grupolider'] = "Diretor [NEWS]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [VERMELHOS]", ['grupolider'] = "Lider [VERMELHOS]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [VERMELHOS]", ['grupolider'] = "Lider [VERMELHOS]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [ROSAS]", ['grupolider'] = "Lider [ROSAS]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [ROSAS]", ['grupolider'] = "Lider [ROSAS]"},

  { ['comando'] = "morador", ['grupo'] = "vinhedo", ['grupolider'] = "vinhedo"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [TCP]", ['grupolider'] = "Lider [TCP]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [TCP]", ['grupolider'] = "Lider [TCP]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [MILICIA]", ['grupolider'] = "Lider [MILICIA]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [MILICIA]", ['grupolider'] = "Lider [MILICIA]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [MAFIA]", ['grupolider'] = "Lider [MAFIA]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [MAFIA]", ['grupolider'] = "Lider [MAFIA]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [FBB]", ['grupolider'] = "Lider [FBB]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [FBB]", ['grupolider'] = "Lider [FBB]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [BAHAMAS]", ['grupolider'] = "Lider [BAHAMAS]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [BAHAMAS]", ['grupolider'] = "Lider [BAHAMAS]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [GALAXY]", ['grupolider'] = "Lider [GALAXY]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [GALAXY]", ['grupolider'] = "Lider [GALAXY]"},
 
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [CINZAS]", ['grupolider'] = "Lider [CINZAS]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [CINZAS]", ['grupolider'] = "Lider [CINZAS]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [MECANICO]", ['grupolider'] = "Lider [MECANICO]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [MECANICO]", ['grupolider'] = "Lider [MECANICO]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [LS CUSTOM]", ['grupolider'] = "Lider [LS CUSTOM]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [LS CUSTOM]", ['grupolider'] = "Lider [LS CUSTOM]"},

  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [DRIFTKING]", ['grupolider'] = "Lider [DRIFTKING]"},
  { ['comando'] = "membro", ['grupo'] = "Membro [DRIFTKING]", ['grupolider'] = "Lider [DRIFTKING]"},
  { ['comando'] = "tecnico", ['grupo'] = "Tecnico [DRIFTKING]", ['grupolider'] = "Lider [DRIFTKING]"},

  { ['comando'] = "superintendente", ['grupo'] = "Superintendente [CET]", ['grupolider'] = "Diretor [CET]"},
  { ['comando'] = "guarda", ['grupo'] = "Guarda [CET]", ['grupolider'] = "Diretor [CET]"},
  { ['comando'] = "guarda2", ['grupo'] = "Guarda de Transito [CET]", ['grupolider'] = "Diretor [CET]"},

  --FAVELAS

  { ['comando'] = "membro", ['grupo'] = "Membro [MACACO]", ['grupolider'] = "Lider [MACACO]"}, 
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [MACACO]", ['grupolider'] = "Lider [MACACO]"}, 

  { ['comando'] = "membro", ['grupo'] = "Membro [CORUJA]", ['grupolider'] = "Lider [CORUJA]"},
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [CORUJA]", ['grupolider'] = "Lider [CORUJA]"},

  { ['comando'] = "membro", ['grupo'] = "Membro [BOI]", ['grupolider'] = "Lider [BOI]"},
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [BOI]", ['grupolider'] = "Lider [BOI]"},

  { ['comando'] = "membro", ['grupo'] = "Membro [RATO]", ['grupolider'] = "Lider [RATO]"},
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [RATO]", ['grupolider'] = "Lider [RATO]"},

  { ['comando'] = "membro", ['grupo'] = "Membro [DIABO]", ['grupolider'] = "Lider [BIABO]"},
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [DIABO]", ['grupolider'] = "Lider [BIABO]"},
  
  { ['comando'] = "membro", ['grupo'] = "Membro [LOBO]", ['grupolider'] = "Lider [LOBO]"},
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [LOBO]", ['grupolider'] = "Lider [LOBO]"},

  { ['comando'] = "membro", ['grupo'] = "Membro [URSO]", ['grupolider'] = "Lider [URSO]"},
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [URSO]", ['grupolider'] = "Lider [URSO]"},

  { ['comando'] = "membro", ['grupo'] = "Membro [CAVALO]", ['grupolider'] = "Lider [CAVALO]"},
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [CAVALO]", ['grupolider'] = "Lider [CAVALO]"},

  { ['comando'] = "membro", ['grupo'] = "Membro [RAPOSA]", ['grupolider'] = "Lider [RAPOSA]"},
  { ['comando'] = "sub", ['grupo'] = "Sub-Lider [RAPOSA]", ['grupolider'] = "Lider [RAPOSA]"},
}

RegisterCommand('convidar', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			for k,v in pairs(convidarOrgs) do
				if vRP.hasGroup(user_id, v.grupolider) then
					if args[2] == v.comando then
						TriggerClientEvent('chatMessage', source, 'CONVIDAR', {28, 141, 1},"Você convidou o ^5[ID:"..args[1].."]^0 para ^5"..v.grupo.."^0. ")
						TriggerClientEvent('chatMessage', nplayer, 'CONVIDAR', {28, 141, 1},"Você foi convidado para o(a) ^5"..v.grupo.."^0 para aceitar aperte F5.")
						local ok = vRP.request(nplayer, "Você foi convidado para o(a) "..v.grupo.." deseja aceitar ?", 30)
						if ok then
							vRP.addUserGroup(parseInt(args[1]), v.grupo)
              TriggerClientEvent('chatMessage', source, 'CONVIDAR', {28, 141, 1},"O ^5[ID: "..args[1].."]^0 aceitou o convite.")
              vRP.log("nzk_logs/lider/convidar.txt", "O Lider [ID:"..user_id.." convidou o [ID:"..parseInt(args[1]).."] para "..v.grupo.." .")
						end
					end
				end
			end
		end
	end
end)

RegisterCommand('demitir', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			for k,v in pairs(convidarOrgs) do
				if vRP.hasGroup(user_id, v.grupolider) then
					if args[2] == v.comando then
						TriggerClientEvent('chatMessage', source, 'DEMITIR', {28, 141, 1},"Você convidou o ^5[ID:"..args[1].."]^0 para ^5"..v.grupo.."^0. ")
						local ok = vRP.request(source, "Você tem certeza que deseja demitir o [ID:"..args[1].."] ?", 30)
						if ok then
							vRP.removeUserGroup(parseInt(args[1]), v.grupo)
							TriggerClientEvent('chatMessage', source, 'DEMITIR', {28, 141, 1},"O ^5[ID: "..args[1].."]^0 foi demitido.")
              TriggerClientEvent('chatMessage', nplayer, 'DEMITIR', {28, 141, 1},"^9Você foi demitido.")
              vRP.log("nzk_logs/lider/demitir.txt", "O Lider [ID:"..user_id.." demitiu o [ID:"..parseInt(args[1]).."] do "..v.grupo.." .")
						end
					end
				end
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VER EM SERVICO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local checkPerm = {
  { ['grupoLider'] = "Comandante [POLICIA]", ['permPTR'] = "perm.policia.ptr"},
  { ['grupoLider'] = "Comandante [PTR]", ['permPTR'] = "perm.policia.ptr"},
  { ['grupoLider'] = "Comandante [CIVIL]", ['permPTR'] = "perm.pcivil.ptr"},
  { ['grupoLider'] = "Comandante [FPTR]", ['permPTR'] = "perm.pcivil.ptr"},
  { ['grupoLider'] = "Diretor [UNIZK]", ['permPTR'] = "perm.unizk.ptr"},
  { ['grupoLider'] = "Diretor [EXP]", ['permPTR'] = "perm.unizk.ptr"},
}

RegisterCommand('vserv', function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
    for y,z in ipairs(checkPerm) do
      if vRP.hasGroup(user_id,z.grupoLider) then
        local emServico = vRP.getUsersByPermission(z.permPTR)
        local oficiais_nomes = ""

        for k,v in ipairs(emServico) do
            local identity = vRP.getUserIdentity(parseInt(v))
            local org = vRP.getUserGroupByType(v,"org") if (org == nil or org == "") then org = "Nenhuma" end
            oficiais_nomes = oficiais_nomes .. "^2[ID: ^5" .. v .. "^2] [NOME: ^5" .. string.upper(identity.name) .. "^2] [SOBRENOME: ^5" .. string.upper(identity.firstname) .. "^2] [GRUPO: ^5"..org.."^2]"
        end

        if #emServico > 0 then
          TriggerClientEvent('chatMessage', source, oficiais_nomes)
        else
          TriggerClientEvent('chatMessage', source, "Ninguem em serviço no momento")
        end
      end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ADMINS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admins',function(source,args,rawCommand)
	local source = source 
	local user_id = vRP.getUserId(source)
		if user_id then
			local admin = vRP.getUsersByPermission("admin.permissao")
			local adminFEXP = vRP.getUsersByPermission("admin.exp")
			local mod = vRP.getUsersByPermission("moderador.permissao")
			local modFEXP = vRP.getUsersByPermission("moderador.exp")
			local ajd = vRP.getUsersByPermission("ajudante.permissao")
      local ajdFEXP = vRP.getUsersByPermission("ajudante.exp")
      
			TriggerClientEvent('chatMessage', source, '^2Total de Admins Online: ^2(^5'..#admin..'^2 / ^9'..#adminFEXP..'^2) ')
			TriggerClientEvent('chatMessage', source, '^2Total de Moderadores Online: ^2(^5'..#mod..'^2 / ^9'..#modFEXP..'^2) ')
      TriggerClientEvent('chatMessage', source, '^2Total de Ajudantes Online: ^2(^5'..#ajd..'^2 / ^9'..#ajdFEXP..'^2) ')
		end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VERID
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRPplayerC.checkId() 
  local source = source
  local user_id = vRP.getUserId(source)
  local nplayer = vRPclient.getNearestPlayer(source,10)
	local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
      TriggerClientEvent("chatMessage", source, "^9ID Próximo: ^5"..nuser_id)
      TriggerClientEvent("chatMessage", nplayer, "^9O [ID:"..user_id.."] acabou de ver seu id.")
    else
      TriggerClientEvent('chatMessage', source,"^2Nenhum jogador proximo.")
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MORTO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRPplayerC.checkMorto() 
  local source = source
  local user_id = vRP.getUserId(source)
  local nplayer = vRPclient.getNearestPlayer(source,10)
  local nuser_id = vRP.getUserId(nplayer)
  local pulso = math.random(1,100)
    if nplayer then
    else
      TriggerClientEvent('chatMessage', source,"^2Nenhum jogador proximo.")
    end
    if pulso > 50 then
      TriggerClientEvent("chatMessage", source, ""..pulso.."",{0,255,0},"bpm [ID: "..nuser_id.."]" )
  end
  if pulso < 50 then
  TriggerClientEvent("chatMessage", source, ""..pulso.."",{255,0,0},"bpm [ID: "..nuser_id.."]" )
  end
  if pulso > 50 then
    TriggerClientEvent("chatMessage", nplayer,"192",{0,255,0}, "^9:  O Medico está checando seu pulso: "..pulso.." bpm [ID: "..user_id.."]" ) 
  end
  if pulso < 50 then
    TriggerClientEvent("chatMessage", nplayer,"192",{255,0,0}, "^9:  O Medico está checando seu pulso: "..pulso.." bpm [ID: "..user_id.."]" ) 
  end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAMAR ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chamaradm', function(source, args, rawCommand)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local desc = vRP.prompt(source,"Descreva seu problema:","")
      if desc then
        local admin = vRP.getUsersByPermission("ticket.permissao")
        for l,w in pairs(admin) do 
          local player = vRP.getUserSource(parseInt(w))
          if player then
            async(function()
              vRPclient.playSound(player,"Event_Message_Purple","GTAO_FM_Events_Soundset")
              TriggerClientEvent('chatMessage', player,"ADMIN",{255,0,0},"^6O (ID: ^5"..user_id.."^6) chamou admin pelo (MOTIVO: ^5"..desc.."^6).")
              vRP.log("nzk_logs/player/chamaradm.txt", "O ID [ID:"..user_id.." chamou admin pelo motivo "..desc..".")
            end)
          end
        end
      end
  end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MASCARA ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPplayerC.maskItem() 
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    if vRP.getInventoryItemAmount(user_id, "mascara") >= 1 then
      return true
    end
  end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK MONSTER MENU
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPplayerC.checkmonstermenu()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.log("nzk_logs/anticheat/checkmonster.txt","O [ID:"..user_id.."] Esta Suspeito.")
  end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPplayerC.vTuning()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    if vRP.hasPermission(user_id, "perm.mecanico") then
      return true
    end
  end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPplayerC.pagarMulta(valor)
  local user_id = vRP.getUserId(source)
  local multas = vRP.getUData(user_id,"vRP:multas")
  local multasValor = json.decode(multas) or 0
  if multasValor ~= nil or multasValor == 0 then
    vRP.setUData(user_id,"vRP:multas",multasValor+valor)
  end
end 

function vRPplayerC.checarOrgs()
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"perm.policia.civil") or vRP.hasPermission(user_id,"perm.unizk") or vRP.hasPermission(user_id,"perm.cet") then
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
local anuncioS = {
	{ ['background'] = 'rgba(120, 203, 255,0.8);', ['anunciadoPor'] = "Enviado pela Policia", ['permissao'] = "perm.policia" }, 
	{ ['background'] = 'rgba(237, 38, 12,0.8);', ['anunciadoPor'] = "Enviado pela Mecânica", ['permissao'] = "perm.mecanico" },
	{ ['background'] = 'rgba(140, 245, 187,0.8);', ['anunciadoPor'] = "Enviado pelo Hospital", ['permissao'] = "perm.unizk" },
	{ ['background'] = 'rgba(107, 35, 142,0.8);', ['anunciadoPor'] = "Enviado pelo Judiciário", ['permissao'] = "perm.ministro" },

}

RegisterCommand('anunciar2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	for k,v in pairs(anuncioS) do
    if vRP.hasPermission(user_id, v.permissao) then
      
      local mensagem = vRP.prompt(source,"Mensagem:","")
      if mensagem == "" then
        return
      end
      vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: "..v.background.." font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 40%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>"..v.anunciadoPor.."")
      SetTimeout(15*1000,function() vRPclient.removeDiv(-1,"anuncio") end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ORTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('orto',function(source,args,rawCommand)
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "perm.unizk") then
    if user_id then
      local nplayers = vRPclient.getNearestPlayers(source,15)
      if nplayers then
        local user_list = "" for k,v in pairs(nplayers) do user_list = user_list .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | " end
        if user_list ~= "" then

          local target_id = vRP.prompt(source,"Jogadores Proximo: "..user_list,"")
          if target_id ~= nil and target_id ~= "" then 
            local target = vRP.getUserSource(tonumber(target_id))
            local ortoTypes = vRP.prompt(source, "Escolha um numero:", "1- Gesso na cabeça\n2- Gesso na perna\n3- Gesso no peito\n4- Gesso No Pe")
            if tonumber(ortoTypes) ~= nil then
			
              if tonumber(ortoTypes) == 1 then
                print("FOI")
                -- PARTE | DEFINICAO | COR | SEXO | PROP
                TriggerClientEvent('NZK:ORTO', target, 1, 48, 0, 1, 1) -- HOMEM (PARTE DO CORPO,CUSTOMIZACAO,COR, SEXO)
                TriggerClientEvent('NZK:ORTO', target, 1, 48, 0, 2, 1) -- MULHER (PARTE DO CORPO,CUSTOMIZACAO,COR, SEXO)
              elseif tonumber(ortoTypes) == 2 then
                TriggerClientEvent('NZK:ORTO', target, 4, 84, 9, 1, 0) -- HOMEM (PARTE DO CORPO,CUSTOMIZACAO,COR, SEXO)
                TriggerClientEvent('NZK:ORTO', target, 4, 86, 9, 2, 0) -- MULHER (PARTE DO CORPO,CUSTOMIZACAO,COR, SEXO)
              elseif tonumber(ortoTypes) == 3 then
                TriggerClientEvent('NZK:ORTO', target, 11, 186, 9, 1, 0) -- HOMEM (PARTE DO CORPO,CUSTOMIZACAO,COR, SEXO)
                TriggerClientEvent('NZK:ORTO', target, 11, 188, 9, 2, 0) -- MULHER (PARTE DO CORPO,CUSTOMIZACAO,COR, SEXO)
              elseif tonumber(ortoTypes) == 4 then
                TriggerClientEvent('NZK:ORTO', target, 6, 87, 17, 1, 0) -- HOMEM (PARTE DO CORPO,CUSTOMIZACAO,COR, SEXO)

                TriggerClientEvent('NZK:ORTO', target, 6, 91, 17, 2, 0) -- MULHER (PARTE DO CORPO,CUSTOMIZACAO,COR, SEXO)
              else
                TriggerClientEvent('chatMessage', source, '^2Digite o valor corretamente 1-3.')
              end
			  
            end
          else
            TriggerClientEvent('chatMessage', source, '^2Digite Corretamente.')
          end
      else
        TriggerClientEvent('chatMessage', source, '^2Nenhum jogador proximo.')
        end
      end
    end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/update_user_first_spawn","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")

RegisterServerEvent("NZK:changename")
AddEventHandler("NZK:changename",function(characterNome,characterSobrenome,characterAge)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if checkregister() then
			vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, firstname = characterSobrenome, name = characterNome, age = characterAge })
      TriggerClientEvent('chatMessage', source, '^2Nome alterado para '..characterNome..' '..characterSobrenome)
      TriggerClientEvent('chatMessage', source, '^2Você não pagou por isso."')
		elseif vRP.tryFullPayment(user_id,1000000) then
      vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, firstname = characterSobrenome, name = characterNome, age = characterAge })
      TriggerClientEvent('chatMessage', source, '^2Nome alterado para '..characterNome..' '..characterSobrenome)
    else
      TriggerClientEvent('chatMessage', source, '^9Você não possui dinheiro.')
		end	
	end
end)

function checkregister()
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if identity.name == "" and identity.firstname == "" then
		return true
	elseif identity.name == "Individuo" and identity.firstname == "Indigente" then
		return true
	else
		return false
	end		
end	
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO DE FESTINHA 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('festinha',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"event.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
        local identity = vRP.getUserIdentity(user_id)
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
        TriggerClientEvent("vrp_sound:source",-1,"poc",0.1)
        vRPclient.setDiv(-1,"festinha"," @keyframes blinking {    0%{ background-color: #ff3d50; border: 2px solid #871924; opacity: 0.8; } 25%{ background-color: #d22d99; border: 2px solid #901f69; opacity: 0.8; } 50%{ background-color: #55d66b; border: 2px solid #126620; opacity: 0.8; } 75%{ background-color: #22e5e0; border: 2px solid #15928f; opacity: 0.8; } 100%{ background-color: #222291; border: 2px solid #6565f2; opacity: 0.8; }  } .div_festinha { font-size: 11px; font-family: arial; color: rgba(255, 255, 255,1); padding: 20px; bottom: 10%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; animation: blinking 1s infinite; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Festeiro(a): "..identity.name.." "..identity.firstname)
        SetTimeout(10000,function()
            vRPclient.removeDiv(-1,"festinha")
        end)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESBUGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bvida',function(source,rawCommand)
	local user_id = vRP.getUserId(source)		
		vRPclient._setCustomization(source,vRPclient.getCustomization(source))
		vRP.removeCloak(source)			
end)

  RegisterCommand('cr',function(source,args)
  local user_id = vRP.getUserId(source)
  local source = vRP.getUserSource(user_id)
	if source then
		local data = vRP.getUData(user_id,"vRP:spawnController")
    local sdata = json.decode(data) or 0

		if sdata == 2 then
			local data2 = vRP.getUData(user_id,"currentCharacterMode")
			local custom = json.decode(data2) or 0
      
			if custom ~= nil then
				vRPclient.updateRosto(source, custom)
			end

		end
	end
end) 

