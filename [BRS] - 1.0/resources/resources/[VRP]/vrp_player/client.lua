local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPplayerS = Tunnel.getInterface("vrp_player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('chatME')
AddEventHandler('chatME',function(id,name,message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)),GetEntityCoords(GetPlayerPed(pid))) < 3.999 then
		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
	end 
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local css = [[
	@import url('https://fonts.googleapis.com/css?family=Muli:300,400,700');

	.clear {
		clear: both;
	}

	#DocumentSection {
		background-color: rgba(0, 166, 255, 0.3);
		width: 300px;
		min-height: 250px;
		border-radius: 5px;
		box-shadow: 0px 0px 3px rgba(255, 255, 255, 0.08);
		text-align: center;
		position: absolute;
		right: 2.5%;
		bottom: 13%;
		font-family: 'Muli';
		color: #ffffff;
		padding-bottom: 17px;
		z-index: 1;
		overflow: hidden;
		border: 1px solid #000;
	}

	#DocumentSection:before,
	#DocumentSection:after {
		content: ' ';
		position: absolute;
		width: 200%;
		height: 200%;
	}

	#DocumentSection:before {
		background-color: rgba(197, 31, 31, 0.068);
		top: -193%;
		left: -100%;
		transform: rotate(-5deg);
		z-index: 1;
	}

	#DocumentSection:after {
		background-color: rgba(197, 31, 31, 0.068);
		top: -191%;
		left: -100%;
		transform: rotate(-6deg);
		z-index: 0;
	}

	#DocumentSection .avatar-img {
		width: 185px;
		height: 185px;
		margin: 30px auto 0 auto;
		overflow:hidden;
		border-radius: 50px;
	}

	#DocumentSection .avatar-img img {
		width: 100%;
	}

	#DocumentSection .each-info {
		display: block;
		margin: 0;
		width: 90%;
		margin: 0 auto;
	}

	#DocumentSection .each-info.person-name {
		font-size: 20px;
	}

	#DocumentSection .each-info.person-age {
		font-size: 15px;
	}

	#DocumentSection .each-info.person-job {
		border-top: 1px solid rgba(255,255,255, 0.8);
		border-bottom: 1px solid rgba(255,255,255, 0.8);
		margin: 25px auto;
		padding: 10px 0;
		color: #ffffff;
		font-size: 18px;
	}

	#DocumentSection .secondary-info {
		margin-top: 15px;
	}

	#DocumentSection .secondary-info .clear {
		margin-bottom: 3px;
		display: block;
	}

	#DocumentSection .secondary-info .each-info strong {
		float: left;
		font-weight: 300;
	}

	#DocumentSection .secondary-info .each-info span {
		float: right;
		font-weight: bold;
		color: #ffffff;
	}
]]
 -- https://cdn.discordapp.com/attachments/751252347757264936/753445581598228510/brs_png3.png

local identity = false

