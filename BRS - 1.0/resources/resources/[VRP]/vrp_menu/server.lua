local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPmenuC = {}
Tunnel.bindInterface("vrp_menu",vRPmenuC)
Proxy.addInterface("vrp_menu",vRPmenuC)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	local player = source
-- POLICIA
	if vRP.hasGroup(user_id, "Comandante [PTR]") then
		vRP.addUserGroup(user_id,"Comandante [POLICIA]")
	elseif vRP.hasGroup(user_id, "Coronel [PTR]") then
		vRP.addUserGroup(user_id,"Coronel [POLICIA]")
	elseif vRP.hasGroup(user_id, "Tenente Coronel [PTR]") then
		vRP.addUserGroup(user_id,"Tenente Coronel [POLICIA]")
	elseif vRP.hasGroup(user_id, "Major [PTR]") then
		vRP.addUserGroup(user_id,"Major [POLICIA]")
	elseif vRP.hasGroup(user_id, "Capitão [PTR]") then
		vRP.addUserGroup(user_id,"Capitão [POLICIA]")
	elseif vRP.hasGroup(user_id, "Tenente [PTR]") then
		vRP.addUserGroup(user_id,"Tenente [POLICIA]")
	elseif vRP.hasGroup(user_id, "Sargento [PTR]") then
		vRP.addUserGroup(user_id,"Sargento [POLICIA]")
	elseif vRP.hasGroup(user_id, "Cabo [PTR]") then
		vRP.addUserGroup(user_id,"Cabo [POLICIA]")
	elseif vRP.hasGroup(user_id, "Soldado [PTR]") then
		vRP.addUserGroup(user_id,"Soldado [POLICIA]")
	elseif vRP.hasGroup(user_id, "Recruta [PTR]") then
		vRP.addUserGroup(user_id,"Recruta [POLICIA]")
	elseif vRP.hasGroup(user_id, "Piloto [PTR]") then
		vRP.addUserGroup(user_id,"Piloto [POLICIA]")
-- POLICIA CIVIL
	elseif vRP.hasGroup(user_id, "Comandante [CPTR]") then
		vRP.addUserGroup(user_id,"Comandante [CIVIL]")
	elseif vRP.hasGroup(user_id, "Delegado [CPTR]") then
		vRP.addUserGroup(user_id,"Delegado [CIVIL]")
	elseif vRP.hasGroup(user_id, "Corregedor [CPTR]") then
		vRP.addUserGroup(user_id,"Corregedor [CIVIL]")
	elseif vRP.hasGroup(user_id, "Investigador [CPTR]") then
		vRP.addUserGroup(user_id,"Investigador [CIVIL]")
	elseif vRP.hasGroup(user_id, "Operador [CPTR]") then
		vRP.addUserGroup(user_id,"Operador [CIVIL]")
	elseif vRP.hasGroup(user_id, "Agente [CPTR]") then
		vRP.addUserGroup(user_id,"Agente [CIVIL]")
	elseif vRP.hasGroup(user_id, "Escrivão [CPTR]") then
		vRP.addUserGroup(user_id,"Escrivão [CIVIL]")
	elseif vRP.hasGroup(user_id, "Piloto [CPTR]") then
		vRP.addUserGroup(user_id,"Piloto [CIVIL]")
-- POLICIA RODOVIARIA TALKEY
elseif vRP.hasGroup(user_id, "Comandante [PRFPTR]") then
	vRP.addUserGroup(user_id,"Comandante [PRF]")
elseif vRP.hasGroup(user_id, "Agente Especial [PRFPTR]") then
	vRP.addUserGroup(user_id,"Agente Especial [PRF]")
elseif vRP.hasGroup(user_id, "Agente 1 Classe [PRFPTR]") then
	vRP.addUserGroup(user_id,"Agente 1 Classe [PRF]")
elseif vRP.hasGroup(user_id, "Agente 2 Classe [PRFPTR]") then
	vRP.addUserGroup(user_id,"Agente 2 Classe [PRF]")
elseif vRP.hasGroup(user_id, "Agente 3 Classe [PRFPTR]") then
	vRP.addUserGroup(user_id,"Agente 3 Classe [PRF]")
-- unizk
	elseif vRP.hasGroup(user_id, "Diretor [EXP]") then
		vRP.addUserGroup(user_id,"Diretor [UNIZK]")
	elseif vRP.hasGroup(user_id, "Sub-diretor [EXP]") then
		vRP.addUserGroup(user_id,"Sub-diretor [UNIZK]")
	elseif vRP.hasGroup(user_id, "Gestão [EXP]") then
		vRP.addUserGroup(user_id,"Gestão [UNIZK]")
	elseif vRP.hasGroup(user_id, "Medico [EXP]") then
		vRP.addUserGroup(user_id,"Medico [UNIZK]")
	elseif vRP.hasGroup(user_id, "Enfermeiro [EXP]") then
		vRP.addUserGroup(user_id,"Enfermeiro [UNIZK]")
	elseif vRP.hasGroup(user_id, "Psicologo [EXP]") then
		vRP.addUserGroup(user_id,"Psicologo [UNIZK]")
	elseif vRP.hasGroup(user_id, "Socorrista [EXP]") then
		vRP.addUserGroup(user_id,"Socorrista [UNIZK]")
	end
-- Checagem do VIP
	--[[ SetTimeout(1*1000,function()
		local consultarVip = vRP.getUData(user_id,"vRP:vip")
		local resultadoVip = json.decode(consultarVip) or 0
		local meuVip = vRP.getUserGroupByType(user_id,"vip")

		if resultadoVip > 0 then
			TriggerClientEvent('chatMessage', player, 'VIP', {33,216,33}, 'Você ainda possui '..resultadoVip..' dia(s) de VIP '..meuVip..' .')
			vRP.log("nzk_logs/vip/contagem.txt", "O VIP "..meuVip.." do [ID: "..user_id.."] ainda restam "..resultadoVip.." dia(s).")
		end

		if resultadoVip == 0 then
			if vRP.hasGroup(user_id, "Bronze") or vRP.hasGroup(user_id, "Prata") or vRP.hasGroup(user_id, "Ouro") or vRP.hasGroup(user_id, "Diamante") or vRP.hasGroup(user_id, "Platina") or vRP.hasGroup(user_id, "Rubi") or vRP.hasGroup(user_id, "Safira") then
				vRP.removeUserGroup(user_id,meuVip)
				TriggerClientEvent('chatMessage', player, 'VIP', {33,216,33}, 'Seu VIP '..meuVip..' expirou.')
				vRP.log("nzk_logs/vip/expirou.txt", "O VIP "..meuVip.." do [ID: "..user_id.."] expirou.")
			end
		end
	end) ]]
end) 
------------------------------------------------------------------------------------------------------------------------------------------------
-- STATIC
------------------------------------------------------------------------------------------------------------------------------------------------
--[[ local pegar_cnh = {}
pegar_cnh["Comprar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryPayment(user_id, 5000) then
			if vRP.hasGroup(user_id, "CNH") then
				TriggerClientEvent('chatMessage', player, '^2Você ja possui CNH.')
			else
				vRP.addUserGroup(user_id,"CNH")
				TriggerClientEvent('chatMessage', player, '^2Você Comprou a CNH, agora pode dirigir livremente e com moderação.')
			end
		else
			TriggerClientEvent('chatMessage', player, '^9Você não possui dinheiro.')
		end
	end
end,"<text01>Preco</text01><text02>5.000</text02>"}]] -- 

local hospital_tratamento = {}
hospital_tratamento["Curar ($ 2000)"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if not vRPclient.isInComa(player) then
			local curarPreco = 2000
			if vRP.hasPermission(user_id, "perm.vip") then
				curarPreco = 0
				TriggerClientEvent('chatMessage', player, 'SOCIO', {33,216,33}, 'Você não paga o hospital.')
			end
			if vRP.tryPayment(user_id, curarPreco) then
				vRPclient.teleportUTI(player, false)
			else 
				TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Você não possui dinheiro.')
			end
		else 
			TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Você está em coma.')
		end
	end
end}

hospital_tratamento["Transferir UTI (HOSPITAL)"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.hasPermission(user_id, "perm.unizk") then
			local nplayer = vRPclient.getNearestPlayer(player,2)
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				if not vRPclient.isFinalizado(nplayer) then
					if nuser_id ~= nil then
						vRPclient._stopAnim(player,true)
						vRPclient._stopAnim(player,false)
						TriggerClientEvent("nzk:undrag", nplayer)
						vRPclient.teleportUTI(nplayer, true)
					end
				else
					TriggerClientEvent('chatMessage', player, '^2Este jogador está finalizado.')
				end
				
			else
				TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Nenhum jogador proximo.')
			end
		end
	end
end}

