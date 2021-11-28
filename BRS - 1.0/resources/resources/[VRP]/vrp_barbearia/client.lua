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
Tunnel.bindInterface("vrp_barbearia",src)
vSERVER = Tunnel.getInterface("vrp_barbearia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local myClothes = {}
function f(n)
	n = n + 0.00000
	return n
end

local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0, eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0, noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0, cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0, jawHeight = 0, chinLength = 0, chinPosition = 0, chinWidth = 0, chinShape = 0, neckWidth = 0, hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0, beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0, blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }
custom = currentCharacterMode


function src.updateCustom(data)
	if data then
		 custom = data
	end
end 
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(data)
	local ped = PlayerPedId()
	

	if data.value then
		vSERVER.updateSkin(custom)
		SetNuiFocus(false)
		
		displayBarbershop(false)
		SendNUIMessage({ openBarbershop = false })
	end

	SetPedComponentVariation(ped,2,tonumber(data.hairModel),0,0)
	SetPedHairColor(ped,tonumber(data.firstHairColor),tonumber(data.secondHairColor))
	custom.hairModel = tonumber(data.hairModel)
	custom.firstHairColor = tonumber(data.firstHairColor)
	custom.secondHairColor= tonumber(data.secondHairColor)

	-- MAQUIAGEM
	SetPedHeadOverlay(ped,4,tonumber(data.makeupModel),0.99)
	SetPedHeadOverlayColor(ped,4,0,0,0)
	custom.makeupModel = tonumber(data.makeupModel)

	-- BATOM
	SetPedHeadOverlay(ped,8,tonumber(data.lipstickModel),0.99)
	SetPedHeadOverlayColor(ped,8,2,tonumber(data.lipstickColor),tonumber(data.lipstickColor))
	custom.lipstickModel = tonumber(data.lipstickModel)
	custom.lipstickColor = tonumber(data.lipstickColor)
		
	-- SOBRANCELHA
	SetPedHeadOverlay(ped,2,tonumber(data.eyebrowsModel), 0.99)
	SetPedHeadOverlayColor(ped,2,1,tonumber(data.eyebrowsColor),tonumber(data.eyebrowsColor))
	custom.eyebrowsModel = tonumber(data.eyebrowsModel)
	custom.eyebrowsColor = tonumber(data.eyebrowsColor)

	-- BARBA
	SetPedHeadOverlay(ped,1,tonumber(data.beardModel),0.99)
	SetPedHeadOverlayColor(ped,1,1,tonumber(data.beardColor),tonumber(data.beardColor))
	custom.beardModel = tonumber(data.beardModel)
	custom.beardColor = tonumber(data.beardColor)

	-- BLUSH
	SetPedHeadOverlay(ped,5,tonumber(data.blushModel),0.99)
	SetPedHeadOverlayColor(ped,5,2,tonumber(data.blushColor),tonumber(data.blushColor))
	custom.blushModel = tonumber(data.blushModel)
	custom.blushColor = tonumber(data.blushColor)