RegisterCommand("rg",function(source,args)
	local source = source
	if identity then
		vRP._removeDiv("registro")
		identity = false
		
	else
		
		Citizen.Wait(150)
		local carteira,banco,nome,sobrenome,user_id,identidade,idade,telefone,job,org,cnh,parmas,vip,valormultas,propriedades = vRPplayerS.Identidade()
		local html = string.format( "<div id='DocumentSection'><div class='avatar-img'><img src='https://cdn.discordapp.com/attachments/751252347757264936/753445581598228510/brs_png3.png'></div> <div class='infos'><div class='main-info'>".. "<h1 class='each-info person-name'>%s %s</h1>".. "<h2 class='each-info person-age'>%s anos</h2>".. "<h2 class='each-info person-job'>%s</h2>".. "</div>".. "<div class='secondary-info'>".. "<div class='each-info'><strong>Passaporte:</strong><span class='person-id'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Trabalho:</strong><span class='person-id'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Registro: </strong><span class='person-passport'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Telefone:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Carteira:</strong><span class='person-phone'>$ %s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Banco:</strong><span class='person-phone'>$ %s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>CNH:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Porte de Armas:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Socio:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Multas:</strong><span class='person-phone'>$ %s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Propriedades:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "</div>".. "</div>".. "</div>", nome, sobrenome, idade, org, user_id, job, identidade, telefone, carteira, banco, cnh, parmas, vip, valormultas, propriedades)
		identity = true
		vRP._setDiv("registro", css, html)
		if vRPplayerS.fecharIdentidade(source) then identity = false TriggerEvent('hud:Aparecer', source) end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,344) then
			local source = source
			if identity then
				vRP._removeDiv("registro")
				identity = false
			else
				Citizen.Wait(150)
				local carteira,banco,nome,sobrenome,user_id,identidade,idade,telefone,job,org,cnh,parmas,vip,valormultas,propriedades = vRPplayerS.Identidade()
				local html = string.format( "<div id='DocumentSection'><div class='avatar-img'><img src='https://cdn.discordapp.com/attachments/751252347757264936/753445581598228510/brs_png3.png'></div> <div class='infos'><div class='main-info'>".. "<h1 class='each-info person-name'>%s %s</h1>".. "<h2 class='each-info person-age'>%s anos</h2>".. "<h2 class='each-info person-job'>%s</h2>".. "</div>".. "<div class='secondary-info'>".. "<div class='each-info'><strong>Passaporte:</strong><span class='person-id'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Trabalho:</strong><span class='person-id'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Registro: </strong><span class='person-passport'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Telefone:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Carteira:</strong><span class='person-phone'>$ %s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Banco:</strong><span class='person-phone'>$ %s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>CNH:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Porte de Arma:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Socio:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Multas:</strong><span class='person-phone'>$ %s</span></div>".. "<div class='clear'></div>".. "<div class='each-info'><strong>Propriedades:</strong><span class='person-phone'>%s</span></div>".. "<div class='clear'></div>".. "</div>".. "</div>".. "</div>", nome, sobrenome, idade, org, user_id, job, identidade, telefone, carteira, banco, cnh, parmas, vip, valormultas, propriedades)
				identity = true
				vRP._setDiv("registro", css, html)
				if vRPplayerS.fecharIdentidade(source) then identity = false TriggerEvent('hud:Aparecer', source) end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SALARIOS CONTADOR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60*1000*40)
		TriggerServerEvent('NZK:salarios')
		Citizen.Wait(60*1000*5)
		TriggerServerEvent('NZK:salariosVIP')
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------
-- VERID
-----------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,83) then 
			local source = source
			if not IsPauseMenuActive() then
				vRPplayerS.checkId(source)
			end 
		end
	end
end) 

RegisterCommand('id', function(source, args)
	local source = source
	vRPplayerS.checkId(source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------------
-- MORTO
-----------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0,39328) then 
			local source = source
			if not IsPauseMenuActive() then
				vRPplayerS.checkMorto(source)
			end 
		end
	end
end) 

