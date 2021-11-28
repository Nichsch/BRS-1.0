------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE ROSTO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0, eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0, noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0, cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0, jawHeight = 0, chinLength = 0, chinPosition = 0, chinWidth = 0, chinShape = 0, neckWidth = 0, hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0, beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0, blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }
custom = currentCharacterMode

function tvRP.updateRosto(data)
    if data then
        custom = data
        atualizarRosto()
    end
end 

function f(n)
	n = n + 0.00000
	return n
end

function atualizarRosto()
	local ped = PlayerPedId()
    local data = custom
    -- ROSTO
    SetPedHeadBlendData(PlayerPedId(),data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)

	-- Olhos
	SetPedEyeColor(ped,data.eyesColor)
	-- Sobrancelha
	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)
	-- Nariz
	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)
	-- Bochechas
	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)
	-- Boca/Mandibula
	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)
	-- Queixo
	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)
	-- Pescoço
    SetPedFaceFeature(ped,19,data.neckWidth)
    
    -- Cabelo
	SetPedComponentVariation(ped,2,data.hairModel,0,0)
	SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)

	-- Sobrancelha 
	SetPedHeadOverlay(ped,2,data.eyebrowsModel, 0.99)
	SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)

	-- Barba
	SetPedHeadOverlay(ped,1,data.beardModel,0.99)
	SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)

	-- Pelo Corporal
	SetPedHeadOverlay(ped,10,data.chestModel,0.99)
	SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)

	-- Blush
	SetPedHeadOverlay(ped,5,data.blushModel,0.99)
	SetPedHeadOverlayColor(ped,5,2,data.blushColor,data.blushColor)

	-- Battom
	SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
	SetPedHeadOverlayColor(ped,8,2,data.lipstickColor,data.lipstickColor)

	-- Manchas
	SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
	SetPedHeadOverlayColor(ped,0,0,0,0)

	-- Envelhecimento
	SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
	SetPedHeadOverlayColor(ped,3,0,0,0)

	-- Aspecto
	SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
	SetPedHeadOverlayColor(ped,6,0,0,0)

	-- Pele
	SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
	SetPedHeadOverlayColor(ped,7,0,0,0)

	-- Sardas
	SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
	SetPedHeadOverlayColor(ped,9,0,0,0)

	-- Maquiagem
	SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
	SetPedHeadOverlayColor(ped,4,0,0,0)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH SYSTEM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function tvRP.varyHealth(variation)
    local ped = PlayerPedId()
    local n = math.floor(GetEntityHealth(ped)+variation)
    SetEntityHealth(ped,n)
end

function tvRP.getHealth()
    return GetEntityHealth(PlayerPedId())
end

function tvRP.setHealth(health)
    local n = math.floor(health)
    SetEntityHealth(PlayerPedId(),n)
end

function tvRP.setFriendlyFire(flag)
    NetworkSetFriendlyFireOption(flag)
    SetCanAttackFriendly(PlayerPedId(),flag,flag)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE COMA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local in_coma = false
--local in_finalizado = false
local coma_left = 10*60

Citizen.CreateThread(function()
    while true do
        local time = 1000
       
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)

        if health <= 105 and coma_left > 0 then
            time = 1
            if not in_coma then
                if IsEntityDead(ped) then
                    local x,y,z = tvRP.getPosition()
                    NetworkResurrectLocalPlayer(x,y,z,true,true,false)
                    Citizen.Wait(1)
                end
                in_coma = true
                vRPserver._updateHealth(105)
                SetEntityHealth(ped,105)
                SetEntityInvincible(ped,true)
                if IsPedInAnyVehicle(ped) then
                    tvRP.ejectVehicle()
                end
                NetworkSetVoiceActive(false)
            else
                if health < 105 then
                    SetEntityHealth(ped,105)
                end
            end
        end

        if health >= 106 and in_coma then
            in_coma = false
            SetTimeout(5000, function() coma_left = 10*60 end)
        end
        Citizen.Wait(time)
    end
end)

--[[function tvRP.setFinalizado()
    coma_left = 180
    return true
end]]

function tvRP.isInComa()
    return in_coma
end

--function tvRP.isFinalizado()
--  return in_finalizado
--end

function tvRP.killComa()
    if in_coma then
        coma_left = 0
    end
end

function tvRP.resetComa()
    coma_left = 10*60
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        SetPlayerHealthRechargeMultiplier(PlayerId(),0)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE UTI
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local in_uti = false
local uti_left = 10*30

