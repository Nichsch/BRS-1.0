local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_produzir",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE = ITEM QUE PRECISA
-- REQTD = QUANTIDADE QUE PRECISA
-- ITEM = ITEM QUE VAI RECEBER
-- ITEMQTD = QUANTIDADE DO ITEM QUE VAI RECEBER
-- PRICE = VALOR DO CUSTO DO ITEM
-- PERMISSAO = PERMISSAO PRA EXECUTAR ESSA FUNCAO

local src = {
-- IAA
	[1] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "rgfalso", ['itemqtd'] = 1, ['price'] = 5000, ['permissao'] = "perm.iaa" },
	[2] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "escudo", ['itemqtd'] = 1, ['price'] = 30000, ['permissao'] = "perm.iaa" },
-- UNIZK
	[3] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "dipiroca", ['itemqtd'] = 2, ['price'] = 500, ['permissao'] = "perm.unizk" },
	[4] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "navagina", ['itemqtd'] = 2, ['price'] = 500, ['permissao'] = "perm.unizk" },
-- DRIFTKING E MOTOCLUBE
	[5] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "pacote_ilegal", ['itemqtd'] = 1, ['price'] = 1000, ['permissao'] = "perm.dkmc" },
	[6] = { ['re'] = "pacote_ilegal", ['reqtd'] = 5, ['item'] = "lockpick", ['itemqtd'] = 1, ['price'] = 10, ['permissao'] = "perm.dkmc" },
	[7] = { ['re'] = "pacote_ilegal", ['reqtd'] = 3, ['item'] = "ticket_race", ['itemqtd'] = 1, ['price'] = 10, ['permissao'] = "perm.dkmc" },
	
-- PRODUZIR ARMAS
	[8] = { ['re'] = "pistol_parts", ['reqtd'] = 15, ['item'] = "wbody|WEAPON_PISTOL_MK2", ['itemqtd'] = 1, ['price'] = 20000, ['permissao'] = "perm.produzir.armas" },
	[9] = { ['re'] = "pistol_parts", ['reqtd'] = 5, ['item'] = "wammo|WEAPON_PISTOL_MK2", ['itemqtd'] = math.random(60,100), ['price'] = 1000, ['permissao'] = "perm.produzir.armas" },
	[10] = { ['re'] = "ak47_parts", ['reqtd'] = 30, ['item'] = "wbody|WEAPON_ASSAULTRIFLE", ['itemqtd'] = 1, ['price'] = 80000, ['permissao'] = "perm.produzir.armas" },
	[11] = { ['re'] = "ak47_parts", ['reqtd'] = 5, ['item'] = "wammo|WEAPON_ASSAULTRIFLE", ['itemqtd'] = math.random(30,100), ['price'] = 2000, ['permissao'] = "perm.produzir.armas" },
	[12] = { ['re'] = "mtar_parts", ['reqtd'] = 15, ['item'] = "wbody|WEAPON_ASSAULTSMG", ['itemqtd'] = 1, ['price'] = 60000, ['permissao'] = "perm.produzir.armas" },
	[13] = { ['re'] = "mtar_parts", ['reqtd'] = 5, ['item'] = "wammo|WEAPON_ASSAULTSMG", ['itemqtd'] = math.random(30,80), ['price'] = 1000, ['permissao'] = "perm.produzir.armas" },
	[14] = { ['re'] = "shotgun_parts", ['reqtd'] = 20, ['item'] = "wbody|WEAPON_PUMPSHOTGUN", ['itemqtd'] = 1, ['price'] = 40000, ['permissao'] = "perm.produzir.armas" },
	[15] = { ['re'] = "shotgun_parts", ['reqtd'] = 5, ['item'] = "wammo|WEAPON_PUMPSHOTGUN", ['itemqtd'] = math.random(10,40), ['price'] = 2000, ['permissao'] = "perm.produzir.armas" },
	[17] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "pack_parts", ['itemqtd'] = 1, ['price'] = 0, ['permissao'] = "perm.produzir.armas" },
	[18] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = nil, ['itemqtd'] = nil, ['price'] = 0, ['permissao'] = "perm.produzir.armas" },
	[22] = { ['re'] = "adv_parts", ['reqtd'] = 25, ['item'] = "wbody|WEAPON_ADVANCEDRIFLE", ['itemqtd'] = 1, ['price'] = 70000, ['permissao'] = "perm.produzir.armas" },
	[23] = { ['re'] = "adv_parts", ['reqtd'] = 5, ['item'] = "wammo|WEAPON_ADVANCEDRIFLE", ['itemqtd'] = math.random(30,100), ['price'] = 2000, ['permissao'] = "perm.produzir.armas" },
	[24] = { ['re'] = "sns_parts", ['reqtd'] = 20, ['item'] = "wbody|WEAPON_SNSPISTOL_MK2", ['itemqtd'] = 1, ['price'] = 15000, ['permissao'] = "perm.produzir.armas" },
	[25] = { ['re'] = "sns_parts", ['reqtd'] = 5, ['item'] = "wammo|WEAPON_SNSPISTOL_MK2", ['itemqtd'] = math.random(30,100), ['price'] = 1000, ['permissao'] = "perm.produzir.armas" },
	[26] = { ['re'] = "body_parts", ['reqtd'] = 5, ['item'] = "body_armor", ['itemqtd'] = 1, ['price'] = 5000, ['permissao'] = "perm.produzir.armas" },
	
