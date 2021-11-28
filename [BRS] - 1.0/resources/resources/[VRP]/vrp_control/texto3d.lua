------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TEXTOS 3Ds
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local textos3D = { 
    {-1032.6975097656,-2724.7333984375,13.627660751343, ['distancia'] = 20.0, ['mensagem'] = "Em caso de dúvidas, pressione F9.", ['fontType'] = 4, ['fontScale'] = 0.5},
    {-55.227298736572,-1094.5369873047,26.42234992981, ['distancia'] = 10.0, ['mensagem'] = "SUV", ['fontType'] = 4, ['fontScale'] = 0.4},
    {-54.19690322876,-1091.7066650391,26.422351837158, ['distancia'] = 10.0, ['mensagem'] = "Populares", ['fontType'] = 4, ['fontScale'] = 0.4},
    {-56.094039916992,-1096.7902832031,26.42234992981, ['distancia'] = 10.0, ['mensagem'] = "Super Carros", ['fontType'] = 4, ['fontScale'] = 0.4},
    {-53.118572235107,-1089.6218261719,26.422351837158, ['distancia'] = 10.0, ['mensagem'] = "Antigos", ['fontType'] = 4, ['fontScale'] = 0.4},
    {-42.481151580811,-1091.9554443359,26.422353744507, ['distancia'] = 10.0, ['mensagem'] = "Motos", ['fontType'] = 4, ['fontScale'] = 0.4},
    {-50.38,-1102.35,26.43, ['distancia'] = 10.0, ['mensagem'] = "Utilitarios", ['fontType'] = 4, ['fontScale'] = 0.4},
    {-47.92,-1103.34,26.43, ['distancia']= 10.0, ['mensagem'] = "Off-Road", ['fontType'] = 4, ['fontScale'] = 0.4},
    {-45.65,-1104.15,26.43, ['distancia']= 10.0, ['mensagem'] = "Sport", ['fontType'] = 4, ['fontScale'] = 0.4},
    {-48.13,-1090.1,26.43, ['distancia']= 10.0, ['mensagem'] = "Eletricos", ['fontType'] = 4, ['fontScale'] = 0.4},
    {-30.06,-1105.09,26.43, ['distancia']= 10.0, ['mensagem'] = "Importados", ['fontType'] = 4, ['fontScale'] = 0.4},


}

Citizen.CreateThread(function()
	while true do
        local nichsch = 1000

        for k,v in ipairs(textos3D) do
            local x,y,z = table.unpack(v)
            local pCoords = GetEntityCoords(GetPlayerPed(-1))
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x,y,z, true)
            if distance < v.distancia then
                nichsch = 1
                DrawText3d(x,y,z, v.mensagem, v.fontType, v.fontScale)
            end
        end
        Citizen.Wait(nichsch)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawText3d(x,y,z,text,font,scale)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(255,255,255,255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end