local police_weapons = {}
police_weapons["Equipar"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then

				if vRP.hasGroup(user_id,"Comandante [POLICIA]") then
					vRPclient.giveWeapons(player, { 
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_SPECIALCARBINE"] = {ammo=250}, -- PARAFALL   
					}, false )
            vRP.giveInventoryItem(user_id, "algemas", 2)
						vRPclient.setArmour(player,100)
						vRP.addUserGroup(user_id, "Comandante [PTR]")
				elseif vRP.hasGroup(user_id,"Coronel [POLICIA]") then
						vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
              			["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
              			["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
              			["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
              			["WEAPON_CARBINERIFLE"] = {ammo=200}, -- M4A4   
						}, true)
						vRP.giveInventoryItem(user_id, "algemas", 2)
						vRPclient.setArmour(player,100)
						vRP.addUserGroup(user_id, "Coronel [PTR]")
				elseif vRP.hasGroup(user_id,"Tenente Coronel [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_SPECIALCARBINE"] = {ammo=250}, -- M4A4  
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Tenente Coronel [PTR]")
				elseif vRP.hasGroup(user_id,"Major [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_CARBINERIFLE"] = {ammo=200}, -- M4A4   
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Major [PTR]")
				elseif vRP.hasGroup(user_id,"Capitão [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_CARBINERIFLE"] = {ammo=200}, -- M4A4  
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Capitão [PTR]")
				elseif vRP.hasGroup(user_id,"Tenente [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_CARBINERIFLE"] = {ammo=200}, -- M4A4   
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Tenente [PTR]")
				elseif vRP.hasGroup(user_id,"Sargento [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_COMBATPDW"] = {ammo=200}, -- SMG
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Sargento [PTR]")
				elseif vRP.hasGroup(user_id,"Cabo [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_COMBATPDW"] = {ammo=200}, -- SMG  
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Cabo [PTR]")
				elseif vRP.hasGroup(user_id,"Soldado [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Soldado [PTR]")
				elseif vRP.hasGroup(user_id,"Recruta [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA  
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Recruta [PTR]")
				elseif vRP.hasGroup(user_id,"Piloto [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_CARBINERIFLE"] = {ammo=200}, -- M4A1    
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Piloto [PTR]")
				end
		end
end}

police_weapons["Patrulha"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then

				if vRP.hasGroup(user_id,"Comandante [POLICIA]") then
					vRPclient.giveWeapons(player, { 
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- PISTOLA PESADA
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					}, false )
            vRP.giveInventoryItem(user_id, "algemas", 2)
						vRPclient.setArmour(player,100)
						vRP.addUserGroup(user_id, "Comandante [PTR]")
				elseif vRP.hasGroup(user_id,"Coronel [POLICIA]") then
						vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
              			["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
              			["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						}, true)
						vRP.giveInventoryItem(user_id, "algemas", 2)
						vRPclient.setArmour(player,100)
						vRP.addUserGroup(user_id, "Coronel [PTR]")
				elseif vRP.hasGroup(user_id,"Tenente Coronel [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Tenente Coronel [PTR]")
				elseif vRP.hasGroup(user_id,"Major [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Major [PTR]")
				elseif vRP.hasGroup(user_id,"Capitão [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Capitão [PTR]")
				elseif vRP.hasGroup(user_id,"Tenente [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Tenente [PTR]")
				elseif vRP.hasGroup(user_id,"Sargento [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Sargento [PTR]")
				elseif vRP.hasGroup(user_id,"Cabo [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Cabo [PTR]")
				elseif vRP.hasGroup(user_id,"Soldado [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Soldado [PTR]")
				elseif vRP.hasGroup(user_id,"Recruta [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Recruta [PTR]")
				elseif vRP.hasGroup(user_id,"Piloto [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Piloto [PTR]")
				end
		end
end}
police_weapons["Sair da PTR"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.hasGroup(user_id, "Comandante [PTR]") then
			vRP.addUserGroup(user_id,"Comandante [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Coronel [PTR]") then
			vRP.addUserGroup(user_id,"Coronel [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Tenente Coronel [PTR]") then
			vRP.addUserGroup(user_id,"Tenente Coronel [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Major [PTR]") then
			vRP.addUserGroup(user_id,"Major [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Capitão [PTR]") then
			vRP.addUserGroup(user_id,"Capitão [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Tenente [PTR]") then
			vRP.addUserGroup(user_id,"Tenente [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Sargento [PTR]") then
			vRP.addUserGroup(user_id,"Sargento [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Cabo [PTR]") then
			vRP.addUserGroup(user_id,"Cabo [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Soldado [PTR]") then
			vRP.addUserGroup(user_id,"Soldado [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Recruta [PTR]") then
			vRP.addUserGroup(user_id,"Recruta [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		elseif vRP.hasGroup(user_id, "Piloto [PTR]") then
			vRP.addUserGroup(user_id,"Piloto [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=80}}, true)
		end
	end
end}
local prf_weapons = {}
prf_weapons["Equipar"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then

		 		if vRP.hasGroup(user_id,"Comandante [PRF]") then
					vRPclient.giveWeapons(player, { 
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_CARBINERIFLE"] = {ammo=250}, -- PARAFALL   
					}, false )
           			    vRP.giveInventoryItem(user_id, "algemas", 2)
						vRPclient.setArmour(player,100)
						vRP.addUserGroup(user_id, "Comandante [PRFPTR]")
				elseif vRP.hasGroup(user_id,"Agente Especial [PRF]") then
						vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
              			["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
              			["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
              			["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
              			["WEAPON_CARBINERIFLE"] = {ammo=200}, -- M4A4   
						}, true)
						vRP.giveInventoryItem(user_id, "algemas", 2)
						vRPclient.setArmour(player,100)
						vRP.addUserGroup(user_id, "Agente Especial [PRFPTR]")
				elseif vRP.hasGroup(user_id,"Agente Especial 1 classe [PRF]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_CARBINERIFLE"] = {ammo=250}, -- M4A4  
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Agente Especial 1 classe [PRFPTR]")
				elseif vRP.hasGroup(user_id,"Agente Especial 2 classe[PRF]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_CARBINERIFLE"] = {ammo=200}, -- M4A4   
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Major [PTR]")
				elseif vRP.hasGroup(user_id,"Agente Especial 2 classe[PRFPTR]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_CARBINERIFLE"] = {ammo=200}, -- M4A4  
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Agente Especial 3 classe[PRF]")
				elseif vRP.hasGroup(user_id,"Tenente [POLICIA]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- TAURUS
						["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_CARBINERIFLE"] = {ammo=200}, -- M4A4   
						}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Agente Especial 3 classe[PRFPTR]")	
				end
		end
end}

police_weapons["Assalto a loja"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.hasGroup(user_id, "Comandante [PTR]") then
			vRP.addUserGroup(user_id,"Comandante [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Coronel [PTR]") then
			vRP.addUserGroup(user_id,"Coronel [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=190}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Tenente Coronel [PTR]") then
			vRP.addUserGroup(user_id,"Tenente Coronel [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Major [PTR]") then
			vRP.addUserGroup(user_id,"Major [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Capitão [PTR]") then
			vRP.addUserGroup(user_id,"Capitão [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Tenente [PTR]") then
			vRP.addUserGroup(user_id,"Tenente [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Sargento [PTR]") then
			vRP.addUserGroup(user_id,"Sargento [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Cabo [PTR]") then
			vRP.addUserGroup(user_id,"Cabo [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Soldado [PTR]") then
			vRP.addUserGroup(user_id,"Soldado [POLICIA]")
			vRPclient.setArmour(player,100)
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Recruta [PTR]") then
			vRP.addUserGroup(user_id,"Recruta [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		elseif vRP.hasGroup(user_id, "Piloto [PTR]") then
			vRP.addUserGroup(user_id,"Piloto [POLICIA]")
			vRPclient.giveWeapons(player, {["WEAPON_COMBATPISTOL"] = {ammo=180}}, true)
			vRPclient.setArmour(player,100)
		end
	end
end}

local civil_weapons = {}
civil_weapons["1. Operação"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then

			if vRP.hasGroup(user_id,"Comandante [CIVIL]") then
				vRPclient.giveWeapons(player, { 
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_SPECIALCARBINE"] = {ammo=200} -- PARAFAL    
				}, false )
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Comandante [CPTR]")
			elseif vRP.hasGroup(user_id,"Delegado [CIVIL]") then
					vRPclient.giveWeapons(player,{
						["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
						["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
						["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
						["WEAPON_SPECIALCARBINE"] = {ammo=200} -- PARAFAL     
					}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Delegado [CPTR]")
			elseif vRP.hasGroup(user_id,"Corregedor [CIVIL]") then
				vRPclient.giveWeapons(player,{
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_SPECIALCARBINE"] = {ammo=200} -- PARAFAL 
					}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Corregedor [CPTR]")
			elseif vRP.hasGroup(user_id,"Investigador [CIVIL]") then
				vRPclient.giveWeapons(player,{
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_SPECIALCARBINE"] = {ammo=200} -- M4     
					}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Investigador [CPTR]")
			elseif vRP.hasGroup(user_id,"Operador [CIVIL]") then
				vRPclient.giveWeapons(player,{
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_SPECIALCARBINE"] = {ammo=200} -- M4   
					}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Operador [CPTR]")
			elseif vRP.hasGroup(user_id,"Agente [CIVIL]") then
				vRPclient.giveWeapons(player,{
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_SPECIALCARBINE"] = {ammo=200} -- M4    
					}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Agente [CPTR]")
			elseif vRP.hasGroup(user_id,"Escrivão [CIVIL]") then
				vRPclient.giveWeapons(player,{
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_SPECIALCARBINE"] = {ammo=200} -- M4  
					}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Escrivão [CPTR]")
			elseif vRP.hasGroup(user_id,"Piloto [CIVIL]") then
				vRPclient.giveWeapons(player,{
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_SPECIALCARBINE"] = {ammo=200} -- M4 
					}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Piloto [CPTR]")
			end
	end
end}

civil_weapons["2. Investigação"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=100}}, true)
	end
end}

civil_weapons["3. Patrulha"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then

			if vRP.hasGroup(user_id,"Comandante [CIVIL]") then
				vRPclient.giveWeapons(player, { 
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
					["WEAPON_CARBINERIFLE"] = {ammo=200} -- SMG    
				}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Comandante [CPTR]")
			elseif vRP.hasGroup(user_id,"Delegado [CIVIL]") then
				vRPclient.giveWeapons(player, { 
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
					["WEAPON_CARBINERIFLE"] = {ammo=200} -- SMG    
				}, true)
					vRP.giveInventoryItem(user_id, "algemas", 2)
					vRPclient.setArmour(player,100)
					vRP.addUserGroup(user_id, "Delegado [CPTR]")
			elseif vRP.hasGroup(user_id,"Corregedor [CIVIL]") then
				vRPclient.giveWeapons(player, { 
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
					["WEAPON_CARBINERIFLE"] = {ammo=200} -- SMG    
				}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Corregedor [CPTR]")
			elseif vRP.hasGroup(user_id,"Investigador [CIVIL]") then
				vRPclient.giveWeapons(player, { 
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
					["WEAPON_CARBINERIFLE"] = {ammo=200} -- SMG    
				}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Investigador [CPTR]")
			elseif vRP.hasGroup(user_id,"Operador [CIVIL]") then
				vRPclient.giveWeapons(player, { 
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
					["WEAPON_CARBINERIFLE"] = {ammo=200} -- SMG    
				}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Operador [CPTR]")
			elseif vRP.hasGroup(user_id,"Agente [CIVIL]") then
				vRPclient.giveWeapons(player, { 
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
					["WEAPON_CARBINERIFLE"] = {ammo=200} -- SMG    
				}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Agente [CPTR]")
			elseif vRP.hasGroup(user_id,"Escrivão [CIVIL]") then
				vRPclient.giveWeapons(player, { 
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
					["WEAPON_CARBINERIFLE"] = {ammo=200} -- SMG    
				}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Escrivão [CPTR]")
			elseif vRP.hasGroup(user_id,"Piloto [CIVIL]") then
				vRPclient.giveWeapons(player, { 
					["WEAPON_COMBATPISTOL"] = {ammo=180}, -- GLOCK
					["WEAPON_STUNGUN"] = {ammo=1}, -- TAZER
					["WEAPON_FLASHLIGHT"] = {ammo=1}, -- LANTERNA 
					["WEAPON_NIGHTSTICK"] = {ammo=1}, -- Cacetete
					["WEAPON_CARBINERIFLE"] = {ammo=200} -- SMG    
				}, true)
				vRP.giveInventoryItem(user_id, "algemas", 2)
				vRPclient.setArmour(player,100)
				vRP.addUserGroup(user_id, "Piloto [CPTR]")
			end
	end
end}

civil_weapons["4. Sair PTR"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.hasGroup(user_id, "Comandante [CPTR]") then
			vRP.addUserGroup(user_id,"Comandante [CIVIL]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=180}}, true)
		elseif vRP.hasGroup(user_id, "Delegado [CPTR]") then
			vRP.addUserGroup(user_id,"Delegado [CIVIL]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=180}}, true)
		elseif vRP.hasGroup(user_id, "Corregedor [CPTR]") then
			vRP.addUserGroup(user_id,"Corregedor [CIVIL]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=180}}, true)
		elseif vRP.hasGroup(user_id, "Investigador [CPTR]") then
			vRP.addUserGroup(user_id,"Investigador [CIVIL]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=180}}, true)
		elseif vRP.hasGroup(user_id, "Operador [CPTR]") then
			vRP.addUserGroup(user_id,"Operador [CIVIL]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=180}}, true)
		elseif vRP.hasGroup(user_id, "Agente [CPTR]") then
			vRP.addUserGroup(user_id,"Agente [CIVIL]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=180}}, true)
		elseif vRP.hasGroup(user_id, "Escrivão [CPTR]") then
			vRP.addUserGroup(user_id,"Escrivão [CIVIL]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=180}}, true)
		elseif vRP.hasGroup(user_id, "Piloto [CPTR]") then
			vRP.addUserGroup(user_id,"Piloto [CIVIL]")
			vRPclient.giveWeapons(player, {["WEAPON_PISTOL"] = {ammo=180}}, true)
		end
	end
end}


local mec_equipamentos = {}
mec_equipamentos["1. Equipar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.hasGroup(user_id, "Lider [MECANICO]") then
			vRP.addUserGroup(user_id,"Lider [PMEC]")
			vRP.giveInventoryItem(user_id, "repairkit", 5)
		elseif vRP.hasGroup(user_id, "Sub-Lider [MECANICO]") then
			vRP.addUserGroup(user_id,"Sub-Lider [PMEC]")
			vRP.giveInventoryItem(user_id, "repairkit", 5)
		elseif vRP.hasGroup(user_id, "Membro [MECANICO]") then 
			vRP.addUserGroup(user_id,"Membro [PMEC]")
			vRP.giveInventoryItem(user_id, "repairkit", 5)
		end
	end
end}

mec_equipamentos["2. Sair"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.hasGroup(user_id, "Lider [PMEC]") then
			vRP.addUserGroup(user_id,"Lider [MECANICO]")
		elseif vRP.hasGroup(user_id, "Sub-Lider [PMEC]") then
			vRP.addUserGroup(user_id,"Sub-Lider [MECANICO]")
		elseif vRP.hasGroup(user_id, "Membro [PMEC]") then 
			vRP.addUserGroup(user_id,"Membro [MECANICO]")
		end
	end
end}

local ls_equipamentos = {}
ls_equipamentos["1. Equipar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.hasGroup(user_id, "Lider [LS CUSTOM]") then
			vRP.addUserGroup(user_id,"Lider [LSEXP]")
			vRP.giveInventoryItem(user_id, "repairkit", 5)
		elseif vRP.hasGroup(user_id, "Sub-Lider [LS CUSTOM]") then
			vRP.addUserGroup(user_id,"Sub-Lider [LSEXP]")
			vRP.giveInventoryItem(user_id, "repairkit", 5)
		elseif vRP.hasGroup(user_id, "Membro [LS CUSTOM]") then 
			vRP.addUserGroup(user_id,"Membro [LSEXP]")
			vRP.giveInventoryItem(user_id, "repairkit", 5)
		end
	end
end}

ls_equipamentos["2. Sair"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.hasGroup(user_id, "Lider [LSEXP]") then
			vRP.addUserGroup(user_id,"Lider [LS CUSTOM]")
		elseif vRP.hasGroup(user_id, "Sub-Lider [LSEXP]") then
			vRP.addUserGroup(user_id,"Sub-Lider [LS CUSTOM]")
		elseif vRP.hasGroup(user_id, "Membro [LSEXP]") then 
			vRP.addUserGroup(user_id,"Membro [LS CUSTOM]")
		end
	end
end}

local sistema_criminal = {}
sistema_criminal["Consultar RG"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
  local consultarRG = vRP.prompt(player, "Digite o RG:", "")
  if consultarRG ~= nil and consultarRG ~= "" then
    local userRG = vRP.getUserByRegistration(consultarRG)
    if userRG then
        local consultarRG = vRP.getUData(userRG, "vRP:ficha:criminal", "")
        if consultarRG then
			vRPclient._setDiv(player,"police_pc",".div_police_pc{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",consultarRG)
			local ok = vRP.request(player, "Deseja fechar o registro criminal?", 999)
          if ok then
            vRPclient._removeDiv(player, "police_pc")
          else
            vRPclient._removeDiv(player, "police_pc")
          end
        end
      else
        TriggerClientEvent('chatMessage', player, "^9RG inexistente ou não se encontra agora pela cidade.")
    end

  end
end}

sistema_criminal["Limpar ficha"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  local consultarRG = vRP.prompt(player, "Digite o RG:", "")
  if consultarRG ~= nil and consultarRG ~= "" then
	local userRG = vRP.getUserByRegistration(consultarRG)
	local nuser_id = vRP.getUserId(consultarRG) 
    if userRG then
        if user_id then
          local ok = vRP.request(player,"Tem certeza que deseja limpar o registro criminal do RG:"..consultarRG.." ?", 30)
						if ok then
              vRP.setUData(nuser_id, "vRP:ficha:criminal", "")
              TriggerClientEvent('chatMessage', player, "^2Você limpou o registro criminal do RG:"..consultarRG)
            end
        end
      else
        TriggerClientEvent('chatMessage', player, "^9RG inexistente ou não se encontra agora pela cidade.")
    end
  end
end}

local lavagem_dinheiro = {}
lavagem_dinheiro["Lavar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	local lavarDinheiro = vRP.prompt(player, "Digite a quantia para lavar:", "")
	if lavarDinheiro ~= nil and lavarDinheiro ~= "" and tonumber(lavarDinheiro) then
		if user_id ~= nil then
			if vRP.tryGetInventoryItem(user_id,"dirty_money", tonumber(lavarDinheiro)) then
				TriggerClientEvent("progress",player,50000,"lavando")
				TriggerClientEvent('cancelando',player,true)
				TriggerClientEvent('NZK:lavardinheiro', player)
				vRPclient._playAnim(player,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
				SetTimeout(50000, function()
					local dinheiroVIP = lavarDinheiro*0.50
					local lavagemMoney = lavarDinheiro*1.0
					if vRP.hasPermission(user_id, "perm.tequilala") or vRP.hasPermission(user_id, "perm.vanilla") then
						vRP.giveMoney(user_id,lavagemMoney)
						TriggerClientEvent('chatMessage', player, "^5**LAVAGEM** ^2Você lavou $ ^5".. vRP.format(lavagemMoney) .."")
						vRP.log("nzk_logs/player/lavagem.txt", "O [ID: "..user_id.."] lavou " ..vRP.format(lavagemMoney).. "")					
						vRPclient._stopAnim(player, false)
						TriggerClientEvent('cancelando',player,false)
					elseif vRP.hasPermission(user_id, "perm.iaa") or vRP.hasPermission(user_id, "perm.iaa")  then
						vRP.giveMoney(user_id,tonumber(dinheiroVIP))
						TriggerClientEvent('chatMessage', player, "^5**Safira/Platina** ^2Você lavou $ ^5"..tonumber(dinheiroVIP).."")
						vRPclient._stopAnim(player, false)
						TriggerClientEvent('cancelando',player,false)
					end
					vRPclient._stopAnim(player, false)
				end)
			else
				TriggerClientEvent('chatMessage', player, "^2Você não possui essa quantia para lavar.")
			end
		end
	else
		TriggerClientEvent('chatMessage', player, "^2Digite o valor corretamente.")
	end
end}

local loja_pescaria = {}
loja_pescaria["Comprar: Isca"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryPayment(user_id, 50) then
		vRP.giveInventoryItem(user_id, "isca", 1)
		TriggerClientEvent('chatMessage', player, "^2Você comprou 1x isca.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui dinheiro.")
	end
end,"<text01>Valor</text01><text02>50</text02>"}

loja_pescaria["Vender: Dourado"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"dourado", 1) then
		vRP.giveMoney(user_id, 450)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Dourado.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui este peixe.")
	end
end,"<text01>Valor</text01><text02>450</text02>"}

loja_pescaria["Vender: Corvina"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"corvina", 1) then
		vRP.giveMoney(user_id, 450)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Corvina.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui este peixe.")
	end
end,"<text01>Valor</text01><text02>450</text02>"}

loja_pescaria["Vender: Salmao"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"salmao", 1) then
		vRP.giveMoney(user_id, 200)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Salmao.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui este peixe.")
	end
end,"<text01>Valor</text01><text02>450</text02>"}

loja_pescaria["Vender: Pacu"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"pacu", 1) then
		vRP.giveMoney(user_id, 450)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Pacu.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui este peixe.")
	end
end,"<text01>Valor</text01><text02>450</text02>"}

loja_pescaria["Vender: Pintado"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"pintado", 1) then
		vRP.giveMoney(user_id, 450)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Pintado.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui este peixe.")
	end
end,"<text01>Valor</text01><text02>450</text02>"}

loja_pescaria["Vender: Pirarucu"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"pirarucu", 1) then
		vRP.giveMoney(user_id, 450)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Pirarucu.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui este peixe.")
	end
end,"<text01>Valor</text01><text02>450</text02>"}

loja_pescaria["Vender: Tilapia"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"tilapia", 1) then
		vRP.giveMoney(user_id, 450)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Tilapia.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui este peixe.")
	end
end,"<text01>Valor</text01><text02>450</text02>"}

loja_pescaria["Vender: Tucunare"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"tucunare", 1) then
		vRP.giveMoney(user_id, 450)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Tucunare.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui este peixe.")
	end
end,"<text01>Valor</text01><text02>450</text02>"}

loja_pescaria["Vender: Lambari"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"lambari", 1) then
		vRP.giveMoney(user_id, 450)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Lambari.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui este peixe.")
	end
end,"<text01>Valor</text01><text02>450</text02>"}


local psicologo = {}
psicologo["Teste Psicologico"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryPayment(user_id, 5000) then
		vRP.giveInventoryItem(user_id, "certificado", 1)
		TriggerClientEvent('chatMessage', player, "^2Você emitiu um teste psicológico para o Porte de Armas.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui dinheiro.")
	end
end}

local judi = {}
judi["Aprovação Porte"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryPayment(user_id, 5000) then
		vRP.giveInventoryItem(user_id, "documento", 1)
		TriggerClientEvent('chatMessage', player, "^2Você emitiu a aprovação para o Porte de Armas.")
	else
		TriggerClientEvent('chatMessage', player, "^2Você não possui dinheiro.")
	end
end}



local vender_joias = {}

vender_joias["Vender: Barra de Ouro"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"barra", 1) then
		vRP.giveInventoryItem(user_id, "dirty_money", 15000)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Barra de Ouro.")
	end
end}


vender_joias["Vender: Esmeralda"] = {function(player,choice)
local user_id = vRP.getUserId(player)
if vRP.tryGetInventoryItem(user_id,"esmeralda", 1) then
	vRP.giveInventoryItem(user_id, "dirty_money", 15000)
	TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x Esmeralda.")
end
end}

vender_joias["Vender: Brincos"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.tryGetInventoryItem(user_id,"brincos", 1) then
		vRP.giveInventoryItem(user_id, "dirty_money", 10000)
		TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x par de brincos.")
	end
	end}

vender_joias["Vender: Colares"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
		if vRP.tryGetInventoryItem(user_id,"colar", 1) then
			vRP.giveInventoryItem(user_id, "dirty_money", 10000)
			TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x colar.")
	end
	end}
vender_joias["Vender: Joia"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
		if vRP.tryGetInventoryItem(user_id,"joia", 1) then
			vRP.giveInventoryItem(user_id, "dirty_money", 10000)
			TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x pedra preciosa.")
	end
	end}
vender_joias["Vender: Relogio"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
		if vRP.tryGetInventoryItem(user_id,"relogio", 1) then
			vRP.giveInventoryItem(user_id, "dirty_money", 10000)
			TriggerClientEvent('chatMessage', player, "^2Você vendeu 1x relógio.")
		end
	end}

local hospital_menu = {}
hospital_menu["Equipar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.hasGroup(user_id, "Diretor [HOSPITAL]") then
		vRP.addUserGroup(user_id,"Diretor [EXP]")
		vRP.giveInventoryItem(user_id, "medkit", 10)
		vRPclient.giveWeapons(player, {  ["WEAPON_STUNGUN"] = {ammo=1}, }, false )
	elseif vRP.hasGroup(user_id, "Sub-diretor [HOSPITAL]") then
		vRP.addUserGroup(user_id,"Sub-diretor [EXP]")
		vRP.giveInventoryItem(user_id, "medkit", 10)
		vRPclient.giveWeapons(player, {  ["WEAPON_STUNGUN"] = {ammo=1}, }, false )
	elseif vRP.hasGroup(user_id, "Gestão [HOSPITAL]") then
		vRP.addUserGroup(user_id,"Gestão [EXP]")
		vRP.giveInventoryItem(user_id, "medkit", 10)
		vRPclient.giveWeapons(player, {  ["WEAPON_STUNGUN"] = {ammo=1}, }, false )
	elseif vRP.hasGroup(user_id, "Medico [HOSPITAL]") then
		vRP.addUserGroup(user_id,"Medico [EXP]")
		vRP.giveInventoryItem(user_id, "medkit", 10)
		vRPclient.giveWeapons(player, {  ["WEAPON_STUNGUN"] = {ammo=1}, }, false )
	elseif vRP.hasGroup(user_id, "Enfermeiro [HOSPITAL]") then
		vRP.addUserGroup(user_id,"Enfermeiro [EXP]")
		vRP.giveInventoryItem(user_id, "medkit", 10)
		vRPclient.giveWeapons(player, {  ["WEAPON_STUNGUN"] = {ammo=1}, }, false )
	elseif vRP.hasGroup(user_id, "Medico Militar [HOSPITAL]") then
		vRP.addUserGroup(user_id,"Medico Militar [EXP]")
		vRP.giveInventoryItem(user_id, "medkit", 10)
		vRPclient.giveWeapons(player, {  ["WEAPON_STUNGUN"] = {ammo=1}, }, false )
	elseif vRP.hasGroup(user_id, "Psicologo [HOSPITAL]") then
		vRP.addUserGroup(user_id,"Psicologo [EXP]")
		vRP.giveInventoryItem(user_id, "medkit", 10)
		vRPclient.giveWeapons(player, {  ["WEAPON_STUNGUN"] = {ammo=1}, }, false )
	elseif vRP.hasGroup(user_id, "Socorrista [HOSPITAL]") then
		vRP.addUserGroup(user_id,"Socorrista [EXP]")
		vRP.giveInventoryItem(user_id, "medkit", 10)
		vRPclient.giveWeapons(player, {  ["WEAPON_STUNGUN"] = {ammo=1}, }, false )
	end
end}

hospital_menu["Sair Expediente"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.hasGroup(user_id, "Diretor [EXP]") then
		vRP.addUserGroup(user_id,"Diretor [HOSPITAL]")
	elseif vRP.hasGroup(user_id, "Sub-diretor [EXP]") then
		vRP.addUserGroup(user_id,"Sub-diretor [HOSPITAL]")
	elseif vRP.hasGroup(user_id, "Gestão [EXP]") then
		vRP.addUserGroup(user_id,"Gestão [HOSPITAL]")
	elseif vRP.hasGroup(user_id, "Medico [EXP]") then
		vRP.addUserGroup(user_id,"Medico [HOSPITAL]")
	elseif vRP.hasGroup(user_id, "Medico Militar [EXP]") then
		vRP.addUserGroup(user_id,"Medico Militar [HOSPITAL]")
	elseif vRP.hasGroup(user_id, "Enfermeiro [EXP]") then
		vRP.addUserGroup(user_id,"Enfermeiro [HOSPITAL]")
	elseif vRP.hasGroup(user_id, "Psicologo [EXP]") then
		vRP.addUserGroup(user_id,"Psicologo [HOSPITAL]")
	elseif vRP.hasGroup(user_id, "Socorrista [EXP]") then
		vRP.addUserGroup(user_id,"Socorrista [HOSPITAL]")
	end
end}

local cet_arsenal = {}
cet_arsenal["Equipar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
		vRPclient.giveWeapons(player, { ["WEAPON_STUNGUN"] = {ammo=1}, ["WEAPON_NIGHTSTICK"] = {ammo=1}, }, false )
end}

local advogado_elevador = {}
advogado_elevador["Subir"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,-141.06,-620.94,168.8)
end}
advogado_elevador["Descer"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,-116.95,-604.57,36.28)
end}

local cet_entrar = {}
cet_entrar["Sair"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,259.53,-1357.20,30.55)
end}

cet_entrar["Entrar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,-1569.64,-568.54,105.20)
end}

local lavagem_interior = {}
lavagem_interior["Sair"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player, 1994.6408691406,3046.1403808594,47.21520614624)
end}

lavagem_interior["Entrar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player, 1138.0798339844,-3198.9067382813,-39.665725708008)
end}

local elevador_civil = {}
elevador_civil["Subir"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    vRPclient.teleport(player, 135.99,-761.76,242.16)
end}

elevador_civil["Garagem"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    vRPclient.teleport(player, 145.73,-682.31,33.34)
end}

elevador_civil["Terreo"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    vRPclient.teleport(player, 138.94,-762.71,45.76)
end}

local elevador_hospital = {}
elevador_hospital["Subir"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    vRPclient.teleport(player, 335.87368774414,-580.26708984375,74.070457458496)
end}
 
elevador_hospital["Subsolo"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    vRPclient.teleport(player, 331.25726318359,-592.80493164063,28.901123046875)
end}

elevador_hospital["Segundo Andar"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    vRPclient.teleport(player, 335.94528198242,-580.41668701172,48.24089050293)
end}

elevador_hospital["Terreo"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    vRPclient.teleport(player, 331.27755737305,-592.87066650391,43.282051086426)
end}

local elevador_iaa = {}
elevador_iaa["Descer"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player, 2155.4624023438,2920.9140625,-61.902454376221)
end}

elevador_iaa["Subir"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player, -468.36260986328,1129.2000732422,325.85565185547)
end}

elevador_iaa["Bunker"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player, 2060.3681640625,2992.8735351563,-72.702026367188)
end}

local entrada_svidas = {}
entrada_svidas["Entrar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,-1483.7506103516,-1028.9846191406,6.2976531982422)
end}

entrada_svidas["Sair"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,-1482.6533203125,-1029.9847412109,6.1390199661255)
end}

local pool_vip = {}
pool_vip["Subir"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,-1396.8541259766,-1008.8393554688,24.704578399658)
end}

pool_vip["Descer"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,-1398.8598632813,-986.23779296875,19.380460739136)
end}


elevador_iaa["Bunker"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player, 2060.3681640625,2992.8735351563,-72.702026367188)
end}

local entrada_bunker = {}
entrada_bunker["Entrar"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,903.08,-3182.14,-97.05)
end}

entrada_bunker["Sair"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	vRPclient.teleport(player,-389.05,4342.1,56.11)
end}

vRP._addStaticMenuChoices("ls_equipamentos", ls_equipamentos)
vRP._addStaticMenuChoices("mec_equipamentos", mec_equipamentos)
vRP._addStaticMenuChoices("vender_joias", vender_joias)
vRP._addStaticMenuChoices("psicologo", psicologo)
vRP._addStaticMenuChoices("judi", judi)
vRP._addStaticMenuChoices("elevador_hospital", elevador_hospital)
vRP._addStaticMenuChoices("elevador_civil", elevador_civil)
vRP._addStaticMenuChoices("elevador_iaa", elevador_iaa)
vRP._addStaticMenuChoices("lavagem_interior", lavagem_interior)
vRP._addStaticMenuChoices("cet_arsenal", cet_arsenal)
vRP._addStaticMenuChoices("cet_entrar", cet_entrar)
vRP._addStaticMenuChoices("advogado_elevador", advogado_elevador)
vRP._addStaticMenuChoices("hospital_menu", hospital_menu)
--vRP._addStaticMenuChoices("prf_menu", prf_menu)
vRP._addStaticMenuChoices("loja_pescaria", loja_pescaria)
--vRP._addStaticMenuChoices("pegar_cnh", pegar_cnh)
vRP._addStaticMenuChoices("lavagem_dinheiro", lavagem_dinheiro)
vRP._addStaticMenuChoices("hospital_tratamento", hospital_tratamento)
vRP._addStaticMenuChoices("police_weapons", police_weapons)
vRP._addStaticMenuChoices("civil_weapons", civil_weapons)
vRP._addStaticMenuChoices("prf_weapons", prf_weapons)
vRP._addStaticMenuChoices("sistema_criminal", sistema_criminal)
vRP._addStaticMenuChoices("entrada_svidas", entrada_svidas )
vRP._addStaticMenuChoices("pool_vip", pool_vip )
vRP._addStaticMenuChoices("entrada_bunker", entrada_bunker )    
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNIZK
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local revive_seq_samu = {
  {"mini@cpr@char_a@cpr_def","cpr_intro",1},
  {"mini@cpr@char_a@cpr_str","cpr_pumpchest",1},
}

local choice_primeiroSocorros = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,10)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id ~= nil then
				if vRPclient.isInComa(nplayer) then
					if not vRPclient.isFinalizado(nplayer) then
						if vRP.tryGetInventoryItem(user_id,"medkit",1) then
							vRPclient._playAnim(player,false,revive_seq_samu,false)
							SetTimeout(15000, function()
								vRPclient.resetComa(nplayer,{})
							end)
					end
				else
					TriggerClientEvent('chatMessage', player, '^2Este jogador está finalizado.')
					end
				else
					TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Nenhum jogador em coma.')
				end
			end
		else
			TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Nenhum jogador proximo.')
		end
  end
end}

local seq_drag = {
  {"anim@heists@box_carry@", "idle",1}
}

local choice_carregarPaciente = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,10)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id ~= nil then
				if vRPclient.isInComa(nplayer) then
					vRPclient._playAnim(player,true,seq_drag,true)
					vRPclient._playAnim(nplayer,false,{{"dead","dead_a"}},1,true)
					TriggerClientEvent("nzk:drag", nplayer, player)
				else
					TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Nenhum jogador em coma.')
				end
			end
		else
			TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Nenhum jogador proximo.')
		end
  end
end}

local choice_soltarPaciente = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,10)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id ~= nil then
				if vRPclient.isInComa(nplayer) then
					vRPclient._stopAnim(player, true)
					vRPclient._stopAnim(player, false)
					TriggerClientEvent("nzk:undrag", nplayer, player)
				else
					TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2O jogador nao esta em coma.')
				end
			end
		else
			TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Nenhum jogador proximo.')
		end
  end
end}

local choice_colocarPaciente = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,10)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id ~= nil then
				if vRPclient.isInComa(nplayer) then
					vRPclient._stopAnim(player, true)
					vRPclient._stopAnim(player, false)
					TriggerClientEvent("nzk:undrag", nplayer)
					vRPclient.putInNearestVehicleAsPassenger(nplayer, 5)
					TriggerClientEvent('hud:Colocar:Cinto', nplayer, true)
				else
					TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2O jogador nao esta em coma.')
				end
			end
		else
			TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Nenhum jogador proximo.')
		end
  end