function tvRP.isInUTI()
    return in_uti
end

local uti_tratamento = {
    { x = 349.5569152832, y = -575.65240478516, z = 43.206437601318, h = 162.16 },
    { x = 351.68878173828, y = -576.54449462891, z = 43.206432342529, h = 154.66 },
    { x = 354.41674804688, y = -577.55816650391, z = 43.206436157227, h = 148.20 },
    { x = 356.54705810547, y = -578.39562988281, z = 43.206443786621, h = 158.75 },
    { x = 359.02035522461, y = -579.23724365234, z = 43.206436157227, h = 150.71 },
    { x = 348.88278198242, y = -582.52471923828, z = 43.206428527832, h = 342.82 },
    { x = 351.73175048828, y = -583.42333984375, z = 43.206439971924, h = 336.67 },
    { x = 354.11538696289, y = -584.48315429688, z = 43.206428527832, h = 334.99 },
    { x = 356.64727783203, y = -585.17547607422, z = 43.206432342529, h = 342.86 },
}

local uti_cura = {
    { x = 331.31130981445, y = -569.1640625, z = 43.206432342529, h = 150.46 },
    { x = 328.38256835938, y = -568.02600097656, z = 43.206443786621, h = 163.02 },
    { x = 325.47964477539, y = -567.11090087891, z = 43.206432342529, h = 158.86 },
    { x = 329.25765991211, y = -575.51470947266, z = 43.206420898438, h = 338.35 },
    { x = 326.17144775391, y = -574.578125, z = 43.20641708374, h = 336.40 },
    { x = 323.04092407227, y = -573.33978271484, z = 43.206436157227, h = 334.30 },
}

