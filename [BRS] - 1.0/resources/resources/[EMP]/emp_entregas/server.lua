local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("farm_civil",emP)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdrugs = "https://discordapp.com/api/webhooks/747779700532838430/0V0MUFgTVwS2j243MSdLI9GFXuN-BUAyO43oDIfIMBG5uWI3xOxLZcQ2CcA7ClvOqofH"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(1,10)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return user_id
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkItens()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        return vRP.getInventoryItemAmount(user_id,"weed") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"md") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"cocaine") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"carnetartaruga") >= quantidade[source]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("perm.policia")
	local bonus = 0

	if #policia >= 0 and #policia <= 3 then
        bonus = 850
    elseif #policia >= 4 and #policia <= 6 then
        bonus = 950
    elseif #policia >= 7 and #policia <= 10 then
		bonus = 1050
	elseif #policia >= 10 and #policia <= 13 then
        bonus = 1150
    elseif #policia > 13 then
        bonus = 1250
    end

	if user_id then
		if vRP.tryGetInventoryItem(user_id,"weed",quantidade[source]) or vRP.tryGetInventoryItem(user_id,"md",quantidade[source]) or vRP.tryGetInventoryItem(user_id,"cocaine",quantidade[source]) or vRP.tryGetInventoryItem(user_id,"carnetartaruga",quantidade[source]) then
			vRP.giveInventoryItem(user_id,"dirty_money", (parseInt(100) + bonus) * quantidade[source])
		end
		quantidade[source] = nil
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local soldado = vRP.getUsersByPermission("perm.policia")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Recebemos uma denuncia de tráfico, verifique o ocorrido.")
					SetTimeout(20000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
		SendWebhookMessage(webhookdrugs,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FOI DENUNCIADO] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end