end}

local choice_tirarPaciente = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,10)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id ~= nil then
				if vRPclient.isInComa(nplayer) then
					local x,y,z = vRPclient.getPosition(player,{})
					vRPclient.ejectVehicle(nplayer, {})
					vRPclient.teleport(nplayer,x,y,z)
					vRPclient._playAnim(nplayer,false,"dead","dead_a",1,true)
					TriggerClientEvent('hud:Colocar:Cinto', nplayer, false)
				else
					TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2O jogador nao esta em coma.')
				end
			end
		else
			TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Nenhum jogador proximo.')
		end
  end
end}

local seq_treatment = {
  {"amb@medic@standing@tendtodead@idle_a","idle_a",1},
  {"amb@medic@standing@tendtodead@idle_a","idle_b",1},
  {"amb@medic@standing@tendtodead@idle_a","idle_c",1}
}

local choice_tratamentoPaciente = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,5)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id ~= nil then
				if vRPclient.isInUTI(nplayer) then
					vRPclient._playAnim(player,true,seq_treatment,true)
					vRPclient.tratamentoUTI(nplayer, {})
					SetTimeout(10*1000, function()
						vRPclient._stopAnim(player, true)
						vRPclient._stopAnim(player, false) 
					end)
				else
					TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2O jogador nao na uti.')
				end
			end
		else
			TriggerClientEvent('chatMessage', player, '', {255,255,255}, '^2Nenhum jogador proximo.')
		end
	end
