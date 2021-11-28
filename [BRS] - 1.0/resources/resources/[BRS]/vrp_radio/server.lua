-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_radio",src)
vCLIENT = Tunnel.getInterface("vrp_radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.activeFrequency(freq)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(freq) >= 1 and parseInt(freq) <= 999 then
			if parseInt(freq) == 911 then
				if vRP.hasPermission(user_id,"dpla.permissao") then
					vCLIENT.startFrequency(source,parseInt(911))
					TriggerClientEvent("Notify",source,"sucesso","Entrou na frequência <b>911</b> dos <b>Policiais</b>.",8000)
				else
					TriggerClientEvent("Notify",source,"aviso","Você não tem permissão para entrar nesta frequência.",8000)
				end
			elseif parseInt(freq) == 112 then
				if vRP.hasPermission(user_id,"dmla.permissao") then
					vCLIENT.startFrequency(source,parseInt(112))
					TriggerClientEvent("Notify",source,"sucesso","Entrou na frequência <b>112</b> dos <b>Paramédicos</b>.",8000)
				else
					TriggerClientEvent("Notify",source,"aviso","Você não tem permissão para entrar nesta frequência.",8000)
				end
			elseif parseInt(freq) == 443 then
				if vRP.hasPermission(user_id,"mecanico.permissao") then
					vCLIENT.startFrequency(source,parseInt(443))
					TriggerClientEvent("Notify",source,"sucesso","Entrou na frequência <b>443</b> dos <b>Mecânicos</b>.",8000)
				else
					TriggerClientEvent("Notify",source,"aviso","Você não tem permissão para entrar nesta frequência.",8000)
				end
			else
				vCLIENT.startFrequency(source,parseInt(freq))
				TriggerClientEvent("Notify",source,"sucesso","Entrou na frequência <b>"..parseInt(freq).."</b>.",8000)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Frequência não encontrada.",8000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkRadio()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"radio") >= 1 then
		return true
	else
		TriggerClientEvent("Notify",source,"importante","Você precisa comprar um <b>Rádio</b> na <b>Loja de Departamento</b>.",8000)
		return false
	end
end