function tvRP.teleportUTI(isunizk)
    Citizen.CreateThread(function()
        in_uti = true
        DoScreenFadeOut(500)
        while IsScreenFadingOut() do Citizen.Wait(0) end

        Citizen.Wait(500)

        local selectedMaca = uti_cura[math.random(1, #uti_cura)]

        if isunizk then
            selectedMaca = uti_tratamento[math.random(1, #uti_tratamento)]
        end

        FreezeEntityPosition(GetPlayerPed(-1), true)

        tvRP.teleport(selectedMaca.x,selectedMaca.y,selectedMaca.z)

        SetEntityHeading(GetPlayerPed(-1), selectedMaca.h)

        tvRP.playAnim(false,{{"dead","dead_a",1}},true)
        Citizen.Wait(1000)

        ShutdownLoadingScreen()
        DoScreenFadeIn(2000)
        while IsScreenFadingIn() do Citizen.Wait(0) end

        local pedHealth = 110
        SetEntityHealth(GetPlayerPed(-1), pedHealth)

        if isunizk then
            Citizen.Wait(5*60*1000)
        end

        if in_uti then
            tvRP.tratamentoUTI()
        end
    end)
end

local time = false

function tvRP.tratamentoUTI()
    Citizen.CreateThread(function()


            in_uti = true
            local pedHealth = 110
            SetEntityHealth(GetPlayerPed(-1), pedHealth)


            repeat

                if not time then
                    TriggerEvent("vrp_sound:source",'coracao',0.0)
                    time = true
                    SetTimeout(24*1000, function()
                        time = false
                    end)
                end

                pedHealth = pedHealth + 2
                SetEntityHealth(GetPlayerPed(-1), pedHealth)
                Citizen.Wait(1000)
            until GetEntityHealth(GetPlayerPed(-1)) == 300


            Citizen.Wait(3000)
            DoScreenFadeOut(2000)
            while IsScreenFadingOut() do Citizen.Wait(0) end

            FreezeEntityPosition(GetPlayerPed(-1), true)
            tvRP.teleport(325.2981262207,-590.57922363281,43.285358428955)
            tvRP.stopAnim(true)
            tvRP.stopAnim(false)
            in_uti = false
            in_coma = false
           -- in_finalizado = false

            FreezeEntityPosition(GetPlayerPed(-1), true)

            local timewait = 0
            repeat
                timewait = timewait + 2
                SetEntityHealth(GetPlayerPed(-1), 5)
                Citizen.Wait(500)
                SetEntityHealth(GetPlayerPed(-1), 300)
                Citizen.Wait(2000)
            until timewait >= 3

            FreezeEntityPosition(GetPlayerPed(-1), false)
            tvRP.teleport(325.2981262207,-590.57922363281,43.285358428955)
            tvRP.stopAnim(false)
            in_uti = false
            in_coma = false
           -- in_finalizado = false

            ShutdownLoadingScreen()
            DoScreenFadeIn(1000)
            while IsScreenFadingIn() do Citizen.Wait(0) end

    end)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXIBIDOR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXIBIDOR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 500
        
        if in_coma then
            time = 1
            if coma_left >= 1 then
                drawTxt("VOCE ESTÁ INCONSCIENTE, TEM ~r~"..coma_left.." ~w~SEGUNDOS DE OXIGÊNIO, CHAME OS PARAMEDICOS",4,0.5,0.93,0.50,255,255,255,255)
            elseif coma_left <= 0 then
                drawTxt("PRESSIONE ~w~[~g~E~w~] PARA VOLTAR AO HOSPITAL OU AGUARDE UM PARAMÉDICO",4,0.5,0.93,0.50,255,255,255,255)
                if IsControlJustPressed(0,38) then
                    in_coma = false
                    SetEntityInvincible(PlayerPedId(),false)
                    SetEntityHealth(PlayerPedId(),0)
                    SetTimeout(5000, function() coma_left = 10*60 end)
                end
            end
            SetPedToRagdoll(PlayerPedId(),1000,1000,0,0,0,0)
            BlockWeaponWheelThisFrame()
            DisableControlAction(0,21,true)
            DisableControlAction(0,23,true)
            DisableControlAction(0,24,true)
            DisableControlAction(0,25,true)
            DisableControlAction(0,47,true)
            DisableControlAction(0,58,true)
            DisableControlAction(0,263,true)
            DisableControlAction(0,264,true)
            DisableControlAction(0,257,true)
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
            DisableControlAction(0,143,true)
            DisableControlAction(0,75,true)
            DisableControlAction(0,22,true)
            DisableControlAction(0,32,true)
            DisableControlAction(0,268,true)
            DisableControlAction(0,33,true)
            DisableControlAction(0,269,true)
            DisableControlAction(0,34,true)
            DisableControlAction(0,270,true)
            DisableControlAction(0,35,true)
            DisableControlAction(0,271,true)
            DisableControlAction(0,288,true)
            DisableControlAction(0,289,true)
            DisableControlAction(0,170,true)
            DisableControlAction(0,73,true)
            DisableControlAction(0,177,true)
            DisableControlAction(0,344,true)
            DisableControlAction(0,29,true)
            DisableControlAction(0,182,true)
            DisableControlAction(0,168,true)
            DisableControlAction(0,187,true)
            DisableControlAction(0,189,true)
            DisableControlAction(0,190,true)
            DisableControlAction(0,188,true)
            DisableControlAction(0,104,true)
        end
        Citizen.Wait(time)
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if in_coma then
            coma_left = coma_left - 1
        end
        if in_uti then
            uti_left = uti_left - 1
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CARREGAR
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local other = nil
local drag = false
local playerStillDragged = false

RegisterNetEvent("nzk:drag")
AddEventHandler("nzk:drag", function(pl)
    other = pl
    drag = not drag
end)

RegisterNetEvent("nzk:undrag")
AddEventHandler("nzk:undrag", function()
    drag = false
end)

Citizen.CreateThread(function()
    RequestAnimDict("anim@heists@box_carry@")
    local i = 0
    while not HasAnimDictLoaded("anim@heists@box_carry@") and i < 1000 do
        Citizen.Wait(10)
        RequestAnimDict("anim@heists@box_carry@")
        i = i+1
    end

    while true do
        if drag and other ~= nil then
            local ped = GetPlayerPed(GetPlayerFromServerId(other))
            local myped = PlayerPedId()
            AttachEntityToEntity(myped, ped, 4103, 11816, 0.44, 1.04, 0.0, -270.0, 0.0, 0.0, false, false, false, false, 2, true)
            playerStillDragged = true
        else
            if(playerStillDragged) then
                DetachEntity(PlayerPedId(), true, false)
                playerStillDragged = false
            end
        end
        Citizen.Wait(0)
    end
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end
--------------------------------------------
--- Desativar Q
--------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        if health >= 101 then
            time = 1
            DisableControlAction(0,44,true)
        end

        Citizen.Wait(time)
    end
end)
--------------------------------------------