end}

local remedios = {
  { ['command'] = "nocucedin", ['item'] = "nocucedin"},
  { ['command'] = "paracetanal", ['item'] = "paracetanal"},
  { ['command'] = "decupramim", ['item'] = "decupramim"},
  { ['command'] = "buscopau", ['item'] = "buscopau"},
  { ['command'] = "analdor", ['item'] = "analdor"},
  { ['command'] = "sefodex", ['item'] = "sefodex"},
  { ['command'] = "phodac", ['item'] = "phodac"},
  { ['command'] = "danec", ['item'] = "danec"},
  { ['command'] = "cotovelol", ['item'] = "cotovelol"},
  { ['command'] = "nokusin", ['item'] = "nokusin"},
  { ['command'] = "viagral", ['item'] = "viagral"},
  { ['command'] = "glicoanal", ['item'] = "glicoanal"},
  { ['command'] = "quigosado", ['item'] = "quigosado"}
}

RegisterCommand('rm',function(source,args)
    local source = source
    local user_id = vRP.getUserId(source)
		if user_id then
			if vRP.hasPermission(user_id, "perm.unizk") then
				for k,v in pairs(remedios) do
					if args[1] == v.command then
						vRP.giveInventoryItem(user_id, v.item, 1) 
					end
				end
			end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	"masterpick",
	"lockpick",
	"solda",
	"body_armor",
	"furadeira",
	"cartaovirgem",
	"cartaoclonado",
	"tartaruga",
	"carnetartaruga",
	"dirty_money",
	"vendaolhos",
	"algemas",
	"chave_algemas",
	"seeds",
	"benzoilmetilecgonina",
	"anfetamina",
	"md",
	"weed",
	"cocaine",
	"mascara",
	"orgaos",
	"cadaver",
	"pistol_parts",
	"shotgun_parts",
	"heavy_parts",
	"smg_parts",
	"adv_parts",
	"ak47_parts",
	"orgaos",
	"cadaver",
	"rgfalso",
	"wbody|WEAPON_DAGGER",
	"wbody|WEAPON_BAT",
	"wbody|WEAPON_BOTTLE",
	"wbody|WEAPON_CROWBAR",
	"wbody|WEAPON_FLASHLIGHT",
	"wbody|WEAPON_GOLFCLUB",
	"wbody|WEAPON_HAMMER",
	"wbody|WEAPON_HATCHET",
	"wbody|WEAPON_KNUCKLE",
	"wbody|WEAPON_KNIFE",
	"wbody|WEAPON_MACHETE",
	"wbody|WEAPON_SWITCHBLADE",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_WRENCH",
	"wbody|WEAPON_BATTLEAXE",
	"wbody|WEAPON_POOLCUE",
	"wbody|WEAPON_STONE_HATCHET",
	"wbody|WEAPON_PISTOL",
	"wbody|WEAPON_COMBATPISTOL",
	"wbody|WEAPON_APPISTOL",
	"wbody|WEAPON_CARBINERIFLE",
	"wbody|WEAPON_SMG",
	"wbody|WEAPON_PUMPSHOTGUN_MK2",
	"wbody|WEAPON_STUNGUN",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_SNSPISTOL",
	"wbody|WEAPON_MICROSMG",
	"wbody|WEAPON_ASSAULTRIFLE",
	"wbody|WEAPON_FIREEXTINGUISHER",
	"wbody|WEAPON_FLARE",
	"wbody|WEAPON_REVOLVER",
	"wbody|WEAPON_PISTOL_MK2",
	"wbody|WEAPON_VINTAGEPISTOL",
	"wbody|WEAPON_MUSKET",
	"wbody|WEAPON_GUSENBERG",
	"wbody|WEAPON_ASSAULTSMG",
	"wbody|WEAPON_HEAVYPISTOL",
	"wbody|WEAPON_COMBATPDW",
	"wammo|WEAPON_DAGGER",
	"wammo|WEAPON_BAT",
	"wammo|WEAPON_BOTTLE",
	"wammo|WEAPON_CROWBAR",
	"wammo|WEAPON_FLASHLIGHT",
	"wammo|WEAPON_GOLFCLUB",
	"wammo|WEAPON_HAMMER",
	"wammo|WEAPON_HATCHET",
	"wammo|WEAPON_KNUCKLE",
	"wammo|WEAPON_KNIFE",
	"wammo|WEAPON_MACHETE",
	"wammo|WEAPON_SWITCHBLADE",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_WRENCH",
	"wammo|WEAPON_BATTLEAXE",
	"wammo|WEAPON_POOLCUE",
	"wammo|WEAPON_HEAVYPISTOL",
	"wammo|WEAPON_STONE_HATCHET",
	"wammo|WEAPON_PISTOL",
	"wammo|WEAPON_COMBATPISTOL",
	"wammo|WEAPON_APPISTOL",
	"wammo|WEAPON_CARBINERIFLE",
	"wammo|WEAPON_SMG",
	"wammo|WEAPON_ADVANCEDRIFLE",
	"wammo|WEAPON_CERAMICPISTOL",
	"wammo|WEAPON_PUMPSHOTGUN_MK2",
	"wammo|WEAPON_STUNGUN",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_SNSPISTOL",
	"wammo|WEAPON_MICROSMG",
	"wammo|WEAPON_ASSAULTRIFLE",
	"wammo|WEAPON_FIREEXTINGUISHER",
	"wammo|WEAPON_FLARE",
	"wammo|WEAPON_REVOLVER",
	"wammo|WEAPON_PISTOL_MK2",
	"wammo|WEAPON_VINTAGEPISTOL",
	"wammo|WEAPON_MUSKET",
	"wammo|WEAPON_GUSENBERG",
	"wammo|WEAPON_ASSAULTSMG",
	"wammo|WEAPON_COMBATPDW",
	"wbody|WEAPON_RAYPISTOL"
}

