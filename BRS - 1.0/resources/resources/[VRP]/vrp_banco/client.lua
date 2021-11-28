local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_banco")
vRPbancoC = Tunnel.getInterface("vrp_banco")
 
local RouletteWords = {
    "PASSWORD",
    "WORMSIGN",
    "ILLUSIVE",
    "DEADLOCK",
    "DYNAMITE",
    "CREAMPIE",
    "MORPHEUS"
}

function ScaleformLabel(label)
    BeginTextCommandScaleformString(label)
    EndTextCommandScaleformString()
end

local scaleform = nil
local lives = 5
local ClickReturn
local SorF = false
local Hacking = false
local UsingComputer = false
local hackingBank = nil
local segundos = 0
local andamento = false
local abrirPortas = false

Citizen.CreateThread(function()
    function Initialize(scaleform)
        local scaleform = RequestScaleformMovieInteractive(scaleform)
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end
        
        local CAT = 'hack'
        local CurrentSlot = 0
        while HasAdditionalTextLoaded(CurrentSlot) and not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
            Citizen.Wait(0)
            CurrentSlot = CurrentSlot + 1
        end
        
        if not HasThisAdditionalTextLoaded(CAT, CurrentSlot) then
            ClearAdditionalText(CurrentSlot, true)
            RequestAdditionalText(CAT, CurrentSlot)
            while not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                Citizen.Wait(0)
            end
        end

        PushScaleformMovieFunction(scaleform, "SET_LABELS")
        ScaleformLabel("H_ICON_1")
        ScaleformLabel("H_ICON_2")
        ScaleformLabel("H_ICON_3")
        ScaleformLabel("H_ICON_4")
        ScaleformLabel("H_ICON_5")
        ScaleformLabel("H_ICON_6")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
        PushScaleformMovieFunctionParameterInt(4)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("My Computer")
        PopScaleformMovieFunctionVoid()
        
        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("My Computer")
        PopScaleformMovieFunctionVoid()
        
        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterString("Power Off")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(lives)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(lives)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(1)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(4)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(5)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(6)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(7)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()
        

        return scaleform
    end
    scaleform = Initialize("HACKING_PC")
    while true do
        Citizen.Wait(0)
        if UsingComputer then
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            PushScaleformMovieFunction(scaleform, "SET_CURSOR")
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
            PopScaleformMovieFunctionVoid()
            if IsDisabledControlJustPressed(0,24) and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_SELECT")
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 25) and not Hacking and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_BACK")
                PopScaleformMovieFunctionVoid()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if HasScaleformMovieLoaded(scaleform) and UsingComputer then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                ProgramID = GetScaleformMovieFunctionReturnInt(ClickReturn)
                -- print("ProgramID: "..ProgramID)
                if ProgramID == 83 and not Hacking then
                    lives = 5
                    
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(lives)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()

                    PushScaleformMovieFunction(scaleform, "OPEN_APP")
                    PushScaleformMovieFunctionParameterFloat(1.0)
                    PopScaleformMovieFunctionVoid()
                    
                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_WORD")
                    PushScaleformMovieFunctionParameterString(RouletteWords[math.random(#RouletteWords)])
                    PopScaleformMovieFunctionVoid()

                    Hacking = true
                elseif ProgramID == 82 and not Hacking then
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and ProgramID == 87 then
                    lives = lives - 1
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(lives)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and ProgramID == 92 then
                    PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
                elseif Hacking and ProgramID == 86 then
                    SorF = true
                    PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                    PushScaleformMovieFunctionParameterBool(true)
                    ScaleformLabel("WINBRUTE")
                    PopScaleformMovieFunctionVoid()
                    Wait(0)
                    PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                    PopScaleformMovieFunctionVoid()
                    Hacking = false
                    SorF = false    
                    local v = Config.BankRobbery[hackingBank]
                    TriggerServerEvent('loffe_heist:setDoorFreezeStatus', hackingBank, #v.Doors, false)
                    mHacking = false
                    -- TriggerServerEvent('esx_phone:send', 'police', 'Ett dataintrång har skett på ' .. v.BankName .. ' och bankvalvet har öppnats!', {x = v.Doors[#v.Doors].Coords.x, y = v.Doors[#v.Doors].Coords.y, z = v.Doors[#v.Doors].Coords.z})
                elseif ProgramID == 6 then
                    UsingComputer = false
                    SetScaleformMovieAsNoLongerNeeded(scaleform)
                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                end
                
                if Hacking then
                    PushScaleformMovieFunction(scaleform, "SHOW_LIVES")
                    PushScaleformMovieFunctionParameterBool(true)
                    PopScaleformMovieFunctionVoid()
                    if lives <= 0 then
                        SorF = true
                        PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(false)
                        ScaleformLabel("LOSEBRUTE")
                        PopScaleformMovieFunctionVoid()
                        Wait(5000)
                        local v = Config.BankRobbery[hackingBank]
                        -- TriggerServerEvent('esx_phone:send', 'police', 'En anonym person har försökt att göra intrång i ' .. v.BankName .. 's system!', {x = v.Doors[#v.Doors].Coords.x, y = v.Doors[#v.Doors].Coords.y, z = v.Doors[#v.Doors].Coords.z})

                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        Hacking = false
                        SorF = false
                        mHacking = false
                    end
                end
            end
        else
            Wait(250)
        end
    end
end)

local mHacking = false

function USBSuccess(success, timeremaining)
    if success then
        TriggerEvent('cancelando',false)
        TriggerEvent('mhacking:hide')
        scaleform = Initialize("HACKING_PC")
        UsingComputer = true
    else
        TriggerEvent('mhacking:hide')
        FreezeEntityPosition(PlayerPedId(), false)
        local v = Config.BankRobbery[hackingBank]
        TriggerEvent('cancelando',false)
        mHacking = false
    end
end

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, v.Hacking.Coords, true) <= 2.0 and v.Doors[#v.Doors].Frozen and not mHacking then
                local allowed = false
                if #v.Doors > 1 then
                    if not v.Doors[#v.Doors - 1].Frozen then
                        allowed = true
                    end
                else
                    allowed = true
                end
                if allowed then
                    TriggerEvent('loffe_heist:helpTimed', 'Pressione ~INPUT_CONTEXT~ para Hackear o banco', 25)
                    if IsControlPressed(0, 38) then
                        local police = nil
                            mHacking = true
                            TriggerEvent('cancelando',true)
                            TriggerEvent('mhacking:hide')
                            FreezeEntityPosition(PlayerPedId(), true)
                            hackingBank = k
                            TriggerEvent("mhacking:show")
                            TriggerEvent("mhacking:start", 3, 60, USBSuccess)
                    end
                end
                Wait(10)
            end
        end
        Wait(100)
    end
end)

local hasDrill = false
local hasWeld = false

function bagAllowed()
    local allowed = false
    TriggerEvent('skinchanger:getSkin', function(skin)
        for i = 1, #Config.AllowedBags do
            if skin.bags_1 == Config.AllowedBags[i] then
                allowed = skin.bags_1
                break
            end
        end
    end)
    return allowed
end

local soundid = nil

RegisterNetEvent('loffe_heist:updateMoney')
AddEventHandler('loffe_heist:updateMoney', function(bank, money)
    Config.BankRobbery[bank].Money.Amount = money
end)

local moneyPile = {}

local bagProps = {
    [40] = 'p_ld_heist_bag_s_pro_o', 
    [41] = 'p_ld_heist_bag_s_pro_o',
    [44] = 'prop_cs_heist_bag_01',
    [45] = 'prop_cs_heist_bag_01'
}

local sdfwa = nil
Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(50)
    end
    Wait(500)
    while true do
        rememberMoneyTable = moneyPile
        moneyPile = {}
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            sdfwa = nil

            TriggerServerEvent('loffe_heist:getBox', box)

            while sdfwa == nil do
                Wait(0)
            end
            v.Money.Box = sdfwa

            local model = GetHashKey(v.Money.Box)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end

            local object = CreateObject(model, v.Money.BoxPosition, false, false)
            FreezeEntityPosition(object, true)
            SetEntityAsMissionEntity(object, true, true)
            table.insert(moneyPile, {Object = object})
            for i = 1, #rememberMoneyTable do
                DeleteEntity(rememberMoneyTable[i].Object)
            end
        end
        Wait(5000)
    end
end)

RegisterNetEvent('loffe_heist:getBox')
AddEventHandler('loffe_heist:getBox', function(box)
    sdfwa = box
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(50)
    end
    Wait(500)
    local fakeTimer = 500
    local bag = false
    while true do
        fakeTimer = fakeTimer + 1
        if fakeTimer >= 500 then
            bag = bagAllowed()
            fakeTimer = 0
        end
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, v.Money.BoxPosition, true) <= 1.5 and not v.Doors[#v.Doors].Frozen then
                if v.Money.Amount > 0 then
                    BeginTextCommandDisplayHelp('STRING')
                    AddTextComponentSubstringPlayerName('Pressione ~INPUT_CONTEXT~ para pegar dinheiro')
                    EndTextCommandDisplayHelp(0, false, true, -1)
                    if IsControlPressed(0, 38) then
                        local police = nil
                            TaskClearLookAt(player)
                            TaskLookAtCoord(player, v.Money.BoxPosition, 1000, 0, 2)
                            Wait(500)
                            local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
                            SetCamCoord(cam, v.Money.Cam.Coords.x, v.Money.Cam.Coords.y, v.Money.Cam.Coords.z)
                            SetCamRot(cam, v.Money.Cam.Rotation.rx, v.Money.Cam.Rotation.ry, v.Money.Cam.Rotation.rz, v.Money.Cam.Rotation.r)
                            RenderScriptCams(1, 0, 0, 1, 1)
                            SetCamActive(cam, true)


                            TriggerEvent('cancelando',true)
                            local cash_hash = GetHashKey("hei_prop_heist_cash_pile")
                            RequestModel(cash_hash)
                            while not HasModelLoaded(cash_hash) do
                                Wait(0)
                            end

                            RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
                            while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
                                Wait(10)
                            end
                            TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "intro", 8.0, -8.0, -1, 1, 0, false, false, false)
                            Wait(1000)

                            local bagHash = GetHashKey(bagProps[44])
                            RequestModel(bagHash)
                            while not HasModelLoaded(bagHash) do
                                Wait(0)
                            end
                            local bagProp = CreateObject(bagHash, coords, true, false)
                            SetEntityAsMissionEntity(bagProp, true, true)
                            local bagIndex = GetPedBoneIndex(PlayerPedId(), 57005)
                            if bagProps[44] == 'p_ld_heist_bag_s_pro_o' then
                                AttachEntityToEntity(bagProp, PlayerPedId(), bagIndex, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
                            else
                                AttachEntityToEntity(bagProp, PlayerPedId(), bagIndex, -0.1, -0.05, -0.42, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
                            end
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                local clothesSkin = {['bags_1'] = 0}
                                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                            end)

                            local cashPile = CreateObject(cash_hash, 0, 0, 0, true, false)
                            SetEntityAsMissionEntity(cashPile, true, true)
                            local boneIndex = GetPedBoneIndex(PlayerPedId(), 18905)
                            while v.Money.Amount > 0 do
                                Wait(150)
                                TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
                                TriggerEvent('loffe_heist:helpTimed', 'Segure ~INPUT_JUMP~ para parar de pegar dinheiro', 100)
                                Wait(350)
                                TriggerServerEvent('loffe_heist:takeMoney', k)
                                AttachEntityToEntity(cashPile, PlayerPedId(), boneIndex, 0.125, 0.0, 0.05, 5.0, 150.0, 300.0, true, true, false, true, 1, true)
                                Wait(500)
                                DetachEntity(cashPile, false, false)
                                SetEntityCoords(cashPile, 0, 0, 0)
                                if IsDisabledControlPressed(0, 22) then
                                    break
                                end
                            end
                            RenderScriptCams(false, false, 0, true, false)
                            DestroyCam(cam, false)
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                local clothesSkin = {['bags_1'] = bag}
                                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                            end)
                            TaskClearLookAt(player)
                            DeleteEntity(cashPile)
                            DeleteEntity(bagProp)
                            ClearPedTasks(player)
                            TriggerEvent('cancelando',false)
                            for i = 1, #rememberMoneyTable do
                                DeleteEntity(rememberMoneyTable[i].Object)
                            end
                    end
                end
            end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.BankRobbery) do
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, v.Money.BoxPosition, true) <= 2.0 then
                local position = v.Money.BoxPosition
                DrawText3D(position.x, position.y, position.z + 0.5 , '~g~$'.. v.Money.Amount, 0.8)
            else
                Wait(250)
            end
        end
        Wait(0)
    end
end)

local state = 0
local inMission = false
local ped = {}
local currentDrillAnim = 'drill_straight_idle'

RegisterNetEvent('loffe_heist:getTimeCl')
AddEventHandler('loffe_heist:getTimeCl', function(x)
    if x then
        state = 1
    else
        state = 0
    end
end)

local weldedDoors = {}

RegisterNetEvent('loffe_heist:setDoorFreezeStatusCl')
AddEventHandler('loffe_heist:setDoorFreezeStatusCl', function(bank, door, status)
    Config.BankRobbery[bank].Doors[door].Frozen = status
end)

RegisterNetEvent('loffe_heist:safeLooted')
AddEventHandler('loffe_heist:safeLooted', function(bank, safe, toggle)
    Config.BankRobbery[bank].Safes[safe].Looted = toggle
end)

RegisterNetEvent('loffe_heist:text')
AddEventHandler('loffe_heist:text', function(text, x, y, time)
    --drawSub(text, 4, 1, x, y, 0.5, 255, 255, 255, 255, time)
end)

RegisterNetEvent('loffe_heist:helpTimed')
AddEventHandler('loffe_heist:helpTimed', function(text, time)
    local faketimer = time
    while faketimer >= 0 do
        faketimer = faketimer - 1
        Wait(0)
        BeginTextCommandDisplayHelp('STRING')
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayHelp(0, false, true, -1)
    end
end)

Citizen.CreateThread(function()
    while true do
        hasDrill = true
        hasWeld = true
        Wait(7500)
    end
end)

local solda = nil
local cops = nil

local pressionou = false
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
        if andamento then
            drawTxt("VOCÊ ESTA ROUBANDO O ~b~BANCO CENTRAL",4,0.5,0.91,0.41,255,255,255,150)
            drawTxt("RESTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR",4,0.5,0.93,0.36,255,255,255,150)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Wait(250)
        for i = 1, #Config.BankRobbery do
            local v = Config.BankRobbery[i]
            for j = 1, #v.Doors do
                local d = v.Doors[j]
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                if GetDistanceBetweenCoords(coords, d.Coords, true) <= 2.5 and d.Frozen then
                    if hasWeld then
                        while GetDistanceBetweenCoords(GetEntityCoords(player), d.Coords, true) <= 2.5 and d.Frozen and not d.Hacking do
                            local allowed = false
                            if j == 1 then
                                allowed = true
                            else
                                if j ~= #v.Doors then
                                    if not v.Doors[j-1].Frozen then
                                        allowed = true
                                    else
                                        allowed = false
                                    end
                                else
                                    allowed = true
                                end
                            end
                            Wait(50)
                            if allowed then
                                TriggerEvent('loffe_heist:helpTimed', 'Aperte ~INPUT_CONTEXT~ para soldar a porta', 50)
                                if not pressionou then
                                    if not andamento then
                                        if IsControlPressed(0, 38) then
                                            pressionou = true
                                            
                                            if vRPbancoC.checkSolda(player) then
                                                if vRPbancoC.checkPolicia(player) then
                                                    ClearPedTasks(player)
                                                    SetEntityCoords(player, d.WeldPosition.C)
                                                    SetEntityHeading(player, d.WeldPosition.H)
                                                    Wait(50)
                                                    TaskStartScenarioInPlace(player, 'WORLD_HUMAN_WELDING', 0, true)
                                                    vRP._playAnim(false,{task="WORLD_HUMAN_WELDING"},false)

                                                    segundos = 60
                                                    andamento = true
                                                    TriggerEvent('cancelando',true)
                                                    SetTimeout(60000, function()
                                                        TriggerServerEvent('loffe_heist:setDoorFreezeStatus', i, j, false) 
                                                    end)
                                                end
                                            end

                                            Wait(1000)
                                            pressionou = false
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(0)
    end
    Wait(250)
    for i = 1, #Config.BankRobbery do
        for j = 1, #Config.BankRobbery[i].Doors do
            TriggerServerEvent('loffe_heist:getDoorFreezeStatus', i, j)
        end
    end
    while true do
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        for i = 1, #Config.BankRobbery do
            Wait(0)
            local v = Config.BankRobbery[i]
            for j = 1, #v.Doors do
                Wait(0)
                local d = v.Doors[j]
                local door = GetClosestObjectOfType(d.Coords, 2.0, GetHashKey(d.Object), false, 0, 0)
                if door ~= nil then
                    if not d.Frozen then
                        if d.OpenHeading ~= nil then
                            SetEntityHeading(door, d.OpenHeading)
                        end
                    end
                    FreezeEntityPosition(door, d.Frozen)
                    if d.Frozen then
                        SetEntityHeading(door, d.Heading)
                    end
                end
            end
        end
        Wait(250)
    end
end)

local drilling = false
local finishedDrilling = false
local speed = 0.0
local temperature = 0.0
local depth = 0.1
local position = 0.0
local drillEntity = {}
local playSound = true

local furadeira = nil

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        for i = 1, #Config.BankRobbery do
            Wait(0)
            for j = 1, #Config.BankRobbery[i].Safes do
                Wait(0)
                local s = Config.BankRobbery[i].Safes[j]
                if not s.Looted then
                    if hasDrill then
                        if GetDistanceBetweenCoords(coords, s.Coords, true) <= 1.0 and not Config.BankRobbery[i].Doors[#Config.BankRobbery[i].Doors].Frozen then
                            TriggerEvent('loffe_heist:helpTimed', 'Pressione ~INPUT_CONTEXT~ para arrombar a caixa', 5)
                            if IsControlPressed(0, 38) then
                                
								if vRPbancoC.checkFuradeira() then
                                    TriggerServerEvent('loffe_heist:toggleSafe', i, j, true)
                                    FreezeEntityPosition(player, true)
                                    SetPedCurrentWeaponVisible(player, false, true, 0, 0)
                                    SetEntityCoords(player, s.Coords)
                                    SetEntityHeading(player, s.Heading)
                                    drilling = true
                                    speed = 0.0
                                    temperature = 0.0
                                    depth = 0.1
                                    position = 0.0

                                    local drill_hash = GetHashKey("hei_prop_heist_drill")
                                    RequestModel(drill_hash)
                                    while not HasModelLoaded(drill_hash) do
                                        Wait(0)
                                    end
                                    drillEntity = CreateObject(drill_hash, Config.DrillSpawns[#Config.DrillSpawns], true, false)
                                    SetEntityAsMissionEntity(drill, true, true)
                                    local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
                                    Wait(500)
                                    AttachEntityToEntity(drillEntity, PlayerPedId(), boneIndex, 0.125, 0.0, -0.05, 100.0, 300.0, 135.0, true, true, false, true, 1, true)

                                    if soundid ~= nil then
                                        StopSound(soundid)
                                        ReleaseSoundId(soundid)
                                    end
                                                
                                    soundid = GetSoundId()

                                    local ped_hash = -39239064
                                    RequestModel(ped_hash)
                                    while not HasModelLoaded(ped_hash) do
                                        Wait(5)
                                    end
                                    local soundPed = CreatePed(4, ped_hash, coords.x, coords.y, coords.z - 1.5, 0.0, true, false)
                                    FreezeEntityPosition(soundPed, true)
                                    SetEntityVisible(soundPed, false)
                                    TaskStartScenarioInPlace(soundPed, "WORLD_HUMAN_CONST_DRILL", 0, true)  
                                    SetEntityInvincible(soundPed, true)
                                    SetEntityAsMissionEntity(soundPed, true, true)
                                    SetPedHearingRange(soundPed, 0.0)
                                    SetPedSeeingRange(soundPed, 0.0)
                                    SetPedAlertness(soundPed, 0.0)
                                    SetPedFleeAttributes(soundPed, 0, 0)
                                    SetBlockingOfNonTemporaryEvents(soundPed, true)
                                    SetPedCombatAttributes(soundPed, 46, true)
                                    SetPedFleeAttributes(soundPed, 0, 0)

                                    TriggerEvent('cancelando',true)

                                    local camFrom = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
                                    local camFromInfo = s.Cam.From
                                    local camToInfo = s.Cam.To
                                    SetCamCoord(camFrom, camFromInfo.x, camFromInfo.y, camFromInfo.z)
                                    SetCamRot(camFrom, camFromInfo.rx, camFromInfo.ry, camFromInfo.rz, camFromInfo.r)
                                    RenderScriptCams(1, 0, 0, 1, 1)

                                    local camTo = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
                                    SetCamCoord(camTo, camToInfo.x, camToInfo.y, camToInfo.z)
                                    SetCamRot(camTo, camToInfo.rx, camToInfo.ry, camToInfo.rz, camToInfo.r)
                                    RenderScriptCams(1, 0, 0, 1, 1)
                                    local firstcam = 'camTo'
                                    local active = SetCamActive(camFrom, true)

                                    while drilling do
                                        Wait(100)
                                        if not playSound or speed <= 0.1 then
                                            DeleteEntity(soundPed)
											if IsControlJustPressed(1,22) then
												TriggerServerEvent('loffe_heist:deleteDrill', coords)
											end
                                        else
                                            if not DoesEntityExist(soundPed) then
                                                RequestModel(ped_hash)
                                                while not HasModelLoaded(ped_hash) do
                                                    Wait(5)
                                                end
                                                soundPed = CreatePed(4, ped_hash, coords.x, coords.y, coords.z - 1.5, 0.0, true, false)
                                                FreezeEntityPosition(soundPed, true)
                                                SetEntityVisible(soundPed, false)
                                                TaskStartScenarioInPlace(soundPed, "WORLD_HUMAN_CONST_DRILL", 0, true)  
                                                SetEntityInvincible(soundPed, true)
                                                SetEntityAsMissionEntity(soundPed, true, true)
                                                SetPedHearingRange(soundPed, 0.0)
                                                SetPedSeeingRange(soundPed, 0.0)
                                                SetPedAlertness(soundPed, 0.0)
                                                SetPedFleeAttributes(soundPed, 0, 0)
                                                SetBlockingOfNonTemporaryEvents(soundPed, true)
                                                SetPedCombatAttributes(soundPed, 46, true)
                                                SetPedFleeAttributes(soundPed, 0, 0)

                                            end
                                        end
                                        if IsDisabledControlPressed(0, 22) then
                                            drilling = false
                                            Wait(250)
                                            ClearPedTasks(player)
                                            break
                                        end
                                    end
                                    if finishedDrilling then
                                        TriggerServerEvent('loffe_heist:lootSafe', i, j)
                                    else
                                        TriggerServerEvent('loffe_heist:toggleSafe', i, j, false)
                                    end
                                    TriggerEvent('cancelando',false)
                                    ClearPedTasks(player)
                                    RenderScriptCams(false, false, 0, true, false)
                                    DestroyCam(active, false)

                                    Wait(100)

                                    drilling = false
                                    finishedDrilling = false
                                    speed = 0.0
                                    temperature = 0.0
                                    depth = 0.1
                                    position = 0.0

                                    Wait(100)

                                    DeleteEntity(drillEntity)
                                    FreezeEntityPosition(player, false)

                                    Wait(100)

                                    DeleteEntity(soundPed)
                                    SetEntityAsMissionEntity(jackham, true, true)
                                    DeleteEntity(jackham)
                                    drillEntity = {}
								end
							end
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)

local heading = {
    [1] = 352,
}

local scaleform = {}

function drillScaleform()
    scaleform = RequestScaleformMovie("DRILLING")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
end

Citizen.CreateThread(function()
    while true do
        while drilling do
            local text = '~INPUT_CELLPHONE_UP~ Broca \n~INPUT_CELLPHONE_DOWN~ Retire a broca\n~INPUT_JUMP~ Pare de perfurar'
			AddTextEntry("loffe_heist_drill_info_text", text)
			DisplayHelpTextThisFrame("loffe_heist_drill_info_text", false)

            drillScaleform()
            Wait(0)
            BeginScaleformMovieMethod(scaleform, "SET_SPEED")
            PushScaleformMovieMethodParameterFloat(speed)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_HOLE_DEPTH")
            PushScaleformMovieMethodParameterFloat(depth)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_DRILL_POSITION")
            PushScaleformMovieMethodParameterFloat(position)
            EndScaleformMovieMethod()

            BeginScaleformMovieMethod(scaleform, "SET_TEMPERATURE")
            PushScaleformMovieMethodParameterFloat(temperature)
            EndScaleformMovieMethod()
        end
        Wait(250)
    end
end)

local particleLooped = nil

Citizen.CreateThread(function()
    while true do
        if drilling then
            if depth-position >= 0 then
                currentDrillAnim = 'drill_straight_idle'
            end
            RequestAnimDict('anim@heists@fleeca_bank@drilling')
            while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do
                Wait(10)
            end
            if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', currentDrillAnim, 3) then
                TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', currentDrillAnim, 8.0, 8.0, -1, 17, 1, false, false, false)
            end
        end
        Wait(250)
    end
end)

RegisterNetEvent('loffe_heist:particleTimer')
AddEventHandler('loffe_heist:particleTimer', function(time)
    Wait(time)
    StopParticleFxLooped(particleLooped)
    particleLooped = nil
end)

Citizen.CreateThread(function()
    while true do
        Wait(750)
        if drilling then
            while drilling do
                Wait(0)
                if IsDisabledControlPressed(0, 172) and not finishedDrilling then
                    if temperature < 1.0 then
                        RequestAnimDict('anim@heists@fleeca_bank@drilling')
                        while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do
                            Wait(10)
                        end
                        TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_start', 8.0, 8.0, -1, 17, 1, false, false, false)
                        while IsDisabledControlPressed(0, 172) and temperature < 1.0 do
                            drilling = true
                            if speed < 0.7 then
                                speed = speed + (math.random(1, 5)/100)
                            end
                            if depth-position >= 0 then
                                position = position + ((math.random(1, 5)/1000)+(speed/10))
                                currentDrillAnim = 'drill_straight_idle'
                                playSound = false
                            else
                                local randomDepth = math.random(1, 5)/1000
                                depth = depth + randomDepth
                                position = position + randomDepth
                                temperature = temperature + 0.005
                                playSound = true

                                currentDrillAnim = 'drill_straight_start'

                                local c = GetEntityCoords(drillEntity)
                            end
                            if depth >= 0.9 then
                                drilling = false
                                finishedDrilling = true
                                break
                            end
                            Wait(100)
                        end
                        if temperature >= 1.0 then
                            playSound = false
                            local c = GetEntityCoords(drillEntity)
                            RequestNamedPtfxAsset("core")
                            while not HasNamedPtfxAssetLoaded("core") do
                                Wait(0)
                            end
                            UseParticleFxAssetNextCall("core")
                            particleLooped = StartParticleFxLoopedAtCoord("ent_amb_exhaust_thick", c, 0.0, 0.0, 0.0, 0.5, false, false, false, 0)
                            SetParticleFxLoopedEvolution(particleLooped, "ent_amb_exhaust_thick", 0.5, 0)

                            for i = 1, 100 do
                                if speed > 0 then
                                    speed = speed - 0.01
                                end
                                if temperature > 0 then
                                    temperature = temperature - 0.01
                                end
                                if position > 0 then
                                    position = position - 0.01
                                end
                                if temperature <= 0.2 then
                                    break   
                                end
                                Wait(250)
                            end
                            playSound = true
                            TriggerEvent('loffe_heist:particleTimer', 750)
                        end
                    else
                        playSound = false
                        local c = GetEntityCoords(drillEntity)
                        RequestNamedPtfxAsset("core")
                        while not HasNamedPtfxAssetLoaded("core") do
                            Wait(0)
                        end
                        UseParticleFxAssetNextCall("core")
                        particleLooped = StartParticleFxLoopedAtCoord("ent_amb_exhaust_thick", c, 0.0, 0.0, 0.0, 0.5, false, false, false, 0)
                        SetParticleFxLoopedEvolution(particleLooped, "ent_amb_exhaust_thick", 0.5, 0)
                        for i = 1, 100 do
                            if speed > 0 then
                                speed = speed - 0.01
                            end
                            if temperature > 0 then
                                temperature = temperature - 0.01
                            end
                            if position > 0 then
                                position = position - 0.005
                            end
                            if temperature <= 0.2 then
                                break   
                            end
                            Wait(250)
                        end
                        playSound = true
                        TriggerEvent('loffe_heist:particleTimer', 750)
                    end
                elseif IsDisabledControlPressed(0, 173) then
                    playSound = false
                    position = position - 0.015
                    temperature = temperature - 0.015
                    speed = speed - 0.015
                    Wait(50)
                else
                    if speed > 0.0 then
                        speed = speed - 0.01
                        Wait(50)
                    end
                    if temperature > 0.0 then
                        temperature = temperature - 0.01
                        Wait(50)
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
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

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
 
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
 
    AddTextComponentString(text)
    DrawText(_x, _y)
 
    local factor = (string.len(text)) / 230
    DrawRect(_x, _y + 0.0250, 0.095 + factor, 0.06, 41, 11, 41, 100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
            segundos = segundos - 1
			if segundos <= 0 then
                abrirPortas = true
                andamento = false
                TriggerEvent('cancelando',false)
                ClearPedTasks(PlayerPedId())
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWS
-----------------------------------------------------------------------------------------------------------------------------------------
-- Scaleform News
local newsScaleFormCounter = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		if newsScaleFormCounter > 0 then
			newsScaleFormCounter = newsScaleFormCounter - 1
		end
	end
end)

RegisterNetEvent("nzk:bankNews")
AddEventHandler("nzk:bankNews", function(counter)
	newsScaleFormCounter = counter
	PlaySound(-1, "RANK_UP", "HUD_AWARDS", 0, 0, 1)
end)

Citizen.CreateThread(function()
	local scaleform = RequestScaleformMovie("BREAKING_NEWS")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(100)
	end
	if HasScaleformMovieLoaded(scaleform) then

		PushScaleformMovieFunction(scaleform, "SET_DISPLAY_CONFIG")
		PushScaleformMovieFunctionParameterInt(1920)
		PushScaleformMovieFunctionParameterInt(1080)
		PushScaleformMovieFunctionParameterFloat(0.5)
		PushScaleformMovieFunctionParameterFloat(0.5)
		PushScaleformMovieFunctionParameterFloat(0.5)
		PushScaleformMovieFunctionParameterFloat(0.5)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		PopScaleformMovieFunctionVoid()
		
		PushScaleformMovieFunction(scaleform, "SET_TEXT")
		PushScaleformMovieFunctionParameterString("Assalto a Banco!")
		PushScaleformMovieFunctionParameterString("<b>Policiais</b> <i>a</i> ~r~Caminho!")
		PopScaleformMovieFunctionVoid()
		
		PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterString("~r~Noticia de Última Hora")
		PopScaleformMovieFunctionVoid()

		
		PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(100)
		PopScaleformMovieFunctionVoid()
		
		while true do
			Citizen.Wait(1)
			if newsScaleFormCounter > 0 then
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
			end
        end
		
	end
end)