RegisterCommand('pulso', function(source, args)
	local source = source
	vRPplayerS.checkMorto(source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------------
-- CHECK MONSTER MENU
-----------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		  if IsControlJustPressed(1, 288) or IsControlJustPressed(1, 344) or IsControlJustPressed(1, 121) or IsDisabledControlJustPressed(1, 288) or IsDisabledControlJustPressed(1, 344) or IsDisabledControlJustPressed(1, 121) then
		    vRPplayerS.checkmonstermenu()
		  end
		end
end)
--[ ROUBAR F ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------
-- /ME CHAT
-----------------------------------------------------------------------------------------------------------------------------------------------
local nbrDisplaying = 8

RegisterCommand('me', function(source, args, raw)
    local text = string.sub(raw, 4)
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    local offset = 1 + (nbrDisplaying*0.15)
    Display(GetPlayerFromServerId(source), text, offset)
end)

function Display(mePlayer, text, offset)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(8000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
local andarEstilos = { 
	{ ['command'] = "homem", ['anim'] = "move_m@confident"},
	{ ['command'] = "mulher", ['anim'] = "move_f@heels@c"},
	{ ['command'] = "depressivo", ['anim'] = "move_m@depressed@a"},
	{ ['command'] = "depressiva", ['anim'] = "move_f@depressed@a"},
	{ ['command'] = "empresario", ['anim'] = "move_m@business@a"},
	{ ['command'] = "determinado", ['anim'] = "move_m@brave@a"},
	{ ['command'] = "descontraido", ['anim'] = "move_m@casual@a"},
	{ ['command'] = "farto", ['anim'] = "move_m@fat@a"},
	{ ['command'] = "estiloso", ['anim'] = "move_m@hipster@a"},
	{ ['command'] = "ferido", ['anim'] = "move_m@injured"},
	{ ['command'] = "nervoso", ['anim'] = "move_m@hurry@a"},
	{ ['command'] = "desleixado", ['anim'] = "move_m@hobo@a"},
	{ ['command'] = "infeliz", ['anim'] = "move_m@sad@a"},
	{ ['command'] = "musculoso", ['anim'] = "move_m@muscle@a"},
	{ ['command'] = "desligado", ['anim'] = "move_m@shadyped@a"},
	{ ['command'] = "fadiga", ['anim'] = "move_m@buzzed"},
	{ ['command'] = "apressado", ['anim'] = "move_m@hurry_butch@a"},
	{ ['command'] = "descolado", ['anim'] = "move_m@money"},
	{ ['command'] = "piriguete", ['anim'] = "move_f@maneater"},
	{ ['command'] = "petulante", ['anim'] = "move_f@sassy"},
	{ ['command'] = "arrogante", ['anim'] = "move_f@arrogant@a"},
	{ ['command'] = "bebado", ['anim'] = "move_m@drunk@slightlydrunk"},
	{ ['command'] = "bebado2", ['anim'] = "move_m@drunk@verydrunk"},
	{ ['command'] = "bebado3", ['anim'] = "move_m@drunk@moderatedrunk"},
	{ ['command'] = "irritado", ['anim'] = "move_m@fire"},
	{ ['command'] = "intimidado", ['anim'] = "move_m@intimidation@cop@unarmed"},
	{ ['command'] = "poderosa", ['anim'] = "move_f@handbag"},
	{ ['command'] = "chateado", ['anim'] = "move_f@injured"},
	{ ['command'] = "estilosa", ['anim'] = "move_f@posh@"},
	{ ['command'] = "sensual", ['anim'] = "move_f@sexy@a"}
}

RegisterCommand("a",function(source,args)
	for k,v in pairs(andarEstilos) do
		if args[1] == v.command then
			vRP.loadAnimSet(v.anim)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FACIAL
-----------------------------------------------------------------------------------------------------------------------------------------
local facilEstilos = { 
	{ ['command'] = "passaro", ['facial'] = "mood_angry_1"},
	{ ['command'] = "drunk", ['facial'] = "mood_drunk_1"},
	{ ['command'] = "injuriado", ['facial'] = "pose_injured_1"},
	{ ['command'] = "xxx", ['facial'] = "electrocuted_1"},
	{ ['command'] = "xxx", ['facial'] = "effort_1"},
	{ ['command'] = "xxx", ['facial'] = "mood_drivefast_1"},
	{ ['command'] = "xxx", ['facial'] = "pose_angry_1"},
	{ ['command'] = "xxx", ['facial'] = "mood_happy_1"},
	{ ['command'] = "xxx", ['facial'] = "mood_injured_1"},
	{ ['command'] = "xxx", ['facial'] = "mood_dancing_low_1"},
	{ ['command'] = "xxx", ['facial'] = "smoking_hold_1"},
	{ ['command'] = "xxx", ['facial'] = "pose_normal_1"},
	{ ['command'] = "xxx", ['facial'] = "pose_aiming_1"},
	{ ['command'] = "xxx", ['facial'] = "shocked_1"},
	{ ['command'] = "xxx", ['facial'] = "shocked_2"},
	{ ['command'] = "xxx", ['facial'] = "mood_sleeping_1"},
	{ ['command'] = "xxx", ['facial'] = "dead_1"},
	{ ['command'] = "xxx", ['facial'] = "dead_2"},
	{ ['command'] = "xxx", ['facial'] = "mood_smug_1"},
	{ ['command'] = "xxx", ['facial'] = "mood_aiming_1"},
	{ ['command'] = "xxx", ['facial'] = "mood_stressed_1"},
	{ ['command'] = "xxx", ['facial'] = "mood_sulk_1"},
	{ ['command'] = "xxx", ['facial'] = "effort_2"},
	{ ['command'] = "xxx", ['facial'] = "effort_3"},
}

RegisterCommand("f",function(source,args)
	local ped = PlayerPedId()
	for k,v in pairs(facilEstilos) do
		if args[1] == v.command then
			SetFacialIdleAnimOverride(ped, v.facial, 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chapeu",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 100 then
		if not args[1] then
			vRP._playAnim(true,{{"veh@common@fp_helmet@","take_off_helmet_stand"}},false)
			Wait(700)
			ClearPedProp(ped,0)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet"}},false)
			Wait(1700)
			SetPedPropIndex(ped,0,parseInt(args[1]),parseInt(args[2]),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet"}},false)
			Wait(1700)
			SetPedPropIndex(ped,0,parseInt(args[1]),parseInt(args[2]),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("oculos",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 100 then
		if not args[1] then
			vRP._playAnim(true,{{"misscommon@std_take_off_masks","take_off_mask_ps"}},false)
			Wait(400)
			ClearPedTasks(ped)
			ClearPedProp(ped,1)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(args[1]),parseInt(args[2]),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(args[1]),parseInt(args[2]),2)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mascara",function(source,args)
	if vRPplayerS.maskItem() then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 then
			if args[1] == nil then
				vRP._playAnim(true,{{"misscommon@std_take_off_masks","take_off_mask_ps"}},false)
				Wait(700)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,1,0,0,2)
				return
			end
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
				Wait(1500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,1,parseInt(args[1]),parseInt(args[2]),2)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5*1000)
		if not vRPplayerS.maskItem()  then
			local ped = PlayerPedId()
			SetPedComponentVariation(ped,1,0,0,2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTA-MALAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pmalas",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("portas",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
	end
end)

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if IsControlJustPressed(0,11) then
			if IsEntityPlayingAnim(ped,"random@arrests","generic_radio_enter",3) then
				vRP.DeletarObjeto()
			else
				vRP.CarregarAnim("random@arrests")
				TaskPlayAnim(ped,"random@arrests","generic_radio_enter",3.0,3.0,-1,50,5.0,0,0,0)
				vRPplayerS.policeQTH(source)
			end
		end
	end
end)

RegisterCommand('qth', function(source, args)
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"random@arrests","generic_radio_enter",3) then
		vRP.DeletarObjeto()
	else
		vRP.CarregarAnim("random@arrests")
		TaskPlayAnim(ped,"random@arrests","generic_radio_enter",3.0,3.0,-1,50,5.0,0,0,0)
		vRPplayerS.policeQTH(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("capo",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
local menu = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CSS
-----------------------------------------------------------------------------------------------------------------------------------------
local css = [[
	.div_tuning {
		background-color: rgba(0,0,0,0.60);
		color: #fff;
		position: absolute;
		border-right: 3px solid #B262C0;
		bottom: 30%;
		right: 1.7%;
		padding: 7px 14px 7px 14px;
		font-family: arial;
        font-size: 13px;
		line-height: 18px;
		animation-name: fadeInOpacity;
		animation-iteration-count: 1;
		animation-timing-function: ease-in;
		animation-duration: 1s;
	}
	.div_tuning b {
		color: #9900cc;
	}
	@keyframes fadeInOpacity {
		0% {
			opacity: 0;
		}
		50% {
			opacity 0.5;
		}
		100% {
			opacity: 1;
		}
	}
]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- Comandos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vtuning",function(source)
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped, false)
		if veh ~= 0 then
			menu = not menu
			if menu then			
				-- Get engine level 
				local engine = GetVehicleMod(veh, 11)
				local engine = verify(engine)
				-- GET Engine 
				local engineLife = GetVehicleEngineHealth(veh)
				-- Get Body
				local bodyLife = GetVehicleBodyHealth(veh)
				-- Get brakes level
				local brakes = GetVehicleMod(veh, 12)
				local brakes = verify(brakes)
				-- Get transmission level
				local transmission = GetVehicleMod(veh, 13)
				local transmission = verify(transmission)
				-- Get suspention level
				local suspention = GetVehicleMod(veh, 15)
				local suspention = verify(suspention)
				-- Get armour level
				local armour = GetVehicleMod(veh, 16)
				if armour == -1 then
					armour = "Desativado"
				elseif armour == 0 then
					armour = "20%"
				elseif armour == 1 then
					armour = "40%"
				elseif armour == 2 then
					armour = "60%"
				elseif armour == 3 then
					armour = "80%"
				elseif armour == 4 then
					armour = "100%"
				end	
				-- Get turbo
				local turbo = IsToggleModOn(veh, 18)
				if turbo == false then
					turbo = "Sem Turbo"
				elseif turbo == 1 then
					turbo = "Turbo Instalado"
				end	

				vRP.setDiv("tuning", css, "<b>Lataria: </b>"..bodyLife.."%</br><b>Motor: </b>"..engineLife.."% | "..engine.."</br><b>Motor: </b>"..engine.."</br><b>Freios: </b>"..brakes.."</br><b>Transmissão: </b>"..transmission.."</br><b>Suspensão: </b>"..suspention.."</br><b>Blindagem: </b>"..armour.."<br><b>Turbo: </b>"..turbo)
			else
				vRP.removeDiv("tuning")
			end
		elseif menu then
			menu = not menu
			vRP.removeDiv("tuning")
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Funções
-----------------------------------------------------------------------------------------------------------------------------------------
function verify(index)
	if index == -1 then
		index = "Desativado"
	elseif index == 0 then
		index = "Level 1"
	elseif index == 1 then
		index = "Level 2"
	elseif index == 2 then
		index = "Level 3"
	elseif index == 3 then
		index = "Level 4"
	else
		return "Not found"
	end
	return index
end

function Texto3D(x,y,z, text, Opacidade)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    if onScreen then
        SetTextScale(0.5, 0.5)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, Opacidade)
        SetTextDropshadow(0, 0, 0, 0, Opacidade)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
------------------------------------------------------------------------------------------------------------------
-- ORTO ----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('NZK:ORTO')
AddEventHandler('NZK:ORTO', function(dados,tipo,cor,sexo,prop)
	local ped = PlayerPedId()
	print(dados,tipo,cor,sexo,prop)
    if(GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) and sexo == 1 then
		SetPedComponentVariation(ped, dados,tipo,cor ,1)

		if prop == 1 then
			SetPedPropIndex(ped,dados-100,tipo,cor,1)
		end

    elseif (GetEntityModel(ped) == GetHashKey("mp_f_freemode_01")) and sexo == 2 then
		SetPedComponentVariation(ped, dados,tipo,cor,1)
		
		if prop == 1 then
			SetPedPropIndex(ped,dados-100,tipo,cor,1)
		end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("identidade",function(source,args)
	if checkDistance() then	
		TriggerServerEvent("NZK:changename",args[1],args[2],args[3])
	else
		TriggerEvent('chatMessage',"RADAR",{255,70,50},"Vá até a prefeitura para mudar seu nome")
	end
end)

function checkDistance()
	local ped = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(x,y,z)
	local distance = GetDistanceBetweenCoords(x,y,cdz,-463.93145751953,1168.1606445313,328.97702026367,true)
	if distance < 5 then
		return true
	else
		return false
	end		
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if checkDistance() then
			DrawMarker(23,-463.93145751953,1168.1606445313,328.97702026367-0.99,1,1,0,0,0,0,1.0,1.0,1.0,255,255,255,50,0,1,0,0)
			DrawText3D(-463.93145751953,1168.1606445313,328.97702026367, "Mudar Nome", 2.0, 7, 100)
			DrawText3D(-463.93145751953,1168.1606445313,328.97702026367-0.4, "/identidade [nome] [sobrenome] [idade]", 2.0, 1, 100)
		end	 
	end
end)

function DrawText3D(x,y,z, text, scl, font, opacity) 
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
	local scale = (1/dist)*scl
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
   
	if onScreen then
		SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, opacity)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
	end
end
----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
    cancelando = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if cancelando then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,29,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,137,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,169,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,104,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
local agachado_time = 0
Citizen.CreateThread(function()
    while true do
        kswait = 4
        local ped = PlayerPedId()
        DisableControlAction(0,36,true)
        if not IsPedInAnyVehicle(ped) then
            kswait = 0
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0,36) then
                if agachado_time == 0 then
                    if agachar then
                        ResetPedStrafeClipset(ped)
                        ResetPedMovementClipset(ped,0.25)
                        agachado_time = 3
                        agachar = false
                    else
                        SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                        SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                        agachado_time = 3
                        agachar = true
                    end
                end
            end
        end
        Citizen.Wait(kswait)
    end
end)

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(1)
        -- desabilita o bug do R + F6 pra cancelar a animação de reload
        local ped = PlayerPedId()
        if not IsPedWeaponReadyToShoot(ped) then
            DisableControlAction(0,167,true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if agachado_time > 0 then
            agachado_time = agachado_time - 1
        end
        Citizen.Wait(1000)
    end
end)

----
-- HS
----
Citizen.CreateThread(function()
    while true do
        Wait(4)

        SetPedSuffersCriticalHits(PlayerPedId(-1), true)
    end
end)