local choice_prisao = {function(player,choice)
	local user_id = vRP.getUserId(player)
	local nplayers = vRPclient.getNearestPlayers(player,15)
	if nplayers then
		local user_list = "" for k,v in pairs(nplayers) do user_list = user_list .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | " end
		if user_list ~= "" then
			local target_id = vRP.prompt(player,"Jogadores Proximo: "..user_list,"")
			if target_id ~= nil and target_id ~= "" then 
				local jail_time = vRP.prompt(player,"Tempo de Prisão em Minutos:","")
				if jail_time ~= nil and jail_time ~= "" then 
					local target = vRP.getUserSource(tonumber(target_id))
					if tonumber(jail_time) > 180 then
						jail_time = 180
					end
					if tonumber(jail_time) < 1 then
						jail_time = 1
					end
					local jail_motivo = vRP.prompt(player,"Digite o Motivo:","")
					if jail_motivo ~= nil and jail_motivo ~= "" then 
						local jail_valor = vRP.prompt(player,"Valor: ","")
						if tonumber(jail_valor) and jail_valor ~= nil and jail_valor ~= "" then
							local jail_guarnicao = vRP.prompt(player,"Guarnição: ","")
							if jail_guarnicao ~= nil and jail_guarnicao ~= "" then 
								if vRPclient.isHandcuffed(target) then
									if vRP.tryFullPayment(tonumber(target_id), tonumber(jail_valor)) then

										vRP.clearInventory(tonumber(target_id))
										vRPclient.giveWeapons(target,{},true)
										vRP.setHunger(tonumber(target_id),0)
										vRP.setThirst(tonumber(target_id),0)
										vRPclient.setHealth(target, 300)
										vRP.setUData(tonumber(target_id),"vRP:prisao",json.encode(tonumber(jail_time)))
										TriggerClientEvent('prisioneiro',target,true)
										vRPclient.teleport(target,1680.1,2513.0,45.5)
										prison_lock(target_id)
										vRPclient.setarRoupasPrisional(target)
										vRPclient.setarRoupasPrisional(target)
										vRP.insertPoliceRecord(tonumber(target_id), "**PRISAO**"..jail_time.." mes(s) no valor de "..jail_valor.." pelo motivo de "..jail_motivo.." pela guarnição "..jail_guarnicao.."")
										vRP.log("nzk_logs/policia/prisao.txt", "O Policial [ID: "..user_id.."] prendeu o jogador [ID: "..tonumber(target_id).."] por "..jail_time.." mes(s) no valor de "..jail_valor.." pelo motivo de "..jail_motivo.." pela guarnição "..jail_guarnicao.."")
										SetTimeout(5000,function() vRPclient.setHandcuffed(target,false) end)

										TriggerClientEvent('chatMessage', -1, 'PRISÃO', { 0, 0, 0 }, '^0 O ^3'.. GetPlayerName(target) ..' ^0 foi preso(a) e condenado(a) por ^3'.. jail_time ..' ^0mes(s).')
										TriggerClientEvent('chatMessage', target, 'PRISAO', { 0, 0, 0 }, 'Você foi preso por '..jail_time..' mes(s) pelo motivo(s) de '..jail_motivo..' e pagou $ '..tonumber(jail_valor)..' de multa. ^9(para contestação contate seu advogado!)')
										TriggerClientEvent('chatMessage', player, 'PRISAO', { 0, 0, 0 }, 'Você enviou um jogador para a prisão.')
										
										vRP.giveMoney(user_id,math.random(4000,6000))
									else
										TriggerClientEvent('chatMessage', player, '^2O Jogador não possui dinheiro.')
									end
								else
									TriggerClientEvent('chatMessage', player, '^2O Jogador não está algemado.')
								end
							else
								TriggerClientEvent('chatMessage', player, '^2Digite Corretamente.')
							end
						else
							TriggerClientEvent('chatMessage', player, '^2Digite Corretamente.')
						end
					else
						TriggerClientEvent('chatMessage', player, '^2Digite Corretamente.')
					end
				else
					TriggerClientEvent('chatMessage', player, '^2Digite Corretamente.')
				end
			else
				TriggerClientEvent('chatMessage', player, '^2Digite Corretamente.')
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
	end
end}

