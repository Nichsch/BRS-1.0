local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
--------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE EXPEDIENTE
--------------------------------------------------------------------------------------------------------------------------------------------------
local aExpediente = {  
	{ ['grupo1'] = "admin", ['grupo2'] = "admin [EXP]"},
	{ ['grupo1'] = "moderador", ['grupo2'] = "moderador [EXP]"},
	{ ['grupo1'] = "ajudante", ['grupo2'] = "ajudante [EXP]"}
}

RegisterCommand('exp',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(aExpediente) do
			if args[1] == "entrar" then
				if vRP.hasGroup(user_id, v.grupo2) then
					vRP.addUserGroup(user_id, v.grupo1)
					TriggerClientEvent('chatMessage', -1, '^2O ^2'..string.upper(v.grupo1)..' '.. GetPlayerName(source).. ' ('..user_id..')^2 acabou de entrar em expediente.')
					vRP.log("nzk_logs/admin/expediente.txt", "O Admin [ID: "..user_id.."] entrou em expediente.")
				end
			elseif args[1] == "sair" then
				if vRP.hasGroup(user_id, v.grupo1) then
					vRP.addUserGroup(user_id, v.grupo2)
					TriggerClientEvent('chatMessage', -1, '^2O ^2'..string.upper(v.grupo1)..'^5 '.. GetPlayerName(source).. ' ('..user_id..')^2 acabou de sair de expediente.')
					vRP.log("nzk_logs/admin/expediente.txt", "O Admin [ID: "..user_id.."] saiu de expediente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEGARIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pegarip',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local tplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] and tplayer then
        TriggerClientEvent('chatMessage',source,"^1IP do Usuário: "..GetPlayerEndpoint(tplayer))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADICIONAR CARRO NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cnitro',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if tonumber(args[1]) then
			vRP.execute("vRP/add_vehicle",{ user_id = tonumber(args[1]), vehicle = "r1250" })
			TriggerClientEvent('chatMessage', source, '^5O Você deu o veiculo nitro para o [ID: '..args[1]..']')
			vRP.log("nzk_logs/admin/carnitro.txt", "O Admin [ID: "..user_id.."] deu o veiculo nitro para o [ID: "..args[1].."]")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VROUPAS ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
RegisterCommand('vroupas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local custom = vRPclient.getCustomization(source)
	
    if vRP.hasPermission(user_id,"ticket.permissao") or vRP.hasPermission(user_id,"perm.user") or vRP.hasPermission(user_id,"perm.policia") or vRP.hasPermission(user_id,"perm.civil") then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
			local content = ""
			
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br/>" 
            end

            player_customs[source] = true
            vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 4px; width: 250px; margin-top: 200px; margin-right: 50px; background: rgba(15,15,15,0.7); color: #ffff; font-weight: bold; }",content)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"perm.mecanico") or vRP.hasPermission(user_id,"ajudante.permissao") or vRP.hasPermission(user_id,"perm.cet") or vRP.hasPermission(user_id,"perm.policia") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('deletarveiculo',source,vehicle)
			vRP.log("nzk_logs/player/dv.txt", "O [ID: "..user_id.."] usou o comando /dv")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteveh")
AddEventHandler("trydeleteveh",function(index)
	TriggerClientEvent("syncdeleteveh",-1,index)
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STATUS
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status',function(source,args,rawCommand)
    local onlinePlayers = GetNumPlayerIndices()
    local policia = vRP.getUsersByPermission("perm.policia")
    local paramedico = vRP.getUsersByPermission("perm.unizk")
	local mec = vRP.getUsersByPermission("perm.mecanico")
	local staff = vRP.getUsersByPermission("chat.permissao")
	local ilegal = vRP.getUsersByPermission("ilegal.permissao")
	local user_id = vRP.getUserId(source)        
		TriggerClientEvent("Notify",source,"importante","<bold><b>Jogadores</b>: <b>"..onlinePlayers.."<br>Administração</b>: <b>"..#staff.."<br>Policiais</b>: <b>"..#policia.."<br>Ilegal</b>: <b>"..#ilegal.."<br>Paramédicos</b>: <b>"..#paramedico.."<br>Mecânicos</b> em serviço: <b>"..#mec.."</b></bold>.",9000)
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
AddEventHandler("trydeleteped",function(index)
	TriggerClientEvent("syncdeleteped",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
	TriggerClientEvent("syncdeleteobj",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE PRISAO ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('prenderadm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
	local idPlayer = vRP.prompt(source, "Digite o ID:", "")
		if tonumber(idPlayer) then
			local nplayer = vRP.getUserSource(tonumber(idPlayer))
			local tempoPrisao = vRP.prompt(source, "Digite o tempo da prisão", "")
			if tonumber(tempoPrisao) then
				local motivoPrisao = vRP.prompt(source, "Digite o motivo da prisão", "")
				if motivoPrisao ~= nil and motivoPrisao ~= "" then
					TriggerClientEvent('chatMessage', -1, 'PRISÃO ADM', { 0, 0, 0 }, '^0 O ^3'.. GetPlayerName(nplayer) ..' ^0 foi preso(a) por ^3'.. tonumber(tempoPrisao) ..' ^0minutos ^0 pelo motivo: ^3 '.. motivoPrisao)
					TriggerClientEvent('chatMessage', nplayer, 'PRISÃO ADM', { 0, 0, 0 }, '^0Você foi preso pelo admin: ^2'..GetPlayerName(source)..' ('..user_id..')^0.')
					vRPclient.teleport(nplayer, 1641.54,2570.48,45.56)
					prison_lock_adm(tonumber(idPlayer))
					TriggerClientEvent('prisaoADM',nplayer,true)
					vRP.log("nzk_logs/admin/prisaoadm.txt", "O Admin [ID: "..user_id.."] prendeu o [ID: "..tonumber(idPlayer).."] por ".. tonumber(tempoPrisao) .."m pelo motivo de:" ..motivoPrisao)
					vRP.setUData(tonumber(idPlayer),"vRP:prisao:ADM", json.encode(tonumber(tempoPrisao)))
				else
					TriggerClientEvent('chatMessage', source, '^2Digite o Motivo Corretamente.')
				end
			else
				TriggerClientEvent('chatMessage', source, '^2Digite o Tempo da Prisao Corretamente.')
			end
		else
			TriggerClientEvent('chatMessage', source, '^2Digite o ID Do player Corretamente.')
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DESFINALIZAR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('fnoff', function(source)
	local user_id = vRP.getUserId(source)
	  if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(source,5)
		  if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
				if vRPclient.isInComa(nplayer) then
				TriggerClientEvent('chatMessage', source,"^2Você removeu a finalizacao do [ID: "..nuser_id.."]")
				TriggerClientEvent('chatMessage', nplayer,"^2Você nao esta mais finalizado.")
				TriggerClientEvent("nzk:finalizado",nplayer, false)
				end
			end
		  end
	  end
end) ]]
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO ADM
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local player = vRP.getUserSource(parseInt(user_id))
	if player then
		SetTimeout(30000,function()
			local value = vRP.getUData(parseInt(user_id),"vRP:prisao:ADM")
			local tempo = json.decode(value) or 0
				if tonumber(tempo) > 0 then
					TriggerClientEvent('prisaoADM',player,true)
					vRPclient.teleport(player, 1641.54,2570.48,45.56)
					prison_lock_adm(parseInt(user_id))
				end
		end) 
	end
end)

function prison_lock_adm(target_id)
	local player = vRP.getUserSource(parseInt(target_id))
	if player then
		SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(target_id),"vRP:prisao:ADM")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent('chatMessage', player, 'PRISAO ADM', { 0, 0, 0 }, '^2Você Ainda vai passar ^5'..parseInt(tempo)..'^2m preso.')
				vRP.setUData(parseInt(target_id),"vRP:prisao:ADM",json.encode(parseInt(tempo)-1))
				prison_lock_adm(parseInt(target_id))
				vRP.addUserGroup(parseInt(target_id), "NSalario")
				vRPclient.setHealth(player,300)
				vRP.setHunger(parseInt(target_id), 0)
				vRP.setThirst(parseInt(target_id), 0)
			elseif parseInt(tempo) == 0  or parseInt(tempo) == -1 then
				vRP.removeUserGroup(parseInt(target_id), "NSalario")
				TriggerClientEvent('prisaoADM',player,false)
				vRPclient.teleport(player, -1038.07,-2738.83,13.81)
				vRP.setUData(parseInt(target_id),"vRP:prisao:ADM",json.encode(-1))
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Mudar Sexo
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mudarsexo',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then

		if args[1] and args[2] then

		if parseInt(args[2]) == 1 then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				local idle_copy = { model = "mp_m_freemode_01" }
				for i=0,19 do
					idle_copy[i] = {0,0}
				end
				vRPclient.setCustomization(nplayer,idle_copy)
			end
		end

		if parseInt(args[2]) == 2 then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					local idle_copy = { model = "mp_f_freemode_01" }
					for i=0,19 do
						idle_copy[i] = {0,0}
					end
					vRPclient.setCustomization(nplayer,idle_copy)
				end
			end

		else
			TriggerClientEvent('chatMessage', source, "USE: /mudarsexo [ID] [1-2] (1 PARA HOMEM, 2 PARA MULHER)", {0, 170, 255})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('reparar',source,vehicle)
			vRP.log("nzk_logs/admin/fix.txt", "O Admin [ID: "..user_id.."] usou o comando /fix")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent("syncarea",-1,x,y,z)
		vRP.log("nzk_logs/admin/limparea.txt", "O Admin [ID: "..user_id.."] usou o comando /limparea")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Limpar Inventario
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearinv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
			vRP.clearInventory(parseInt(args[1]))
			end
		else
			vRP.clearInventory(parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('darxp',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
			vRP._varyExp(parseInt(args[1]),"physical","strength",1900) 
			end
		else
			vRP._varyExp(parseInt(args[1]),"physical","strength",1900) 
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('re',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,300)
				vRP.log("nzk_logs/admin/revive.txt", "O Admin [ID: "..user_id.."] usou o comando /re no [ID: "..parseInt(args[1]).."]")
			end
		else
			vRPclient.killGod(source)
			vRPclient.setHealth(source,300)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pmodel',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
		local pmodel = vRP.prompt(source, "Digite o Modelo", "")
		if pmodel ~= nil then
			local idle_copy = { model = pmodel }
			for i=0,19 do
				idle_copy[i] = {0,0}
			end
			vRPclient._setCustomization(source, idle_copy)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cuff',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.toggleHandcuff(nplayer)
				vRP.log("nzk_logs/admin/cuff.txt", "O Admin [ID: "..user_id.."] usou o comando /cuff no [ID: "..parseInt(args[1]).."]")
			end
		else
			vRPclient.toggleHandcuff(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KILL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kill',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setHealth(nplayer, 0)
				SetTimeout(1000, function()
					vRPclient.killComa(nplayer)
				end)
				vRP.log("nzk_logs/admin/kill.txt", "O Admin [ID: "..user_id.."] usou o comando /cuff no [ID: "..parseInt(args[1]).."]")
			end
		else
			vRPclient.setHealth(source, 0)
			SetTimeout(1000, function()
				vRPclient.killComa(source)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Zerar fome e sede
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('zerarnec',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRP.setHunger(parseInt(args[1]), 0)
				vRP.setThirst(parseInt(args[1]), 0)
				vRP.log("nzk_logs/admin/zerarnec.txt", "O Admin [ID: "..user_id.."] usou o comando /zerarnec no [ID: "..parseInt(args[1]).."]")
			end
		else 
			vRP.setHunger(user_id, 0)
			vRP.setThirst(user_id, 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('parall', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("nzk:giveParachute", -1)
			vRP.log("nzk_logs/admin/parall.txt", "O Admin [ID: "..user_id.."] usou o comando /parall")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('aa', function(source, args, raw)
	local text = string.sub(raw, 4)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"admin.permissao") then
			local admin = vRP.getUsersByPermission("admin.permissao")
			for l,w in pairs(admin) do
				local player = vRP.getUserSource(parseInt(w))
				vRPclient.playSound(player,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent('chatMessage', player, 'ADMIN CHAT',{0,255,0}, '^2('..user_id..') diz:  '..text)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpall', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"admin.permissao") then
			local x,y,z = vRPclient.getPosition(player,{})
				TriggerClientEvent("nzk:tpall", -1, x, y, z)
				vRP.log("nzk_logs/admin/tpall.txt", "O Admin [ID: "..user_id.."] usou o comando /tpall")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ReviveALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reviveall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
			vRPclient.setHealth(rsource,300)
			vRP.log("nzk_logs/admin/reviveall.txt", "O Admin [ID: "..user_id.."] usou o comando /reviveall")
        end
    end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- garmasALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('garmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
	  if not vRP.hasPermission(user_id, "perm.policia.civil") then
		local ok = vRP.request(source, "Você deseja guardar suas armas?",30)
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
-- REMOVER DETENCAO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rdet', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"admin.permissao") then
			if tonumber(args[1]) and args[2] then
				vRP.execute("vRP/set_detido",{ user_id = tonumber(args[1]), vehicle = args[2], detido = 0})
				TriggerClientEvent('chatMessage', source, '^2Você removeu o veiculo '..args[2]..' do [ID: '..tonumber(args[1])..'] da detencao/retencao.')
				vRP.log("nzk_logs/admin/rdetencao.txt", "O Admin [ID: "..user_id.."] removeu o veiculo "..args[2].." do [ID:"..args[1].."]. ")
			end
		end
	end
end) 

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('spec', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
			if tonumber(args[1]) == 0 or tonumber(args[1]) == user_id then
				vRPclient.stopSpec(source)
			else
				local nplayer = vRP.getUserSource(tonumber(args[1]))
				if nplayer then
					vRPclient.toggleSpec(source, nplayer)
					vRP.log("nzk_logs/admin/spec.txt", "O Admin [ID: "..user_id.."] usou o spec no [ID: "..tonumber(args[1]).."] ")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Deleta todos Carros
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearallveh', function(source, args, rawCommand) 
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent('chatMessage', -1, "^1ADMIN: ^0Contagem Iniciada ^260s^0 para limpeza de veiculos. (Entre em seu veiculo para não ser removido)")
			Wait(60000)
			TriggerClientEvent("wld:delallveh", -1) 
			vRP.log("nzk_logs/admin/clearallveh.txt", "O Admin [ID: "..user_id.."] usou o comando /clearallveh")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('vehash',source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('vehtuning',source,vehicle)
			vRP.log("nzk_logs/admin/tuning.txt", "O Admin [ID: "..user_id.."] usou o comando /tuning")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wladd',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),true)
			vRP.log("nzk_logs/admin/wladd.txt", "O Admin [ID: "..user_id.."] adicionou o [ID: "..parseInt(args[1]).."] na whitelist.")
		end
	end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wlrem',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
			vRP.log("nzk_logs/admin/wlrem.txt", "O Admin [ID: "..user_id.."] removeu o [ID: "..parseInt(args[1]).."] na whitelist.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVE ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] then
			vRP.giveInventoryItem(user_id,""..args[1].."",parseInt(args[2]))
			vRP.log("nzk_logs/admin/item.txt", "O Admin [ID: "..user_id.."] givou o item "..args[1].." "..parseInt(args[2]).."x")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local text = string.sub(rawCommand, 4)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"EXPULSO: "..text)
				vRP.log("nzk_logs/admin/kick.txt", "O Admin [ID: "..user_id.."] kickou o [ID:"..parseInt(args[1]).."] pelo motivo: "..text.."")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local text = string.sub(rawCommand, 4)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
		if args[1] and text then
					local id = vRP.getUserSource(parseInt(args[1]))
					if id then
						vRP.setBanned(parseInt(args[1]),true)
						vRP.kick(parseInt(args[1]),"Banido: "..text)
						vRP.log("nzk_logs/admin/ban.txt", "O Admin [ID: "..user_id.."] baniu o [ID:"..parseInt(args[1]).."] pelo motivo: "..text.."")
					end
				end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),false)
			vRP.log("nzk_logs/admin/unban.txt", "O Admin [ID: "..user_id.."] desbaniu o [ID:"..parseInt(args[1]).."]")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVE ITEM PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('itemp',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] and args[3] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				TriggerClientEvent('chatMessage', source, "(ID: "..parseInt(args[1])..") Você givou o Item: "..args[2].." "..parseInt(args[3]).."x", {0, 170, 255})
				vRP.giveInventoryItem(parseInt(args[1]),""..args[2].."",parseInt(args[3]))
				vRP.log("nzk_logs/admin/itemp.txt", "O Admin [ID: "..user_id.."] givou o item "..args[2].." "..parseInt(args[3]).."x para o [ID:"..parseInt(args[1]).."].")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVE ARMOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setArmour(nplayer, 100)
				vRP.log("nzk_logs/admin/colete.txt", "O Admin [ID: "..user_id.."] usou o comando /colete para o [ID: "..parseInt(args[1]).."]")
			end
		else
			vRPclient.setArmour(source, 100)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			vRP.giveMoney(user_id,parseInt(args[1]))
			vRP.log("nzk_logs/admin/money.txt", "O Admin [ID: "..user_id.."] givou [ID:"..parseInt(args[1]).."] de dinheiro.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
		vRPclient.toggleNoclip(source)
		vRP.log("nzk_logs/admin/nc.txt", "O Admin [ID: "..user_id.." usou o /nc")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
		vRP.log("nzk_logs/admin/tpcds.txt", "O Admin [ID: "..user_id.."] teleportou para "..fcoords.." ")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COORDENADAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		heading = GetEntityHeading(GetPlayerPed(-1))
		vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
	end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:",tD(x)..","..tD(y)..","..tD(z))
	end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"moderador.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:","{x="..tD(x)..", y="..tD(y)..", z="..tD(z).."},")
	end
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blips',function(source,args)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ticket.permissao") then
		TriggerClientEvent("NZK:showBlips", source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('debug', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("NZK:ToggleDebug", player)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('groupadd',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] then
			vRP.addUserGroup(parseInt(args[1]),args[2])
			vRP.log("nzk_logs/admin/groupadd.txt", "O Admin [ID: "..user_id.." ativou o vip "..args[2].." para o [ID: "..parseInt(args[1]).."]")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
RegisterCommand('display',function(source,args,rawCommand)
	local custom = vRPclient.getCustomization(source,{})
	if custom then
		if player_customs[source] then
			player_customs[source] = nil
			vRPclient._removeDiv(source,"customization")
		else
			local content = ""
			for k,v in pairs(custom) do
				content = content..k.." => "..json.encode(v).."<br />" 
			end

			player_customs[source] = true
			vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ", content)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('grouprem',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] then
			vRP.removeUserGroup(parseInt(args[1]),args[2])
			vRP.log("nzk_logs/admin/grouprem.txt", "O Admin [ID: "..user_id.." ativou o vip "..args[2].." para o [ID: "..parseInt(args[1]).."]")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
				vRP.log("nzk_logs/admin/tptome.txt", "O Admin [ID: "..user_id.." puxou o id [ID: "..args[1].."] ")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"ajudante.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
				vRP.log("nzk_logs/admin/tpto.txt", "O Admin [ID: "..user_id.." teleportou para id [ID: "..parseInt(args[1]).."] ")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('tptoway',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('spawn',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			TriggerClientEvent('spawnarveiculo',source,args[1])
			vRP.log("nzk_logs/admin/spawncar.txt", "O Admin [ID: "..user_id.." spawnou o veiculo "..args[1].." ")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('delnpcs',source)
		vRP.log("nzk_logs/admin/delnpcs.txt", "O Admin [ID: "..user_id.." deletou os npcs.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('aadm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 40%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: Administrador")
		vRP.log("nzk_logs/admin/aadm.txt", "O Admin [ID: "..user_id.." escreveu "..mensagem.."")
		SetTimeout(30000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)