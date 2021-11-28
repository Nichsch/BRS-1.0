local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP")
HUDserver = Tunnel.getInterface("vrp_hud", "vrp_hud")
vRPhud = {}

Tunnel.bindInterface("vrp_hud",vRPhud)
Proxy.addInterface("vrp_hud",vRPhud)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local hour = 0
local minute = 0
local month = ""
local dayOfMonth = 0
local sBuffer = {}
local vBuffer = {}
local cinto_seguranca = false
local limitador_velocidade = false
local ExNoCarro = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATA E HORA
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	if month == 0 then
		month = "Janeiro"
	elseif month == 1 then
		month = "Fevereiro"
	elseif month == 2 then
		month = "Março"
	elseif month == 3 then
		month = "Abril"
	elseif month == 4 then
		month = "Maio"
	elseif month == 5 then
		month = "Junho"
	elseif month == 6 then
		month = "Julho"
	elseif month == 7 then
		month = "Agosto"
	elseif month == 8 then
		month = "Setembro"
	elseif month == 9 then
		month = "Outubro"
	elseif month == 10 then
		month = "Novembro"
	elseif month == 11 then
		month = "Dezembro"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CSS
-----------------------------------------------------------------------------------------------------------------------------------------
local logo_css = [[
	.div_barraserver {
		content: url(https://cdn.discordapp.com/attachments/751252347757264936/759266405500715019/Sem_Titulo-1.png);
		top: 3%;
		right: 1%;
		position: absolute;
		width: 160px;
		height: 159px;
		opacity: 0.4;
	}
]]
local fan_css = [[
	.div_fan {
		bottom: 3%;
		right: 2%;
		position: absolute;
	}

	.voice1 {
		background: #dfe630;
		border-radius: 3px;
		display: flex;
		justify-content: center;
		align-items: center;
		color: rgba(0, 0, 0, 0.6);
		height: 30px;
		width: 30px;
		float: left;
	}
	.voice2 {
		background: #2be341;
		border-radius: 3px;
		display: flex;
		justify-content: center;
		align-items: center;
		color: rgba(0, 0, 0, 0.6);
		height: 30px;
		width: 30px;
		float: left;
	}
	.voice3 {
		background: #8c0e0e;
		border-radius: 3px;
		display: flex;
		justify-content: center;
		align-items: center;
		color: rgba(0, 0, 0, 0.6);
		height: 30px;
		width: 30px;
		float: left;
	}

	.life{
		height: 30px;
		width: 30px;
		background-color: #245824;
		position: relative;
		border-radius: 4px;
		float:left;
		margin-right: 10px;
	}
	
	.life .life-bar{
	   position: absolute;
	   bottom: 0;
	   background-color: #338133;
	   border-radius: 3px;
	   width: 100%
	}
	.life i {
		position: absolute;
		color: rgba(0, 0, 0, 0.6);
		width: 30px;
		height: 30px;
		text-align: center;
		font-size: 18px;
		line-height: 1.7;
	}

	.fome{
		height: 30px;
		width: 30px;
		background-color: #b48d69b9;
		position: relative;
		border-radius: 4px;
		float:left;
		margin-right: 10px;
	}
	
	.fome .fome-bar{
	   position: absolute;
	   bottom: 0;
	   background-color: #c57326;
	   border-radius: 3px;
	   width: 100%
	}
	
	.fome i {
		position: absolute;
		color: rgba(0, 0, 0, 0.6);
		width: 30px;
		height: 30px;
		text-align: center;
		font-size: 18px;
		line-height: 1.7;
	}

	.sede{
		height: 30px;
		width: 30px;
		background-color: #71c9cfbe;
		position: relative;
		border-radius: 4px;
		float:left;
		margin-right: 10px;
	}
	
	.sede .sede-bar{
	   position: absolute;
	   bottom: 0;
	   background-color: #61f4ff;
	   border-radius: 3px;
	   width: 100%
	}
	
	.sede i {
		position: absolute;
		color: rgba(0, 0, 0, 0.6);
		width: 30px;
		height: 30px;
		text-align: center;
		font-size: 18px;
		line-height: 1.7;
	}

	.vest{
		height: 30px;
		width: 30px;
		background-color: #2e5163;
		position: relative;
		border-radius: 4px;
		float:left;
		margin-right: 10px;
		
	}
	.vest .vest-bar{
	   position: absolute;
	   bottom: 0;
	   background-color: #337896;
	   border-radius: 3px;
	   width: 100%;
	}
	.vest i {
		position: absolute;
		color: rgba(0, 0, 0, 0.6);
		width: 30px;
		height: 30px;
		text-align: center;
		font-size: 18px;
		line-height: 1.7;
	}

	.texto {
		margin-right: 12px;
		height: 32px;
		font-family: Arial;
		font-size: 13px;
		text-shadow: 1px 1px #000;
		color: rgba(255,255,255,0.5);
		text-align: right;
		line-height: 16px;
		float: left;
	}
	.texto b {
		color: rgba(255,255,255,0.7);
	}

	.texto2 {
		font-family: Arial;
		font-size: 10px;
		text-shadow: 1px 1px #000;
		color: rgba(255,255,255,0.5);
		float: left;
		font-weight: 100;
	}
	.texto2 b {
		color: rgba(255,255,255,0.7);
	}

	.div_InCar {
		position: absolute;
		left: 64%;
		top: -110%;
	}

	.velocidade{
		top: -115%;
		left: 30%;
		height: 30px;
		width: 40px;
		background-color: rgba(0, 0, 0, 0.404);
		position: absolute;
		border-radius: 4px;
		float:left;
		margin-right: 10px;
	}

	.velocidade span{
		position: absolute;
		width: 40px;
		height: 30px;
		text-align: center;
		font-size: 18px;
		line-height: 1.7;
	}
	.cinto{
		height: 30px;
		width: 30px;
		position: relative;
		border-radius: 4px;
		float:left;
		margin-right: 10px;
	}

	.cinto i {
		position: absolute;
		color: rgba(0, 0, 0, 0.6);
		width: 30px;
		height: 30px;
		text-align: center;
		font-size: 18px;
		line-height: 1.7;
	}

	.limitador{
		height: 30px;
		width: 30px;
		background-color: rgba(211, 149, 16, 0.200);
		position: relative;
		border-radius: 4px;
		float:left;
		margin-right: 10px;
	}

	.limitador i {
		position: absolute;
		color: rgba(0, 0, 0, 0.6);
		width: 30px;
		height: 30px;
		text-align: center;
		font-size: 18px;
		line-height: 1.7;
	}

	.gas{
		height: 30px;
		width: 30px;
		background-color: rgba(252, 246, 165, 0.589);
		position: relative;
		border-radius: 4px;
		float:left;
		margin-right: 10px;
	}
	
	.gas .gas-bar{
	   position: absolute;
	   bottom: 0;
	   background-color: rgb(255, 238, 0);
	   border-radius: 3px;
	   width: 100%
	}
	.gas i {
		position: absolute;
		color: rgba(0, 0, 0, 0.6);
		width: 30px;
		height: 30px;
		text-align: center;
		font-size: 18px;
		line-height: 1.7;
	}
]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerSpawned",function()
	NetworkSetTalkerProximity(proximity)
	vRP._setDiv("fan",fan_css,"")
	vRP._setDiv("barraserver", logo_css,"")
end)

local time = false

function UpdateOverlay()
	CalculateTimeToDisplay()
	CalculateDateToDisplay()
	NetworkClearVoiceChannel()
	NetworkSetTalkerProximity(proximity)
	local ped = PlayerPedId()
	local PedCar = GetVehiclePedIsIn(ped)
	local x,y,z = table.unpack(GetEntityCoords(ped,false))
	local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
	local h = math.ceil((GetEntityHealth(ped)-100)/2)
	local colete = GetPedArmour(ped) 
	local speed = GetEntitySpeed(GetVehiclePedIsIn(ped,false))*3.605936
	local fuel = 0
	if colete == 0 then displayColete = "none" else displayColete = "block" end
	if cinto_seguranca then cinto_BackGround = "background-color: rgba(21, 223, 129, 0.459);" else cinto_BackGround = "background-color: rgba(0, 0, 0, 0.219)" end
	if limitador_velocidade then limitador_velocidade_color = "color: red;" limitador_velocidade_background = "background-color: rgba(184, 125, 17, 0.678)" else limitador_velocidade_color = "color: rgba(255,255,255,0.7);" limitador_velocidade_background = "background-color: rgba(0, 0, 0, 0.219)" end


	if IsPedInAnyVehicle(ped) then
		local veiculoPED = GetVehiclePedIsUsing(ped)
		local veiculoC = GetVehicleClass(veiculoPED)
		if veiculoC == 0 or veiculoC == 1 or veiculoC == 2 or veiculoC == 3 or veiculoC == 4 or veiculoC == 5 or veiculoC == 6 or veiculoC == 7 or veiculoC == 9 or veiculoC == 10 or veiculoC == 11 or veiculoC == 12 or veiculoC == 17 or veiculoC == 19 or veiculoC == 20 then
			if not cinto_seguranca then
				if not time then
					TriggerEvent("vrp_sound:source",'alertbelt',0.1)
					time = true
					SetTimeout(4*1000, function()
						time = false
					end)
				end
			end
		end

		fuel = parseInt(GetVehicleFuelLevel(GetVehiclePedIsIn(ped,false)))
		if adminRadar or not adminRadar then DisplayRadar(true) end
		proximity = 25.001
		voice = 3
		display = "block"		
		
	else
		if adminRadar then DisplayRadar(true) else DisplayRadar(false) end
		display = "none"
	end

	vRP._setDivContent("fan","<div style=\"display: "..display..";\" class=\"div_InCar\">  <div style=\""..limitador_velocidade_color.."\"  class=\"velocidade\"><span>"..math.ceil(speed).."</span></div> <div class=\"gas\"><div class=\"gas-bar\" style=\"height: "..fuel.."%;\"></div><i class=\"fas fa-gas-pump\"></i></div> <div style=\""..cinto_BackGround.."\" class=\"cinto\"><i class=\"fas fa-bacon\"></i></div> </div><div class=\"texto\">Hoje é dia <b>"..dayOfMonth.."</b> de <b>"..month.."</b> as <b>"..hour..":"..minute.."</b>    <br>Você esta em <b>"..street.."</b></div> <div class=\"life\"><div class=\"life-bar\" style=\"height: "..h.."%;\"></div><i class=\"fas fa-heart\"></i></div> <div class=\"vest\" style=\"display: "..displayColete..";\"><div class=\"vest-bar\" style=\"height: "..colete.."%;\"></div><i class=\"fas fa-shield-alt\"></i></div> ")
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		UpdateOverlay()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(1,243) and GetEntityHealth(PlayerPedId()) > 100 then
			if proximity == 3.001 then
				voice = 2
				proximity = 10.001
			elseif proximity == 10.001 then
				voice = 3
				proximity = 25.001
			elseif proximity == 25.001 then
				voice = 1
				proximity = 3.001
			end
			UpdateOverlay()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMITADOR DE VELOCIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local limitadorPadrao = 999.0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local PedCar = GetVehiclePedIsIn(ped)

		if IsPedInAnyVehicle(ped) then
			if (GetPedInVehicleSeat(PedCar, -1) == ped) then
				
			--[[	if IsControlJustReleased(0, 137) then
					if not limitador_velocidade then
						limitador_velocidade = true
						limitadorPadrao = GetEntitySpeed(PedCar)
					else
						limitador_velocidade = false
						limitadorPadrao = 999.0
					end
			--	end]]

				local maxSpeed = limitador_velocidade and limitadorPadrao or GetVehicleHandlingFloat(PedCar,"CHandlingData","fInitialDriveMaxFlatVel")
				SetEntityMaxSpeed(PedCar, maxSpeed)
				UpdateOverlay()
			end
		end

	end
end)
-----------
-----------------------------------------------------------------------------------------------------------------------------------------
-- CINTO DE SEGURANÇA
-----------------------------------------------------------------------------------------------------------------------------------------
IsCar = function(veh)
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	