local choice_multar = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id then
		local id = vRP.prompt(player,"Passaporte:","")
		local valor = vRP.prompt(player,"Valor:","")
		if id == "" or valor == "" then
			return
		end
		local value = vRP.getUData(parseInt(id),"vRP:multas")
		local multas = json.decode(value) or 0
		vRP.setUData(parseInt(id),"vRP:multas",json.encode(parseInt(multas)+parseInt(valor)))
		TriggerClientEvent('chatMessage', player, '^2Você multou o passaporte '..id..' no valor de $ ^5'..vRP.format(valor))
		vRPclient.playSound(player,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
		vRP.log("nzk_logs/policia/multas.txt", "O Policial [ID:"..user_id.." multou o [ID: "..id.."] no valor "..tonumber(valor))
	end
end}

local choice_multar2 = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,5)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
		local value = vRP.getUData(tonumber(nuser_id),"vRP:multas")
		local multas = json.decode(value) or 0
			if multas then
				local ok = vRP.request(player,"Tem certeza que deseja cobrar as multa desse cidadao ?",1000)
				if ok then
					if vRP.tryFullPayment(tonumber(nuser_id), tonumber(multas)) then
						vRP.setUData(tonumber(nuser_id),"vRP:multas", json.encode(0))
						TriggerClientEvent('chatMessage', player, '^2Você cobrou a multa do cidadao no valor $ ^5'..vRP.format(multas))
						TriggerClientEvent('chatMessage', nplayer, '^2O Policial cobrou suas multas no valor de $ ^5'..vRP.format(multas))
					else
						TriggerClientEvent('chatMessage', player, '^2O Jogador não possui dinheiro')
					end
				end
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
	end
end}

local choice_tirarprisao = {function(player,choice)
	local user_id = vRP.getUserId(player)
	local target_id = vRP.prompt(player,"ID: ","")
	if target_id ~= nil and target_id ~= "" then 
		local value = vRP.getUData(parseInt(target_id),"vRP:prisao")
		local target = vRP.getUserSource(tonumber(target_id))
		local tempo = json.decode(value) or 0
		if parseInt(tempo) >= 1 then
			vRP.setUData(tonumber(target_id),"vRP:prisao",json.encode(-1))
			TriggerClientEvent('prisioneiro',target,false)
			TriggerClientEvent('chatMessage', player, 'PRISAO', { 0, 0, 0 }, '^2Você tirou o jogador da prisão.')
			vRP.log("nzk_logs/policia/tirarprisao.txt", "O Policial [ID:"..user_id.." retirou o [ID: "..target_id.." da prisão.")
		else
			TriggerClientEvent('chatMessage', player, '^2O Jogador nao esta preso')
		end
	else
		TriggerClientEvent('chatMessage', player, '^2Digite Corretamente.')
	end
end}

local choice_algemar = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,5)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			if vRPclient.isHandcuffed(nplayer) then
				if vRP.tryGetInventoryItem(user_id, "chave_algemas", 1) then
					vRP.giveInventoryItem(user_id, "algemas", 1)
					TriggerClientEvent("vrp_sound:source",player,'uncuff',0.4)
					TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.4)
					vRPclient.setHandcuffed(nplayer, false)
					TriggerClientEvent('chatMessage', player, '^2Você desalgemou o jogador proximo.')
				else
					TriggerClientEvent('chatMessage', player, '^2Você não possui chave de algemas.')
				end
				else
					if vRP.tryGetInventoryItem(user_id, "algemas", 1) then
						TriggerClientEvent('cancelando',player,true)
						TriggerClientEvent('cancelando',nplayer,true)
						TriggerClientEvent('carregar',nplayer,player)
						vRPclient._playAnim(player,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
						vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
						vRP.giveInventoryItem(user_id, "chave_algemas", 1)
						SetTimeout(3500,function()
							vRPclient._stopAnim(player,false)
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent('carregar',nplayer,player)
							TriggerClientEvent('cancelando',player,false)
							TriggerClientEvent('cancelando',nplayer,false)
							TriggerClientEvent("vrp_sound:source",player,'cuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
						end)
					else
						TriggerClientEvent('chatMessage', player, '^2Você não possui algemas.')
					end
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
	end
end}

local choice_revistar = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,5)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			TriggerClientEvent('chatMessage', nplayer, '^2O Policial está te revistando.')
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

        vRPclient.setDiv(player,"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }","<em>Dinheiro: </em>$"..money.."<br /><br /><em>Inventário: </em>"..items.."<br /><br /><em>Armas Equipadas: </em>"..weapons_info.."")
				
				local ok = vRP.request(player,"Esconder revista",1000)
					if ok then
							vRPclient.removeDiv(player,{"police_check"})
						else
							vRPclient.removeDiv(player,{"police_check"})
					end
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
	end
end}

local choice_arrastar = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		if nplayer then
			if vRPclient.isHandcuffed(nplayer) then
				TriggerClientEvent('carregar',nplayer,player)
			else
				TriggerClientEvent('chatMessage', player, '^2O Jogador não está algemado.')
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
end}

local choice_cnhcheck = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			local ok = vRP.request(nplayer,"O Policial está pedindo sua CNH deseja aceitar ?",1000)
					if ok then
						if vRP.hasGroup(nuser_id, "CNH") then
							TriggerClientEvent('chatMessage', player, '^2Documento CNH: ^5Tudo Certo')
						else 
							TriggerClientEvent('chatMessage', player, '^2Documento CNH: ^9Não obtida')
						end
					else
						TriggerClientEvent('chatMessage', player, '^2O Individuo não quer mostrar sua CNH.')
					end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
end}

local choice_cnhretirar = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		local nuser_id = vRP.getUserId(nplayer)
		local ok = vRP.request(player,"Tem certeza que deseja remover a CNH deste cidadao ?",1000)
		if ok then
			if nplayer then
				vRP.removeUserGroup(nuser_id,"CNH")
				TriggerClientEvent('chatMessage', player, '^2Você confiscou a CNH do [ID:' ..nuser_id..'].')
				TriggerClientEvent('chatMessage', nplayer, '^9Sua CNH foi confiscada.')
				vRP.log("nzk_logs/policia/retirarcnh.txt", "O Policial [ID:"..user_id.." retirou a CNH do [ID: "..nuser_id.."].")
			else
				TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
			end
		end

end}

local choice_parmasadd = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			TriggerClientEvent('chatMessage', player, '^2Você enviou a proposta de porte de armas pro [ID:' ..nuser_id..']')
			local ok = vRP.request(nplayer, "O Policial de Civil está te vendendo o porte de armas por $ 60.000, deseja aceitar?", 30)
			if ok then
				if vRP.tryPayment(nuser_id, 60000) then
					vRP.addUserGroup(nuser_id,"Porte de Arma")
					TriggerClientEvent('chatMessage', player, '^2Comprou o porte de armas.')
					TriggerClientEvent('chatMessage', nplayer, '^2Agora você possui um porte de armas.')
					vRP.log("nzk_logs/policia/addportearmas.txt", "O Policial [ID:"..user_id.." adicionou porte de armas no [ID: "..nuser_id.."].")
				else
					TriggerClientEvent('chatMessage', player, '^2O jogador não possui 60.000.')
				end
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
end}

local choice_parmascheck = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			local ok = vRP.request(nplayer,"O Policial está pedindo seu Porte de Armas deseja aceitar ?",1000)
					if ok then
						if vRP.hasGroup(nuser_id, "Porte de Arma") then
							TriggerClientEvent('chatMessage', player, '^2Porte de Armas: ^5Tudo Certo')
						else 
							TriggerClientEvent('chatMessage', player, '^2Porte de Armas: ^9Não obtida')
						end
					else
						TriggerClientEvent('chatMessage', player, '^2O Individuo não quer mostrar seu Porte de Armas.')
					end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
end}

local choice_parmasretirar = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		local nuser_id = vRP.getUserId(nplayer)
		local ok = vRP.request(player,"Tem certeza que deseja remover o porte de armas deste cidadao ?",1000)
		if ok then
			if nplayer then
				vRP.removeUserGroup(nuser_id,"Porte de Arma")
				TriggerClientEvent('chatMessage', player, '^2Você confiscou o Porte de armas do [ID:' ..nuser_id..'].')
				TriggerClientEvent('chatMessage', nplayer, '^9Seu Porte de armas foi confiscado.')
				vRP.log("nzk_logs/policia/retirarparmas.txt", "O Policial [ID:"..user_id.." retirou o Porte de armas do [ID: "..nuser_id.."].")
			else
				TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
			end
		end
end}

local choice_apreenderarmas = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient.giveWeapons(nplayer,{},true)
				TriggerClientEvent('chatMessage', player, '^5As armas foram apreendidas.')
				TriggerClientEvent('chatMessage', nplayer, '^9Suas armas foram apreendidas.')
			else
				TriggerClientEvent('chatMessage', player, '^2O Jogador não está algemado.')
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
end}

local choice_apreenderitens = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			if vRPclient.isHandcuffed(nplayer) then

				local inv = vRP.getInventory(nuser_id)
				for k,v in pairs(itemlist) do
					local sub_items = { v }
					if string.sub(v,1,1) == "*" then
						local idname = string.sub(v,2)
						sub_items = {}
						for fidname,_ in pairs(inv) do
							if splitString(fidname,"|")[1] == idname then
								table.insert(sub_items,fidname)
							end
						end
					end

					for _,idname in pairs(sub_items) do
						local amount = vRP.getInventoryItemAmount(nuser_id,idname)
						if amount > 0 then
							local item_name,item_weight = vRP.getItemDefinition(idname)
							if item_name then
								vRP.tryGetInventoryItem(nuser_id,idname,amount)
							end
						end
					end
				end

				TriggerClientEvent('chatMessage', player, '^5Os itens ilegais foram apreendidos.')
				TriggerClientEvent('chatMessage', nplayer, '^9Seus itens ilegais foram apreendidos')
			else
				TriggerClientEvent('chatMessage', player, '^2O Jogador não está algemado.')
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
end}

local choice_colocarveiculo = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient.putInNearestVehicleAsPassenger(nplayer, 5)
				TriggerClientEvent('hud:Colocar:Cinto', nplayer, true)
			else
				TriggerClientEvent('chatMessage', player, '^2O Jogador não está algemado.')
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
end}

local choice_retirarveiculo = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local nplayer = vRPclient.getNearestPlayer(player,4)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient.ejectVehicle(nplayer, {})
				TriggerClientEvent('hud:Colocar:Cinto', nplayer, false)
			else
				TriggerClientEvent('chatMessage', player, '^2O Jogador não está algemado.')
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
end}

