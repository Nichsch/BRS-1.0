local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPbancoS = {}
Tunnel.bindInterface("vrp_banco",vRPbancoS)
Proxy.addInterface("vrp_banco",vRPbancoS)
Config = module("vrp_banco", "cfg/config")

RegisterServerEvent('loffe_heist:deleteDrill')
AddEventHandler('loffe_heist:deleteDrill', function(coords)
    TriggerClientEvent('loffe_heist:deleteDrillCl', -1, coords)
end)

RegisterServerEvent('loffe_heist:getBox')
AddEventHandler('loffe_heist:getBox', function(bank)
	local source = source
	if not bank then bank = 1 end
    local money = Config.BankRobbery[bank].Money.Amount
    if money > 0 then
        if money >= Config.BankRobbery[bank].Money.StartMoney/2 then
            box = Config.Boxes.Full
        else
            box = Config.Boxes.Half
        end
    else
        box = Config.Boxes.Empty
    end
    TriggerClientEvent('loffe_heist:getBox', source, box)
end)

function generateRandomMoney(src, bank)
    local user_id = vRP.getUserId(src)
    while true do
        local randommoney = math.random(Config.MinPegar, Config.MaxPegar)
        if Config.BankRobbery[bank].Money.Amount - randommoney >= 0 then
            Config.BankRobbery[bank].Money.Amount = Config.BankRobbery[bank].Money.Amount - randommoney
			vRP.giveInventoryItem(user_id, Config.DinheiroSujo, randommoney, false)
            break
        end
        Wait(0)
    end
end

RegisterServerEvent('loffe_heist:takeMoney')
AddEventHandler('loffe_heist:takeMoney', function(bank)
    local src = source
	local user_id = vRP.getUserId(src)
    if Config.BankRobbery[bank].Money.Amount - Config.MinPegar >= 0 then
        generateRandomMoney(src, bank)
    else
        if Config.BankRobbery[bank].Money.Amount > 0 then
			vRP.giveMoney(user_id,Config.BankRobbery[bank].Money.Amount)
			vRP.giveInventoryItem(user_id, Config.DinheiroSujo, Config.BankRobbery[bank].Money.Amount, false)
            Config.BankRobbery[bank].Money.Amount = 0
        end
    end
    TriggerClientEvent('loffe_heist:updateMoney', -1, bank, Config.BankRobbery[bank].Money.Amount )
end)

function vRPbancoS.checkSolda()
    local source = source
	local user_id = vRP.getUserId(source)
    if vRP.tryGetInventoryItem(user_id,"solda",1) then
		return true
    else
        TriggerClientEvent('chatMessage', source, "^9Você não possui uma solda.")
        return false
	end
end

function vRPbancoS.checkFuradeira()
    local src = source
	local user_id = vRP.getUserId(src)
    if vRP.tryGetInventoryItem(user_id,Config.Furadeira,1,false) then
        return true
    else
        TriggerClientEvent('chatMessage', src, "^9Você não possui uma furadeira.")
        return false
	end
end
local varRepeat = 0
function vRPbancoS.checkPolicia()
    local source = source
	local user_id = vRP.getUserId(source)
    local policia = vRP.getUsersByPermission("perm.roubos")
	if user_id then
        if #policia >= 6 then
            if varRepeat == 0 then
                TriggerClientEvent('chatMessage', -1, "NOTÍCIAS", {255, 0, 0}, "Acaba de começar um assalto no banco central.")
                TriggerClientEvent("nzk:bankNews", -1, 10)
                varRepeat = 1
                vRPclient.setStandBY(source,parseInt(3600))
                return true
            else
                TriggerClientEvent('chatMessage', -1, "NOTÍCIAS", {255, 0, 0}, "O Assalto no banco central está em andamento.")
                vRPclient.setStandBY(source,parseInt(3600))
                return true
            end
        else
            TriggerClientEvent('chatMessage',source,"^9Número insuficiente de policiais no momento.")
            return false
        end
    end
end

RegisterServerEvent('loffe_heist:setDoorFreezeStatus')
AddEventHandler('loffe_heist:setDoorFreezeStatus', function(bank, door, status)
    local src = source
        Config.BankRobbery[bank].Doors[door].Frozen = status
        TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', -1, bank, door, status)
end)

RegisterServerEvent('loffe_heist:getDoorFreezeStatus')
AddEventHandler('loffe_heist:getDoorFreezeStatus', function(bank, door)
    TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', source, bank, door, Config.BankRobbery[bank].Doors[door].Frozen)
end)

RegisterServerEvent('loffe_heist:toggleSafe')
AddEventHandler('loffe_heist:toggleSafe', function(bank, safe, toggle)
    Config.BankRobbery[bank].Safes[safe].Looted = toggle
    TriggerClientEvent('loffe_heist:safeLooted', -1, bank, safe, toggle)
end)

RegisterServerEvent('loffe_heist:lootSafe')
AddEventHandler('loffe_heist:lootSafe', function(bank, safe)
    local src = source
    local user_id = vRP.getUserId(src)
    local randommoney = math.random(Config.SafeMinimum, Config.SafeMax)
	vRP.giveInventoryItem(user_id, Config.DinheiroSujo, randommoney, false)
	vRP.notify(src,"Recebido ~g~$"..randommoney)
    Config.BankRobbery[bank].Safes[safe].Looted = true
    TriggerClientEvent('loffe_heist:safeLooted', -1, bank, safe, true)
end)

AddEventHandler('playerConnecting', function()
    local src = source
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Doors do
            Wait(0)
            TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Doors[j].Frozen)
        end
    end
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Safes do
            Wait(0)
            TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Safes[j].Looted)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #Config.BankRobbery do
            Wait(0)
            for j = 1, #Config.BankRobbery[i].Doors do
                Wait(0)
                TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', -1, i, j, Config.BankRobbery[i].Doors[j].Frozen)
            end
        end
        Wait(30000)
    end
end)

Citizen.CreateThread(function()
    while true do
		if Config.BankRobbery[1].Money.Amount == 0 then
			Wait(1000*Config.Tempo)
			Config.BankRobbery[1].Money.Amount = Config.BankRobbery[1].Money.StartMoney
			TriggerClientEvent('loffe_heist:updateMoney', -1, 1, Config.BankRobbery[1].Money.StartMoney)
			
			Config.BankRobbery[1].Doors[1].Frozen = true
			Config.BankRobbery[1].Doors[2].Frozen = true
			Config.BankRobbery[1].Doors[3].Frozen = true
			
			Config.BankRobbery[1].Safes[1].Looted = true
			Config.BankRobbery[1].Safes[2].Looted = true
			Config.BankRobbery[1].Safes[3].Looted = true
		end
        Wait(1)
    end
end)
