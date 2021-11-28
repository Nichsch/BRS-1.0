local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
lojaCoins = Tunnel.getInterface("vrp_vip")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
-- VIPS
	if data == "pacote_vips_esmeralda" then 
		TriggerServerEvent("nzk_coins_comprar", "esmeralda")
		ToggleActionMenu()	
	elseif data == "pacote_vips_prata" then 
		TriggerServerEvent("nzk_coins_comprar", "prata")
		ToggleActionMenu()
	elseif data == "pacote_vips_ouro" then 
		TriggerServerEvent("nzk_coins_comprar", "ouro")
		ToggleActionMenu()
	elseif data == "pacote_vips_diamante" then 
		TriggerServerEvent("nzk_coins_comprar", "diamante")
		ToggleActionMenu()
	elseif data == "pacote_vips_platina" then 
		TriggerServerEvent("nzk_coins_comprar", "platina")
		ToggleActionMenu()
-- Dinheiro
	elseif data == "pacote_dinheiro_200k" then 
		TriggerServerEvent("nzk_coins_comprar", "dinheiro_200k")
		ToggleActionMenu()
	elseif data == "pacote_dinheiro_400k" then 
		TriggerServerEvent("nzk_coins_comprar", "dinheiro_400k")
		ToggleActionMenu()
	elseif data == "pacote_dinheiro_600k" then 
		TriggerServerEvent("nzk_coins_comprar", "dinheiro_600k")
		ToggleActionMenu()
	elseif data == "pacote_dinheiro_800k" then 
		TriggerServerEvent("nzk_coins_comprar", "dinheiro_800k")
		ToggleActionMenu()
-- VEICULOS
	elseif data == "pacote_veiculos_volatus" then 
		TriggerServerEvent("nzk_coins_comprar", "volatus")
		ToggleActionMenu()
	elseif data == "pacote_veiculos_frogger" then 
		TriggerServerEvent("nzk_coins_comprar", "frogger")
		ToggleActionMenu()
	elseif data == "pacote_veiculos_blazer5" then 
		TriggerServerEvent("nzk_coins_comprar", "blazer5")
		ToggleActionMenu()
	elseif data == "pacote_veiculos_18performante" then 
		TriggerServerEvent("nzk_coins_comprar", "18performante")
		ToggleActionMenu()
	elseif data == "pacote_veiculos_shotaro" then 
		TriggerServerEvent("nzk_coins_comprar", "shotaro")
		ToggleActionMenu()


	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('loja', function(source, args)
	local source = source
	ToggleActionMenu()
	lojaCoins.getCoinsClient()
end)

RegisterCommand('bcs', function(source, args)
	lojaCoins.getCoinsClient()
end)