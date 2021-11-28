local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "wbody|WEAPON_PISTOL", quantidade = 1, compra = 150000, venda = 70000 },
	{ item = "wbody|WEAPON_PISTOL_MK2", quantidade = 1, compra = 180000, venda = 90000 },
	
	{ item = "wammo|WEAPON_PISTOL", quantidade = 50, compra = 10000, venda = 2000 },
	{ item = "wammo|WEAPON_PISTOL_MK2", quantidade = 50, compra = 10000, venda = 2000 },
	
	{ item = "wbody|WEAPON_KNIFE", quantidade = 1, compra = 3000, venda = 1500 },
	{ item = "wbody|WEAPON_DAGGER", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_KNUCKLE", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_MACHETE", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_SWITCHBLADE", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_WRENCH", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_HAMMER", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_GOLFCLUB", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_CROWBAR", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_HATCHET", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_FLASHLIGHT", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_BAT", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_BOTTLE", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_BATTLEAXE", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_POOLCUE", quantidade = 1, compra = 2000, venda = 1000 },
	{ item = "wbody|WEAPON_STONE_HATCHET", quantidade = 1, compra = 3000, venda = 1500 },

	{ item = "wbody|GADGET_PARACHUTE", quantidade = 1, compra = 5000, venda = 2500 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-comprar")
AddEventHandler("armamentos-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then

			if item == "colete" then
				if vRP.tryPayment(user_id,40000) then
					vRPclient.setArmour(source,100)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Colete por $40.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "algemas" then
				if vRP.tryPayment(user_id,4000) then
					vRP.giveInventoryItem(user_id,"algemas",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Algema por $4.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "scubagear" then
				if vRP.tryPayment(user_id,15000) then
					vRP.giveInventoryItem(user_id,"scubagear",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Trajde de mergulho por $15.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "vendaolhos" then
				if vRP.tryPayment(user_id,5000) then
					vRP.giveInventoryItem(user_id,"vendaolhos",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Capuz por $600 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "night_vison" then
				if vRP.tryPayment(user_id,2000) then
					vRP.giveInventoryItem(user_id,"night_vison",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Visao Noturna por $.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "mochila1" then
				if vRP.tryPayment(user_id,15000) then
					vRP.giveInventoryItem(user_id,"mochila1",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Mochila Pequena por $15.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "mochila2" then
				if vRP.tryPayment(user_id,20000) then
					vRP.giveInventoryItem(user_id,"mochila2",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Mochila Media por $20.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "mochila3" then
				if vRP.tryPayment(user_id,40000) then
					vRP.giveInventoryItem(user_id,"mochila3",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Mochila Grande por $40.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "solda" then
				if vRP.tryPayment(user_id,15000) then
					vRP.giveInventoryItem(user_id,"solda",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Solda por $15.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "mascara" then
				if vRP.tryPayment(user_id,8000) then
					vRP.giveInventoryItem(user_id,"mascara",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Mascara por $8.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			elseif item == "furadeira" then
				if vRP.tryPayment(user_id,20000) then
					vRP.giveInventoryItem(user_id,"furadeira",1)
					TriggerClientEvent('chatMessage', source, "^5Comprou 1x Furadeira por $20.000 dólares.")
				else
					TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
				end
			else
				for k,v in pairs(valores) do
					if item == v.item then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
							if v.item == "wbody|WEAPON_KNIFE" or v.item == "wbody|WEAPON_DAGGER" or v.item == "wbody|WEAPON_KNUCKLE" or v.item == "wbody|WEAPON_MACHETE" or v.item == "wbody|WEAPON_SWITCHBLADE" or v.item == "wbody|WEAPON_WRENCH" or v.item == "wbody|WEAPON_HAMMER" or v.item == "wbody|WEAPON_GOLFCLUB" or v.item == "wbody|WEAPON_CROWBAR" or v.item == "wbody|WEAPON_HATCHET" or v.item == "wbody|WEAPON_FLASHLIGHT" or v.item == "wbody|WEAPON_BAT" or v.item == "wbody|WEAPON_BOTTLE" or v.item == "wbody|WEAPON_BATTLEAXE" or v.item == "wbody|WEAPON_POOLCUE" or v.item == "wbody|WEAPON_STONE_HATCHET" or v.item == "wbody|GADGET_PARACHUTE" then
								if vRP.tryPayment(user_id,parseInt(v.compra)) then
									vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
									TriggerClientEvent('chatMessage', source, "^5Você Comprou "..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).." por $"..vRP.format(parseInt(v.compra)).." dólares.")
								else
									TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
								end
							else
							if vRP.hasGroup(user_id,"Porte de Arma") then
									if vRP.tryPayment(user_id,parseInt(v.compra)) then
										vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
										TriggerClientEvent('chatMessage', source, "^5Você Comprou "..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).." por $"..vRP.format(parseInt(v.compra)).." dólares.")
									else
										TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
									end
								else
									TriggerClientEvent('chatMessage', source, "^9Você não possui porte de armas.")
							end
						end

						else
							TriggerClientEvent('chatMessage', source, "^9Mochila cheia.")
						end
					end
				end
			end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-vender")
AddEventHandler("armamentos-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.hasPermission(user_id, "perm.policia.civil") or vRP.hasPermission(user_id, "perm.driftking") or vRP.hasPermission(user_id, "perm.ballas") or vRP.hasPermission(user_id, "perm.vagos") or vRP.hasPermission(user_id, "perm.bratva") or vRP.hasPermission(user_id, "perm.yakuza") or vRP.hasPermission(user_id, "perm.motoclube") or vRP.hasPermission(user_id, "perm.iaa") or vRP.hasPermission(user_id, "perm.tequilala") or vRP.hasPermission(user_id, "perm.vanilla") then
					TriggerClientEvent('chatMessage', source, "^9Você não pode vender isto aqui.")
				else
					if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
						vRP.giveMoney(user_id,parseInt(v.venda))
						TriggerClientEvent('chatMessage', source, "^5Você Vendeu "..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).." por $"..vRP.format(parseInt(v.venda)).." dólares.")
						vRP.log("nzk_logs/player/ammunationvendas.txt", "O [ID: "..user_id.."] vendeu o "..vRP.getItemName(v.item).." "..parseInt(v.quantidade).."x $"..vRP.format(parseInt(v.venda)).." dólares.")
					else
						TriggerClientEvent('chatMessage', source, "^9Você Não possui "..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).." em sua mochila.")
					end
				end
			end
		end
	end
end)