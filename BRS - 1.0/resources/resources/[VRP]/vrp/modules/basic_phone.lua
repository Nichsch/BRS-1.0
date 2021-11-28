local cfg = module("cfg/phone")
local htmlEntities = module("lib/htmlEntities")
local services = cfg.services

function vRP.sendServiceAlert(sender, service_name,x,y,z,msg)
    local service = services[service_name]
    local answered = false
    if service then
        local players = {}
        for k,v in pairs(vRP.rusers) do
            local player = vRP.getUserSource(tonumber(k))
            if vRP.hasPermission(k,service.alert_permission) and player then
                table.insert(players,player)
            end
        end
        for k,v in pairs(players) do
            local bid = vRPclient.addBlip(v,x,y,z,service.blipid,service.blipcolor,"("..service_name..")"..msg)
            SetTimeout(service.alert_time*1000,function()
                vRPclient._removeBlip(v,bid)
            end)
            if sender ~= nil then
                local user_id = vRP.getUserId(sender)
                if user_id then
                    local identity = vRP.getUserIdentity(user_id)
                    if identity then
                        async(function()
                            local ok = vRP.request(v,"<b>("..service_name..")</b> Você recebeu um chamado de <b>"..identity.firstname.." "..identity.name.." ("..user_id..")</b> ? <em>"..htmlEntities.encode(msg).."</em>", 30)
                                if ok then
                                    if not answered then
                                        TriggerClientEvent('chatMessage', sender, service.answer_notify)
                                        vRPclient._setGPS(v,x,y)
                                        answered = true
                                    end
                                end
                        end)
                    end
                end
            end
        end
    end
end