-- Processar Drogas 
	[19] = { ['re'] = "benzoilmetilecgonina", ['reqtd'] = 1, ['item'] = "cocaine", ['itemqtd'] = 3, ['price'] = 0, ['permissao'] = "perm.trafico"},
	[20] = { ['re'] = "seeds", ['reqtd'] = 1, ['item'] = "weed", ['itemqtd'] = 3, ['price'] = 0, ['permissao'] = "perm.trafico"}, 
	[28] = { ['re'] = "anfetamina", ['reqtd'] = 1, ['item'] = "md", ['itemqtd'] = 3, ['price'] = 0, ['permissao'] = "perm.trafico"}, 

	


}

function emP.checkPayment(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		
		if vRP.hasPermission(user_id, src[id].permissao) then
			if id == 18 then
				if vRP.tryGetInventoryItem(user_id,"pack_parts",1) then
					vRP.giveInventoryItem(user_id,"sns_parts",1) vRP.giveInventoryItem(user_id,"pistol_parts",1) vRP.giveInventoryItem(user_id,"ak47_parts",1) vRP.giveInventoryItem(user_id,"body_parts",1) vRP.giveInventoryItem(user_id,"adv_parts",1) vRP.giveInventoryItem(user_id,"mtar_parts",1) vRP.giveInventoryItem(user_id,"shotgun_parts",1) 
					return true
				end
			elseif id == 60 or id == 48 or id == 30 or id == 34 then
				if vRP.tryGetInventoryItem(user_id, "dirty_money", src[id].price) then
					vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd)
					return true
				else
					TriggerClientEvent('chatMessage', source, "^2Você não possui dinheiro sujo para isso.")
				end
			elseif id == 30 or id == 29 or id == 31 or id == 32 or id == 33 then
				if vRP.tryGetInventoryItem(user_id, src[id].re, src[id].reqtd) then
					if vRP.tryGetInventoryItem(user_id, "dirty_money", src[id].price) then
						vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd)
						return true
					else
						TriggerClientEvent('chatMessage', source, "^2Você não possui dinheiro sujo para isso.")
					end
				else
					TriggerClientEvent('chatMessage', source, "^2Você não possui "..src[id].re.." "..src[id].reqtd.."x para isso.")
				end
				
			else
			if src[id].re ~= nil and src[id].price ~= nil then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,src[id].re,src[id].reqtd) then
						if vRP.tryPayment(user_id, src[id].price) then
							vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd)
							return true
						else
							TriggerClientEvent('chatMessage', source, "^2Você não possui ^5$ "..src[id].price.." dólares.")
						end
						else
							TriggerClientEvent('chatMessage', source, "^2Você não possui ^5"..src[id].reqtd.."^2x ^5"..vRP.getItemName(src[id].re))
					end
				else
					TriggerClientEvent('chatMessage', source, "^2Mochila cheia.")
				end
			else
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
					vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd)
					return true
				else
					TriggerClientEvent('chatMessage', source, "^2Mochila cheia.")
				end
			end
			return true
		end
		else
			TriggerClientEvent('chatMessage', source, "^2Você não possui permissao.")
		end
		

	end
end