local choice_consultarplaca = {function(player,choice)
	local user_id = vRP.getUserByRegistration(player)
	local mPlaca,mName,mNet,mPrice,mBanido,mLock,mModel,mStreet = vRPclient.ModelName(player,7)
	local placa_user = vRP.getUserByRegistration(mPlaca)
	if mPlaca then
		if placa_user then
			local identity = vRP.getUserIdentity(placa_user)
			if identity then
				vRPclient.playSound(player,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent('chatMessage',player,"COPOM",{65,130,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Placa inválida.')
		end
	end
end}

local choice_apreenderveiculo = {function(player,choice)
	local user_id = vRP.getUserId(player)
		local placa,vname,mNet = vRPclient.ModelName(player,7)
		local placa_user = vRP.getUserByRegistration(placa)
		if placa_user then
			if vname then
				local rows = vRP.query("vRP/get_vehicle",{ user_id = placa_user, vehicle = vname })
				if #rows > 0 then
					if rows[1].detido == 2 then
						TriggerClientEvent('chatMessage', player, '^9Este veículo já se encontra detido.')
					else
						vRP.execute("vRP/set_detido",{ user_id = placa_user, vehicle = vname, detido = 2})
						TriggerClientEvent('chatMessage', player, '^5Veículo detido com sucesso.')
						TriggerClientEvent('syncdeleteveh',-1,mNet) 
						vRP.log("nzk_logs/policia/apreenderveiculo.txt", "O Policial [ID:"..user_id.." apreendeu o veiculo "..placa_user..".")
					end
				end
			end
		end
end}

local choice_pedirrg = {function(player,choice)
    local user_id = vRP.getUserId(player)
    local nplayer = vRPclient.getNearestPlayer(player,2)
    if nplayer then
        local nuser_id = vRP.getUserId(nplayer)
		TriggerClientEvent('chatMessage', player, "^2Você pediu o rg...")
		TriggerClientEvent('chatMessage', nplayer, "^2O Policial [ID:"..user_id.."] pegou seu RG")
            if nuser_id then
                local identity = vRP.getUserIdentity(nuser_id)
                local carteira = vRP.getMoney(nuser_id)
                local value = vRP.getUData(nuser_id,"vRP:multas")
                local valormultas = json.decode(value) or 0

                vRPclient.setDiv(player,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #99cc00; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
                vRP.request(player,"Você deseja fechar o registro geral?",1000)
                vRPclient.removeDiv(player,"completerg")
            end
    else
    TriggerClientEvent('chatMessage', player, "^2Nenhum jogador proximo.")
    end
end}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MECANICO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local choice_repaircar = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if not vRPclient.isInVehicle(player) then
		local vehicle = vRPclient.getNearestVehicle(player,7)
		if vRP.hasPermission(user_id,"perm.mecanico") then
			if vRPclient.checkOffSetAndHoodOpen(player,vehicle,true) then
				TriggerClientEvent('cancelando',player,true)
				vRPclient._playAnim(player,false,{{"mini@repair","fixing_a_player"}},true)
				TriggerClientEvent("progress",player,30000,"reparando")
				SetTimeout(30000,function() 
					TriggerClientEvent('cancelando',player,false) 
					TriggerClientEvent('reparar',player,vehicle) 
					vRPclient._stopAnim(player,false) 
					TriggerClientEvent('chatMessage', player, "^2Você reparou o veiculo.")
				end)
			else
				TriggerClientEvent('chatMessage', player, "^2Voce precisa estar na frente/traz do veiculo.")
			end
		end
	else
		TriggerClientEvent('chatMessage', player, "^2Precisa estar próximo ou fora do veículo para efetuar os reparos.")
	end
end}
RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)

local choice_repairmotor = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if not vRPclient.isInVehicle(player) then
		local vehicle = vRPclient.getNearestVehicle(player,7)
		if vRP.hasPermission(user_id,"perm.mecanico") then
			if vRPclient.checkOffSetAndHoodOpen(player,vehicle,true) then
				TriggerClientEvent('cancelando',player,true)
				vRPclient._playAnim(player,false,{{"mini@repair","fixing_a_player"}},true)
				TriggerClientEvent("progress",player,30000,"reparando")
				SetTimeout(30000,function() 
					TriggerClientEvent('cancelando',player,false) 
					TriggerClientEvent('repararmotor',player,vehicle) 
					vRPclient._stopAnim(player,false) 
					TriggerClientEvent('chatMessage', player, "^2Você consertou o motor do veiculo.")
				end)
			else
				TriggerClientEvent('chatMessage', player, "^2Voce precisa estar na frente/traz do veiculo.")
			end
		end
	else
		TriggerClientEvent('chatMessage', player, "^2Precisa estar próximo ou fora do veículo para efetuar os reparos.")
	end
end}

local choice_revistar2 = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		local nplayer = vRPclient.getNearestPlayer(player,5)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			TriggerClientEvent('chatMessage', player, '^2Você pediu para revistar o [ID:'..nuser_id..'].')
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

				vRPclient.setDiv(player,"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 3px; margin: auto; margin-top: 10px; }","<em>Dinheiro: </em>$"..money.."<br /><br /><em>Inventário: </em>"..items.."<br /><br /><em>Armas Equipadas: </em>"..weapons_info.."")

				local ok = vRP.request(player,"Esconder revista",1000)
				if ok then
				vRPclient.removeDiv(player,{"police_check"})
				else
				vRPclient.removeDiv(player,{"police_check"})
				end
			end
			else
			TriggerClientEvent('chatMessage', player, '^2O Jogador não aceitou a revista')
			end
		else
			TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
		end
	end
end}