Fwv = function (entity)
	local hr = GetEntityHeading(entity) + 90.0
	if hr < 0.0 then
		hr = 360.0 + hr
	end
	hr = hr * 0.0174533
	return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

local segundos = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local car = GetVehiclePedIsIn(ped)

		local veiculoPED = GetVehiclePedIsUsing(ped)
		local veiculoC = GetVehicleClass(veiculoPED)
			if car ~= 0 and (ExNoCarro or IsCar(car)) then
				ExNoCarro = true
				if cinto_seguranca then
					DisableControlAction(0,75)
				end

				sBuffer[2] = sBuffer[1]
				sBuffer[1] = GetEntitySpeed(car)

				if sBuffer[2] ~= nil and not cinto_seguranca and GetEntitySpeedVector(car,true).y > 1.0 and sBuffer[1] > 10.25 and (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
					local co = GetEntityCoords(ped)
					local fw = Fwv(ped)
					SetEntityHealth(ped,GetEntityHealth(ped)-150)
					SetEntityVelocity(ped,vBuffer[2].x,vBuffer[2].y,vBuffer[2].z)
					SetEntityCoords(ped,co.x+fw.x,co.y+fw.y,co.z-0.47,true,true,true)
					segundos = 5 
				end

				vBuffer[2] = vBuffer[1]
				vBuffer[1] = GetEntityVelocity(car)
				
				if IsControlJustReleased(1,47) then
					TriggerEvent("cancelando",true)
					if cinto_seguranca then
						
						TriggerEvent("vrp_sound:source",'unbelt',0.3)
						SetTimeout(2000,function()
							cinto_seguranca = false
							TriggerEvent("cancelando",false)
						end)

					else
						
						TriggerEvent("vrp_sound:source",'belt',0.3)
						SetTimeout(3000,function()
							cinto_seguranca = true
							TriggerEvent("cancelando",false)
						end)

					end
				end
			elseif ExNoCarro then
				ExNoCarro = false
				cinto_seguranca = false
				sBuffer[1],sBuffer[2] = 0.0,0.0
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('radar', function(source, args)
	if HUDserver.checkPermission() then
		if adminRadar then
			adminRadar = false
		else
			adminRadar = true
		end
	end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- RHUD
-----------------------------------------------------------------------------------------------------------------------------------------
local displayValue = false
RegisterCommand('rhud', function(source, args)
	if not displayValue then
		displayValue = true
		vRP._removeDiv("fan",css,"")
		vRP._removeDiv("barraserver",css,"")
	else
		displayValue = false
		vRP._setDiv("fan",fan_css,"")
		vRP._setDiv("barraserver", logo_css,"")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD OCULTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Ocultar")
AddEventHandler("hud:Ocultar", function()
	vRP._removeDiv("fan",css,"")
	vRP._removeDiv("barraserver",css,"")
end)

RegisterNetEvent("hud:Aparecer")
AddEventHandler("hud:Aparecer", function()
	vRP._setDiv("fan",fan_css,"")
	vRP._setDiv("barraserver", logo_css,"")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local ped = GetPlayerPed(-1)
        local carro = GetVehiclePedIsIn(ped, false)  
        local speed = 0
        speed = math.ceil(GetEntitySpeed(carro)*3.605936)

        local veiculoPED = GetVehiclePedIsUsing(ped)
        local veiculoC = GetVehicleClass(veiculoPED)

        if veiculoC == 14 then
            SetVehicleFuelLevel(carro,100.0)
        end

        if veiculoC ~= 8 then
            if GetPedInVehicleSeat(carro,-1) == ped then
                    if IsControlPressed(0,71) and IsControlJustPressed(0,86) and HUDserver.checkNitro() then 
                        if speed <= 100 then 
                            TriggerEvent('chatMessage',"^2Você precisa estar com o veiculo mais rapido.")
                        else
                            vRP.playScreenEffect("RaceTurbo", 15)
                            SetVehicleBoostActive(carro, 1, 0)
                            SetVehicleForwardSpeed(carro, 100.0)  
                            SetVehicleBoostActive(carro, 0, 0)
                        end
                    end      
                end 
            end
        end
end)
RegisterNetEvent('hud:Colocar:Cinto')
AddEventHandler('hud:Colocar:Cinto',function(status)
    cinto_seguranca = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local nichsch = 5
		if segundos > 0 then
			nichsch = 5
			segundos = segundos - 1
		end
		Citizen.Wait(nichsch)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x+width/2,y+height/2,width,height,r,g,b,a)
end

function drawTxt(x,y,scale,text,r,g,b,a)
	SetTextFont(4)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end