end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateLeft",function(data)
	SetEntityHeading(PlayerPedId(),GetEntityHeading(PlayerPedId())+tonumber(10))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATERIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateRight",function(data)
	SetEntityHeading(PlayerPedId(),GetEntityHeading(PlayerPedId())-tonumber(10))
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false)
	displayBarbershop(false)
	SendNUIMessage({ openBarbershop = false }) 
	vSERVER.oldCustom()
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function displayBarbershop(enable)
	local ped = PlayerPedId()

	if enable then
		SetNuiFocus(true,true)
		SendNUIMessage({ openBarbershop = true, hairModel = custom.hairModel, firstHairColor = custom.firstHairColor, secondHairColor = custom.secondHairColor, makeupModel = custom.makeupModel, lipstickModel = custom.lipstickModel, lipstickColor = custom.lipstickColor, eyebrowsModel = custom.eyebrowsModel, eyebrowsColor = custom.eyebrowsColor, beardModel = custom.beardModel, beardColor = custom.beardColor, blushModel = custom.blushModel, blushColor = custom.blushColor  })

		FreezeEntityPosition(ped,true)
		DisableControlAction(2,14,true)
		DisableControlAction(2,15,true)
		DisableControlAction(2,16,true)
		DisableControlAction(2,17,true)
		DisableControlAction(2,30,true)
		DisableControlAction(2,31,true)
		DisableControlAction(2,32,true)
		DisableControlAction(2,33,true)
		DisableControlAction(2,34,true)
		DisableControlAction(2,35,true)
		DisableControlAction(0,25,true)
		DisableControlAction(0,24,true)

		if IsDisabledControlJustReleased(0,24) or IsDisabledControlJustReleased(0,142) then
			SendNUIMessage({ type = "click" })
		end

		SetPlayerInvincible(ped,true)

		if not DoesCamExist(cam) then
			cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
			SetCamCoord(cam,GetEntityCoords(ped))
			SetCamRot(cam,0.0,0.0,0.0)
			SetCamActive(cam,true)
			RenderScriptCams(true,false,0,true,true)
			SetCamCoord(cam,GetEntityCoords(ped))
		end

		local x,y,z = table.unpack(GetEntityCoords(ped))
		SetCamCoord(cam,x+0.2,y+0.5,z+0.7)
		SetCamRot(cam,0.0,0.0,150.0)
		DesligarJogador()
	else
		FreezeEntityPosition(ped,false)
		SetPlayerInvincible(ped,false)
		RenderScriptCams(false,false,0,1,0)
		DestroyCam(cam,false)
		AtivarJogador()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false)
	SendNUIMessage({ openBarbershop = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local locations = {
	{ -815.12,-184.15,37.57 },
	{ 138.13,-1706.46,29.3 },
	{ -1280.92,-1117.07,7.0 },
	{ 1930.54,3732.06,32.85 },
	{ 1214.2,-473.18,66.21 },
	{ -33.61,-154.52,57.08 },
	{ -276.65,6226.76,31.7 }
}

Citizen.CreateThread(function()
	criarBlip()
	while true do
		local time = 1000
		local ped = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(ped))

		for k,v in pairs(locations) do
			local distance = Vdist(x,y,z,v[1],v[2],v[3])
			if distance <= 5 then
				time = 1
				DrawText3D(v[1],v[2],v[3]-0.1, "Pressione [~b~E~w~] para acessar a barbearia.")
				if distance <= 2 then
					if IsControlJustPressed(1,38) then
						if vSERVER.openBarberShop() then
							displayBarbershop(true)
							SetEntityHeading(GetPlayerPed(-1),332.21)
						end
					end
				end
			end
		end

		Citizen.Wait(time)
	end
end) 

Citizen.CreateThread(function()
    while true do
        N_0xf4f2c0d4ee209e20() 
        Citizen.Wait(1000)
    end
end)

function DrawText3D(x,y,z, text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end


function DesligarJogador()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = PlayerPedId()
        local otherPlayer = GetPlayerPed(player)
        if ped ~= otherPlayer then
            SetEntityVisible(otherPlayer, false)
            SetEntityNoCollisionEntity(ped, otherPlayer, true)
        end
    end
end

function AtivarJogador()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = PlayerPedId()
        local otherPlayer = GetPlayerPed(player)
        if ped ~= otherPlayer then
            SetEntityVisible(otherPlayer, true)
            SetEntityCollision(ped, true)
        end
    end
end

function criarBlip()
    for _, item in pairs(locations) do
        item.blip = AddBlipForCoord(item[1], item[2], item[3])
        SetBlipSprite(item.blip, 71)
        SetBlipColour(item.blip, 13)
        SetBlipScale(item.blip, 0.4)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Barbearia")
        EndTextCommandSetBlipName(item.blip)
    end
end