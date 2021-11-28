local cfg = module("cfg/markets")
local market_types = cfg.market_types
local markets = cfg.markets
local market_menus = {}

local function build_market_menus()
    for gtype,mitems in pairs(market_types) do
        local market_menu = { name="Mercado" }
        local kitems = {}
        local market_choice = function(player,choice)
            local idname = kitems[choice][1]
            local item_name, item_weight = vRP.getItemDefinition(idname)
            local price = kitems[choice][2]
            if item_name then
                local user_id = vRP.getUserId(player)
                if user_id then
                    local amount = vRP.prompt(player,"Digite a quantidade de " .. item_name .. " que deseja comprar","")
                    local amount = parseInt(amount)
                    if amount > 0 then
                        local new_weight = vRP.getInventoryWeight(user_id)+item_weight*amount
                        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.tryPayment(user_id,amount*price) then
                                vRP.giveInventoryItem(user_id,idname,amount,true)
                                TriggerClientEvent('chatMessage', player, 'MERCADO', {63, 127, 191},"^5Você pagou " .. amount*price .. " dólares")
                            else
                                TriggerClientEvent('chatMessage', player, 'MERCADO', {63, 127, 191},"^9Dinheiro insuficiente.")
                            end
                        else
                          TriggerClientEvent('chatMessage', player, 'MERCADO', {63, 127, 191},"^9Mochila Cheia.")
                        end
                    else
                      TriggerClientEvent('chatMessage', player, 'MERCADO', {63, 127, 191},"^9Valor Invalido.")
                    end
                end
            end
        end
        for k,v in pairs(mitems) do
            local item_name, item_desc, item_weight = vRP.getItemDefinition(k)
            if item_name then
                kitems[item_name] = {k,math.max(v,0)}
                market_menu[item_name] = {market_choice,"<text01>Valor</text01> <text02>"..v.."</text02>"}
            end
        end
        market_menus[gtype] = market_menu
    end
end

local first_build = true
local function build_client_markets(source)
    if first_build then
        build_market_menus()
        first_build = false
    end
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        for k,v in pairs(markets) do
            local gtype,x,y,z = table.unpack(v)
            local group = market_types[gtype]
            local menu = market_menus[gtype]

            if group and menu then
                local gcfg = group._config
                local function market_enter(source)
                    local user_id = vRP.getUserId(source)
                    if user_id ~= nil and vRP.hasPermissions(user_id,gcfg.permissions or {}) then
                        vRP.openMenu(source,menu)
                    end
                end
                local function market_leave(source)
                    vRP.closeMenu(source)
                end 
                vRPclient._addMarker(source,23,x,y,z-0.95,0.8,0.8,0.5,0,95,140,50,100)
                vRP.setArea(source,"vRP:market"..k,x,y,z,1,1.5,market_enter,market_leave)
            end
        end
    end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    if first_spawn then
        build_client_markets(source)
    end
end)