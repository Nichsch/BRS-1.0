RegisterNetEvent('fivemstore-title')
AddEventHandler('fivemstore-title', function (title, subtitle)
  local name = GetCurrentResourceName()
  SendNUIMessage({ title=title, subtitle=subtitle, name=name });
  SetNuiFocus(true, false)
end)

RegisterNUICallback('removeFocus', function (data, cb)
  SetNuiFocus(false, false)
  cb(true)
end)