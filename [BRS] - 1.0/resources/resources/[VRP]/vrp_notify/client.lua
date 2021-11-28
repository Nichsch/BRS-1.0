local diferencial = 1

RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,tempo)
  SendNUIMessage({ css = css, mensagem = mensagem, tempo = tempo, diferencial = diferencial })
  PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
  diferencial = diferencial + 1
end)