local choice_roubar = {function(player,choice)
    local user_id = vRP.getUserId(player)
    local nplayer = vRPclient.getNearestPlayer(player,1)
    if nplayer then
        local nuser_id = vRP.getUserId(nplayer)
        if vRPclient.isInComa(nplayer) and not vRPclient.isInComa(player) then
            if not vRPclient.isInSafeZone(player) then
                vRPclient._playAnim(player,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
                TriggerClientEvent('cancelando',player,true)
                TriggerClientEvent("progress",player,30000,"roubando")
                TriggerClientEvent('chatMessage', player, '^2Você está roubando.')
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
                                        TriggerClientEvent('cancelando',player,false)
                                        TriggerClientEvent('chatMessage', player, '^2Mochila não suporta '..vRP.format(parseInt(v.amount)) or 0 ..'x '..vRP.getItemName(k) or 0 ..' por causa do peso.')
                                        vRPclient._stopAnim(player,false)
                                        vRPclient._stopAnim(nplayer,false)
                                    else
                                        vRPclient._stopAnim(player,false)
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
                            TriggerClientEvent('cancelando',player,false)
                            TriggerClientEvent('chatMessage', player, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                        end
                        if v.ammo > 0 then
                            vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
                            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
                                if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
                                    vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
                                    vRP.log("nzk_logs/player/saquear.txt","**MUNICAO** O [ID: "..user_id.."] Saqueou o [ID: "..nuser_id.."] e levou "..k.." ".. v.amount.."x")
                                end
                            else
                                TriggerClientEvent('cancelando',player,false)
                                TriggerClientEvent('chatMessage', player, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                            end
                        end
                    end

                    local nmoney = vRP.getMoney(nuser_id)
                    if vRP.tryPayment(nuser_id,nmoney) then
                        vRP.giveMoney(user_id,nmoney)
                        vRP.log("nzk_logs/player/saquear.txt","**DINHEIRO** O [ID: "..user_id.."] Saqueou o [ID: "..nuser_id.."] e levou "..nmoney.."")
                    end
                    vRPclient._setStandBY(player,parseInt(600))
                    vRPclient._stopAnim(player,false)
                    TriggerClientEvent('cancelando',player,false)
                    TriggerClientEvent('chatMessage', nplayer, '^9Você foi roubado pelo (ID:'..user_id..').')
                    TriggerClientEvent('chatMessage', player, '^5Roubo concluido com sucesso.')
                end)
            else
                TriggerClientEvent('chatMessage', player, '^2Você não pode fazer isso em uma ^9SAFE-ZONE.')
            end
        else
            if not vRPclient.isInSafeZone(player) then
                if not vRPclient.isInComa(player) then
                    vRPclient._playAnim(player,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true)
                    vRPclient._playAnim(nplayer,false,{{"mp_arresting","idle",1}},true)
                    TriggerClientEvent('cancelando',player,true)
                    TriggerClientEvent("progress",player,30000,"roubando")
                    TriggerClientEvent('chatMessage', player, '^2Você está assaltando.')
                    TriggerClientEvent('chatMessage', nplayer, '^2Você está sendo assaltado.')
                    TriggerEvent("NZK:desequiparArmas", nplayer)
                    SetTimeout(30000,function()
                        vRPclient._setStandBY(source,parseInt(500))
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
                                            TriggerClientEvent('cancelando',player,false)
                                            TriggerClientEvent('chatMessage', player, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                                            vRPclient._stopAnim(player,false)
                                            vRPclient._stopAnim(nplayer,false)
                                        else
                                            vRPclient._stopAnim(player,false)
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
                                TriggerClientEvent('cancelando',player,false)
                                TriggerClientEvent('chatMessage', player, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                            end
                            if v.ammo > 0 then
                                vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
                                if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
                                    if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
                                        vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
                                        vRP.log("nzk_logs/player/assaltar.txt","**MUNICAO** O [ID: "..user_id.."] Assaltou o [ID: "..nuser_id.."] e levou "..k.." ".. v.amount.."x")
                                    end
                                else
                                    TriggerClientEvent('cancelando',player,false)
                                    TriggerClientEvent('chatMessage', player, '^2Mochila não suporta '..vRP.format(parseInt(v.amount))..'x '..vRP.getItemName(k)..' por causa do peso.')
                                end
                            end
                        end
                        local nmoney = vRP.getMoney(nuser_id)
                        if vRP.tryPayment(nuser_id,nmoney) then
                            vRP.giveMoney(user_id,nmoney)
                            vRP.log("nzk_logs/player/assaltar.txt","**DINHEIRO** O [ID: "..user_id.."] Assaltou o [ID: "..nuser_id.."] e levou "..nmoney.."")
                        end
                        vRPclient._setStandBY(player,parseInt(600))
                        vRPclient._stopAnim(player,false)
                        vRPclient._stopAnim(nplayer,false)
                        TriggerClientEvent('cancelando',player,false)
                        TriggerClientEvent('chatMessage', nplayer, '^9Você foi roubado pelo (ID:'..user_id..').')
                        TriggerClientEvent('chatMessage', player, '^5Assalto concluido com sucesso.')
                    end)
                end
            else
                TriggerClientEvent('chatMessage', player, '^2Você não pode fazer isso em uma ^9SAFE-ZONE.')
            end
        end
    else
        TriggerClientEvent('chatMessage', player, '^2Nenhum jogador proximo.')
    end
end}


RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor",-1,nveh)
end)

local choice_rebocar = {function(player,choice)
	TriggerClientEvent("rebocar",player)
end}
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
------------------------------------------------------------------------------------------------------------------------------------------------
-- MENUS
------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.abrirSamuMenu(source)
	local menudata = vRP.buildMenu("samu_menu", {player = source})
	menudata.name = "HOSPITAL"
	vRP.openMenu(source,menudata)
end

vRP._registerMenuBuilder("samu_menu", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id then
		local choices = {}
		choices["1. Primeiros Socorros"] = choice_primeiroSocorros 
		choices["2. Carregar Paciente"] = choice_carregarPaciente 
		choices["3. Soltar Paciente"] = choice_soltarPaciente 
		choices["4. Colocar no Veículo"] = choice_colocarPaciente 
		choices["5. Tirar do Veículo"] = choice_tirarPaciente 
		choices["6. Realizar Tratamento"] = choice_tratamentoPaciente
		choices["7. Arrastar"] = choice_arrastar 
		add(choices)
	end
end)

function vRP.abrirPoliciaMenu(source)
	local menudata = vRP.buildMenu("policia_menu", {player = source})
	menudata.name = "Policia"
	vRP.openMenu(source,menudata)
end

vRP._registerMenuBuilder("policia_menu", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id then
		local choices = {}
		choices["01. Pedir RG"] = choice_pedirrg
		choices["02. Revistar"] = choice_revistar
		choices["03. Algemar/Desalgemar"] = choice_algemar
		choices["04. Arrastar"] = choice_arrastar
		choices["05. Colocar no Veiculo"] = choice_colocarveiculo
		choices["06. Retirar do Veiculo"] = choice_retirarveiculo
		choices["07. Multar"] = choice_multar
		choices["08. Cobrar Multa"] = choice_multar2
		choices["09. Apreender Armas"] = choice_apreenderarmas
		choices["10. Apreender Itens"] = choice_apreenderitens
		choices["11. Prender"] = choice_prisao 
		choices["12. Liberar da Prisão"] = choice_tirarprisao 
		choices["13. Checar CNH"] = choice_cnhcheck
		choices["14. Retirar CNH"] = choice_cnhretirar
		choices["15. Consultar Placa"] = choice_consultarplaca
		choices["16. Checar Porte"] = choice_parmascheck
		choices["17. Retirar Porte"] = choice_parmasretirar 
		choices["18. Apreender Veiculo"] = choice_apreenderveiculo 
		if vRP.hasGroup(user_id, "Comandante [CIVIL]") or vRP.hasGroup(user_id, "Delegado [CIVIL]") or vRP.hasGroup(user_id, "Comandante [CPTR]") or vRP.hasGroup(user_id, "Delegado [CPTR]") then 
			choices["18. Adicionar Porte"] = choice_parmasadd 
		end
		add(choices)
	end
end)
-- prf menu 
vRP._registerMenuBuilder("policia_menu", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id then
		local choices = {}
		choices["01. Pedir RG"] = choice_pedirrg
		choices["02. Revistar"] = choice_revistar
		choices["03. Algemar/Desalgemar"] = choice_algemar
		choices["04. Arrastar"] = choice_arrastar
		choices["05. Colocar no Veiculo"] = choice_colocarveiculo
		choices["06. Retirar do Veiculo"] = choice_retirarveiculo
		choices["07. Multar"] = choice_multar
		choices["08. Cobrar Multa"] = choice_multar2
		choices["09. Apreender Armas"] = choice_apreenderarmas
		choices["10. Apreender Itens"] = choice_apreenderitens
		choices["11. Prender"] = choice_prisao 
		choices["12. Liberar da Prisão"] = choice_tirarprisao 
		choices["13. Checar CNH"] = choice_cnhcheck
		choices["14. Retirar CNH"] = choice_cnhretirar
		choices["15. Consultar Placa"] = choice_consultarplaca
		choices["16. Checar Porte"] = choice_parmascheck
		choices["17. Retirar Porte"] = choice_parmasretirar 
		choices["18. Apreender Veiculo"] = choice_apreenderveiculo 
		if vRP.hasGroup(user_id, "Comandante [PRF]") or vRP.hasGroup(user_id, "Agente Especial [PRF]") or vRP.hasGroup(user_id, "Comandante [PRFPTR]") or vRP.hasGroup(user_id, "Agente Especial [PRFPTR]") then 
			choices["18. Adicionar Porte"] = choice_parmasadd 
		end
		add(choices)
	end
end)
function vRP.abrirMecanicoMenu(source)
	local menudata = vRP.buildMenu("mecanico_menu", {player = source})
	menudata.name = "Mecanico"
	vRP.openMenu(source,menudata)
end

vRP._registerMenuBuilder("mecanico_menu", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id then
		local choices = {}
		choices["Reparar Veiculo"] = choice_repaircar 
		choices["Reparar Motor"] = choice_repairmotor 
		choices["Rebocar Veiculo"] = choice_rebocar 
		add(choices)
	end
end)

function vRP.abrirCetMenu(source)
	local menudata = vRP.buildMenu("cet_menu", {player = source})
	menudata.name = "C.E.T"
	vRP.openMenu(source,menudata)
end

vRP._registerMenuBuilder("cet_menu", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id then
		local choices = {}
		choices["Apreender Veiculo"] = choice_apreenderveiculo 
		choices["Consultar Veiculo"] = choice_consultarplaca 
		choices["Rebocar Veiculo"] = choice_rebocar 
		choices["Multar"] = choice_multar
		choices["Remover CNH"] = choice_cnhretirar
		choices["Checar CNH"] = choice_cnhcheck
		choices["Pedir RG"] = choice_pedirrg
		add(choices)
	end
end)

function vRP.abrirIlegalMenu(source)
	local menudata = vRP.buildMenu("ilegal_menu", {player = source})
	menudata.name = "Ilegal"
	vRP.openMenu(source,menudata)
end

vRP._registerMenuBuilder("ilegal_menu", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id then
		local choices = {}
		choices["Algemar/Desalgemar"] = choice_algemar 
		choices["Arrastar"] = choice_arrastar
		choices["Revistar"] = choice_revistar2
		choices["Roubar"] = choice_roubar
		add(choices)
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR MENUS
------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("menuadm",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") then
			if args[1] == "policia" then
				vRP.abrirPoliciaMenu(source)
			elseif args[1] == "unizk" then
				vRP.abrirSamuMenu(source)
			elseif args[1] == "mecanico" then
				vRP.abrirMecanicoMenu(source)
			elseif args[1] == "cet" then
				vRP.abrirCetMenu(source)
			elseif args[1] == "ilegal" then
				vRP.abrirIlegalMenu(source)
				
			end
		end
	end
end)

RegisterCommand("menu",function(source,args)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id, "perm.policia") then
			vRP.abrirPoliciaMenu(source)
		elseif vRP.hasPermission(user_id, "perm.civil") then
			vRP.abrirPoliciaMenu(source)
		elseif vRP.hasPermission(user_id, "perm.unizk") then
			vRP.abrirSamuMenu(source)
		elseif vRP.hasPermission(user_id, "perm.mecanico") then
			vRP.abrirMecanicoMenu(source)
		elseif vRP.hasPermission(user_id, "perm.cet") then
			vRP.abrirCetMenu(source)
		elseif vRP.hasPermission(user_id, "perm.prf") then
			vRP.abrirPoliciaMenu(source)
		elseif vRP.hasPermission(user_id, "perm.ballas") then
			vRP.abrirIlegalMenu(source)
		end
	end
end)

function vRPmenuC.openMenu()
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id, "perm.policia") then
			vRP.abrirPoliciaMenu(source)
		elseif vRP.hasPermission(user_id, "perm.civil") then
			vRP.abrirPoliciaMenu(source)
		elseif vRP.hasPermission(user_id, "perm.unizk") then
			vRP.abrirSamuMenu(source)
		elseif vRP.hasPermission(user_id, "perm.mecanico") then
			vRP.abrirMecanicoMenu(source)
		elseif vRP.hasPermission(user_id, "perm.prf") then
			vRP.abrirPoliciaMenu(source)
		elseif vRP.hasPermission(user_id, "perm.driftking") or vRP.hasPermission(user_id, "perm.ballas") or vRP.hasPermission(user_id, "perm.cv") or vRP.hasPermission (user_id, "perm.motoclube") or vRP.hasPermission (user_id, "perm.dragons") or vRP.hasPermission(user_id, "perm.vagos") or vRP.hasPermission(user_id, "perm.bratva") or vRP.hasPermission(user_id, "perm.yakuza") or vRP.hasPermission(user_id, "perm.tequilala") or vRP.hasPermission(user_id, "perm.vanilla") then
			vRP.abrirIlegalMenu(source) 
		end
	end
end

function vRPmenuC.checkBarricade()
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id, "perm.policia") then
			return true
		elseif vRP.hasPermission(user_id, "perm.civil") then
			return true
		elseif vRP.hasPermission(user_id, "perm.prf") then
			return true
		elseif vRP.hasPermission(user_id, "perm.cet") then
			return true
		elseif vRP.hasPermission(user_id, "admin.permissao") then
			return true
		elseif vRP.hasPermission(user_id, "moderador.permissao") then
			return true
		elseif vRP.hasPermission(user_id, "ajudante.permissao") then
			return true
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local player = vRP.getUserSource(parseInt(user_id))
	if player then
		SetTimeout(30000,function()
			local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
			local tempo = json.decode(value) or 0
				if tonumber(tempo) > 0 then
					TriggerClientEvent('prisioneiro',player,true)
					vRPclient.teleport(player,1680.1,2513.0,46.5)
					TriggerClientEvent('chatMessage', player, 'PRISAO', { 0, 0, 0 }, '^2Termine sua sentença.')
					prison_lock(parseInt(user_id))
				end
		end)
	end
end)

function prison_lock(target_id)
	local player = vRP.getUserSource(parseInt(target_id))
	if player then
		SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(target_id),"vRP:prisao")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent('chatMessage', player, 'PRISAO', { 0, 0, 0 }, '^2Você Ainda vai passar '..parseInt(tempo)..' meses preso.')
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(parseInt(tempo)-1))
				prison_lock(parseInt(target_id))
				vRP.addUserGroup(parseInt(target_id), "NSalario")
				vRPclient.setHealth(player,300)
				vRP.setHunger(parseInt(target_id), 0)
				vRP.setThirst(parseInt(target_id), 0)
			elseif parseInt(tempo) == 0  or parseInt(tempo) == -1 then
				vRP.removeUserGroup(parseInt(target_id), "NSalario")
				TriggerClientEvent('prisioneiro',player,false)
				vRPclient.teleport(player,1850.5,2604.0,45.5)
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(-1))
				TriggerClientEvent('chatMessage', player, 'PRISAO', { 0, 0, 0 }, '^2Sua sentença terminou, esperamos não ve-lo novamente.')
			end
			vRPclient.killGod(player)
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUIR PENA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("diminuirpena1703")
AddEventHandler("diminuirpena1703",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0
	if tempo >= 5 then
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo)-2))
		TriggerClientEvent('chatMessage', source, 'PRISAO', { 0, 0, 0 }, '^2Sua pena foi reduzida em 2 meses, continue o trabalho.')
	else
		TriggerClientEvent('chatMessage', source, 'PRISAO', { 0, 0, 0 }, '^2Atingiu o limite da redução de pena, não precisa mais trabalhar.')
	end
end)