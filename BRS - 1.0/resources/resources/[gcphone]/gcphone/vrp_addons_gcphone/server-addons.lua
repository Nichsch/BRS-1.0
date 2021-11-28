local PhoneNumbers        = {}

RegisterServerEvent('gcPhone:sendMessage:off')
AddEventHandler('gcPhone:sendMessage:off', function(number, message)
    local sourcePlayer = tonumber(source)
    if PhoneNumbers[number] ~= nil then
      getPhoneNumber(source, function (phone) 
        notifyAlertSMS(number, {
          message = message,
          numero = phone,
        }, PhoneNumbers[number].sources)
      end)
    end
end)

function notifyAlertSMS (number, alert, listSrc)
  if PhoneNumbers[number] ~= nil then
    for k, _ in pairs(listSrc) do
      getPhoneNumber(tonumber(k), function (n)
        if n ~= nil then
          TriggerEvent('gcPhone:_internalAddMessage', number, n, 'De #' .. alert.numero  .. ' : ' .. alert.message, 0, function (smsMess)
            TriggerClientEvent("gcPhone:receiveMessage", tonumber(k), smsMess)
          end)
          if alert.coords ~= nil then
            TriggerEvent('gcPhone:_internalAddMessage', number, n, 'GPS: ' .. alert.coords.x .. ', ' .. alert.coords.y, 0, function (smsMess)
              TriggerClientEvent("gcPhone:receiveMessage", tonumber(k), smsMess)
            end)
          end
        end
      end)
    end
  end
end



AddEventHandler('esx_phone:registerNumber1923919', function(number, type, sharePos, hasDispatch, hideNumber, hidePosIfAnon)
  print('==== Enregistrement du telephone ' .. number .. ' => ' .. type)
	local hideNumber    = hideNumber    or false
	local hidePosIfAnon = hidePosIfAnon or false

	PhoneNumbers[number] = {
		type          = type,
    sources       = {},
    alerts        = {}
	}
end)


AddEventHandler('esx:setJob1923919', function(source, job, lastJob)
  if PhoneNumbers[lastJob.name] ~= nil then
    TriggerEvent('esx_addons_gcphone:removeSource1923919', lastJob.name, source)
  end

  if PhoneNumbers[job.name] ~= nil then
    TriggerEvent('esx_addons_gcphone:addSource1923919', job.name, source)
  end
end)

AddEventHandler('esx_addons_gcphone:addSource1923919', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = true
end)

AddEventHandler('esx_addons_gcphone:removeSource1923919', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = nil
end)


RegisterServerEvent('esx_addons_gcphone:startCall1923919')
AddEventHandler('esx_addons_gcphone:startCall1923919', function (number, message, coords)
  local source = source
  if PhoneNumbers[number] ~= nil then
    getPhoneNumber(source, function (phone) 
      notifyAlertSMS(number, {
        message = message,
        coords = coords,
        numero = phone,
      }, PhoneNumbers[number].sources)
    end)
  else
    print('Appels sur un service non enregistre => numero : ' .. number)
  end
end)


AddEventHandler('esx:playerLoaded1923919', function(source)

  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
    ['@identifier'] = xPlayer.identifier
  }, function(result)

    local phoneNumber = result[1].phone_number
    xPlayer.set('phoneNumber', phoneNumber)

    if PhoneNumbers[xPlayer.job.name] ~= nil then
      TriggerEvent('esx_addons_gcphone:addSource1923919', xPlayer.job.name, source)
    end
  end)

end)


AddEventHandler('esx:playerDropped1923919', function(source)
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  if PhoneNumbers[xPlayer.job.name] ~= nil then
    TriggerEvent('esx_addons_gcphone:removeSource1923919', xPlayer.job.name, source)
  end
end)


function getPhoneNumber (source, callback) 
  print('get phone to ' .. source)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer == nil then
    print('esx_addons_gcphone. source null ???')
    callback(nil)
  end
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
    ['@identifier'] = xPlayer.identifier
  }, function(result)
    callback(result[1].phone_number)
  end)
end


--====================================================================================
-- VRP
--====================================================================================
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local tempo = {}

RegisterServerEvent('vrp_addons_gcphone:startCall')
AddEventHandler('vrp_addons_gcphone:startCall', function (number, message, coords)
  local source = source
  local user_id = vRP.getUserId(source)
  if user_id then
    if tempo[user_id] then
      TriggerClientEvent('chatMessage', source, "^2Aguarde, você ja fez um chamado recentemente.")
    else
      local player = vRP.getUserSource(user_id)
      TriggerClientEvent('chatMessage', source, "^2Você chamou o(a) "..number..".")
      vRP.log("nzk_logs/player/chamados.txt", "o [ID "..user_id.."] chamou o(a) "..number.." pelo motivo: "..message.."")
      vRP._sendServiceAlert(player, number,coords.x,coords.y,coords.z,message)
      tempo[user_id] = true
      SetTimeout(60*1000,function() tempo[user_id] = false end)
    end
  end
end)