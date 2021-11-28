local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRP._prepare("vRP/mask_setMask", "UPDATE vrp_users SET mascara=@maskModelNumber WHERE id = @id")
vRP._prepare("vRP/mask_search", "SELECT * FROM vrp_users WHERE id = @id")
vMask = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- /e
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('e', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if not vRPclient.isInComa(source) and not vRPclient.isInUTI(source) then
		TriggerClientEvent("emotes",source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /e2
-----------------------------------------------------------------------------------------------------------------------------------------
local animList = {
	{ ["anim"] = "comprimentar", ["nome"] = "te <b>Comprimentar</b>", ["anim1"] = "mp_common", ["anim2"] = "givetake1_a", ["sync"] = 0.8, ["block"] = false, ["tempo"] = 2, ["distancia"] = 1  },
	{ ["anim"] = "abracar", ["nome"] = "te <b>Abracar</b>", ["anim1"] = "mp_ped_interaction", ["anim2"] = "hugs_guy_a", ["sync"] = 0.9	, ["block"] = false, ["tempo"] = 2, ["distancia"] = 1  },
	{ ["anim"] = "beijar", ["nome"] = "te <b>Beijar</b>", ["anim1"] = "mp_ped_interaction", ["anim2"] = "kisses_guy_a", ["block"] = false, ["sync"] = 1.3, ["tempo"] = 5, ["distancia"] = 1  },
	{ ["anim"] = "tapa", ["nome"] = "te dar um <b>Tapa</b>", ["anim1"] = "melee@unarmed@streamed_variations", ["anim2"] = "plyr_takedown_front_backslap", ["block"] = true, ["sync"] = 1.3, ["tempo"] = 1, ["distancia"] = 1 },
	{ ["anim"] = "murro", ["nome"] = "te dar um <b>Murro</b>", ["anim1"] = "melee@unarmed@streamed_variations", ["anim2"] = "plyr_takedown_rear_lefthook", ["block"] = true, ["sync"] = 0.9, ["tempo"] = 1, ["distancia"] = 1 },
	{ ["anim"] = "dancar1", ["nome"] = "<b>Dancar</b>", ["anim1"] = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", ["anim2"] = "high_center", ["block"] = false, ["sync"] = 1.2, ["tempo"] = 60, ["distancia"] = 2 },
	{ ["anim"] = "dancar2", ["nome"] = "<b>Dancar</b>", ["anim1"] = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", ["anim2"] = "low_center", ["block"] = false, ["sync"] = 0.6, ["tempo"] = 60, ["distancia"] = 2 },
}

RegisterCommand('e2', function(source,args)
	local user_id = vRP.getUserId(source)
	local comando = ""
	local arrayLenght = tablelength(animList)
	if user_id then

		for k,v in pairs(animList) do
			if args[1] == v.anim then
				local nplayer = vRPclient.getNearestPlayer(source,v.distancia)
				local nuser_id = vRP.getUserId(nplayer)
				
				if nplayer then
					
					local ok = vRP.request(nplayer, "O [ID: "..user_id.."] está pedindo para "..v.nome.."", 5)
					if ok then
						TriggerClientEvent("NZK:EmotesDupla", nplayer, v.sync)
						vRPclient._playAnim(source,false,{{v.anim1,v.anim2}},true)

						if not v.block then
							vRPclient._playAnim(nplayer,false,{{v.anim1,v.anim2}},true)
							SetTimeout(v.tempo*1000, function() vRPclient._stopAnim(nplayer, false) vRPclient._stopAnim(source, false) end)
						else
							if v.anim == "tapa" then
								vRPclient._playAnim(nplayer,false,{{"melee@unarmed@streamed_variations","victim_takedown_front_slap"}},true)
								SetTimeout(v.tempo*1000, function()
									vRPclient._stopAnim(source, false)
									vRPclient._playScreenEffect(nplayer, "Rampage", 5)
									SetTimeout(1.2*1000, function()
										vRPclient._stopAnim(nplayer, false)
										TriggerClientEvent("NZK:ragDoll", nplayer, 8)
									end)
								end)
							elseif v.anim == "murro" then
								SetTimeout(400, function()
									vRPclient._playAnim(nplayer,false,{{"melee@unarmed@streamed_variations","victim_takedown_front_cross_r"}},true)
									vRPclient._playScreenEffect(nplayer, "Rampage", 17)
									SetTimeout(v.tempo*1000, function()
										vRPclient._stopAnim(source, false)
										SetTimeout(1*1000, function()
											vRPclient._stopAnim(nplayer, false)
											TriggerClientEvent("NZK:ragDoll", nplayer, 15)
										end)
									end)
								end)
								
							end
						end

					else
						TriggerClientEvent('chatMessage',source, "^9O Player recusou a ação.")
					end
				else
					TriggerClientEvent('chatMessage',source, "^2Nenhum jogador proximo.")
				end
			end
			if arrayLenght ~= k then
				comando = comando.. " ^2/e2 ^5"..v.anim.. "^2 | " 
			else
				comando = comando.. " ^2/e2 ^5"..v.anim.. "^2."
			end
		end
		if args[1] == "lista" then
			TriggerClientEvent('chatMessage',source, "^9LISTA DE ANIMAÇÃO: " ..comando)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /e3
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('e3',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer and args[2] then
				TriggerClientEvent("emotes",nplayer,args[2])
			else
				local nplayer2 = vRPclient.getNearestPlayer(source,5)
				if nplayer2 then
					TriggerClientEvent("emotes",nplayer2,args[1])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /limpar
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpar', function(source, args, rawCommand)
	CancelEvent() 
	TriggerClientEvent("NZK:cancel", source)
	TriggerClientEvent("NZK:cancelarAcademia", source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIRAR ROUPA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tirarcamiseta', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local ok = vRP.request(source, "Você deseja tirar a camiseta ?",30)
		if ok then
			CancelEvent()
			TriggerClientEvent("NZK:TirarCamiseta", source)
		end
	end
end)

RegisterCommand('tirarcalca', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local ok = vRP.request(source, "Você deseja tirar a calca ?",30)
		if ok then
			CancelEvent()
			TriggerClientEvent("NZK:TirarCalca", source)
		end
	end
end)

RegisterCommand('tirarsapato', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local ok = vRP.request(source, "Você deseja tirar o sapato ?",30)
		if ok then
			CancelEvent()
			TriggerClientEvent("NZK:TirarSapato", source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PANO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryclean")
AddEventHandler("tryclean",function(nveh)
	TriggerClientEvent("syncclean",-1,nveh)
end)

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end