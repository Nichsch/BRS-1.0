local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local idVisable = true

Citizen.CreateThread(function()

	Citizen.Wait(2000)
	RegisterNetEvent('vrp_scoreboard:getConnectedPlayers')
	AddEventHandler('vrp_scoreboard:getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)



Citizen.CreateThread(function()
	Citizen.Wait(500)
	SendNUIMessage({
		action = 'updateServerInfo',

		maxPlayers = GetConvarInt('sv_maxclients', 128),
		uptime = '00h 00m',
		playTime = '00h 00m'
	})
end)

RegisterNetEvent('vrp_scoreboard:updateConnectedPlayers')
AddEventHandler('vrp_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent('vrp_scoreboard:updatePing')
AddEventHandler('vrp_scoreboard:updatePing', function(connectedPlayers)
	SendNUIMessage({
		action  = 'updatePing',
		players = connectedPlayers
	})
end)

RegisterNetEvent('vrp_scoreboard:toggleID')
AddEventHandler('vrp_scoreboard:toggleID', function(state)
	if state then
		idVisable = state
	else
		idVisable = not idVisable
	end

	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
end)

RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	SendNUIMessage({
		action = 'updateServerInfo',
		uptime = uptime
	})
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local ems, emsEXP, police, policePTR, policiaCivil, policiaCivilPTR, mechanic, mechanicPTR, cet, judiciario, cardealer, estate, players = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 

	for k,v in pairs(connectedPlayers) do

		if num == 1 then
			table.insert(formattedPlayerList, ('<tr><td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 2
		elseif num == 2 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 3
		elseif num == 3 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 4
		elseif num == 4 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td></tr>'):format(v.name, v.id, v.ping))
			num = 1
		end

		players = players + 1

		if (v.job == 'Diretor [HOSPITAL]' or v.job == 'SubDiretor [HOSPITAL]' or v.job == 'Gestão [HOSPITAL]' or v.job == 'Medico [HOSPITAL]' or v.job == 'Enfermeiro [HOSPITAL]' or v.job == 'Psicologo [UNIZK]' or v.job == 'Socorrista [HOSPITAL]') then
				ems = ems + 1
		elseif (v.job == 'Diretor [EXP]' or v.job == 'SubDiretor [EXP]' or v.job == 'Gestão [EXP]' or v.job == 'Medico [EXP]' or v.job == 'Enfermeiro [EXP]' or v.job == 'Psicologo [EXP]' or v.job == 'Socorrista [EXP]') then
				emsEXP = emsEXP + 1
		elseif (v.job == 'Piloto [POLICIA]' or v.job == 'Recruta [POLICIA]' or v.job == 'Soldado [POLICIA]' or v.job == 'Cabo [POLICIA]' or v.job == 'Major [POLICIA]' or v.job == 'Major' or v.job == 'Tenente Coronel [POLICIA]' or v.job == 'Coronel [POLICIA]' or v.job == 'Comandante [POLICIA]' ) then
				police = police + 1
		elseif (v.job == 'Comandante [PTR]' or v.job == 'Coronel [PTR]' or v.job == 'Tenente Coronel [PTR]' or v.job == 'Major [PTR]' or v.job == 'Capitão [PTR]' or v.job == 'Tenente [PTR]' or v.job == 'Sargento [PTR]' or v.job == 'Cabo [PTR]' or v.job == 'Soldado [PTR]' or v.job == 'Piloto [PTR]' or v.job == 'Recruta [PTR]' ) then
				policePTR = policePTR + 1
		elseif (v.job == 'Piloto [CIVIL]' or v.job == 'Escrivao [CIVIL]' or v.job == 'Agente [CIVIL]' or v.job == 'Operador [CIVIL]' or v.job == 'Investigador [CIVIL]' or v.job == 'Corregedor [CIVIL]' or v.job == 'Delegado [CIVIL]' or v.job == 'Comandante [CIVIL]') then
				policiaCivil = policiaCivil + 1 
		elseif (v.job == 'Comandante [CPTR]' or v.job == 'Delegado [CPTR]' or v.job == 'Corregedor [CPTR]' or v.job == 'Investigador [CPTR]' or v.job == 'Operador [CPTR]' or v.job == 'Agente [CPTR]' or v.job == 'Escrivão [CPTR]' or v.job == 'Piloto [CPTR]') then
				policiaCivilPTR = policiaCivilPTR + 1 
		elseif (v.job == 'Ministro' or v.job == 'Juiz'  or v.job == 'Promotor' or v.job == 'Advogados') then
				judiciario = judiciario + 1
		elseif (v.job == 'Diretor [CET]' or v.job == 'Superintendente [CET]'  or v.job == 'Guarda [CET]' or v.job == 'Guarda de Transito [CET]') then
				cet = cet + 1
		elseif (v.job == 'Membro [MECANICO]' or v.job == 'Lider [MECANICO]' or v.job == 'Lider [LS CUSTOM]' or v.job == 'Sub-Lider [LS CUSTOM]' or v.job == 'Sub-Lider [MECANICO]"' or v.job == 'Membro [LS CUSTOM]') then
				mechanic = mechanic + 1
		elseif (v.job == 'Membro [PMEC]' or v.job == 'Lider [PMEC]' or v.job == 'Sub [PMEC]' or v.job == 'Lider [LSEXP]' or v.job == 'Membro [LSEXP]') then
			mechanicPTR = mechanicPTR + 1
		end

	end

	if num == 1 then
		table.insert(formattedPlayerList, '</tr>')
	elseif num == 2 then
		table.insert(formattedPlayerList, '</tr>')
	elseif num == 3 then
		table.insert(formattedPlayerList, '</tr>')
	end

	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ems = ems, emsEXP = emsEXP, police = police, policePTR = policePTR, policiaCivil = policiaCivil, policiaCivilPTR = policiaCivilPTR, cet = cet, mechanic = mechanic, mechanicPTR = mechanicPTR, judiciario = judiciario, cardealer = cardealer, estate = estate, player_count = players}
	})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['~']) and IsInputDisabled(0) then
			ToggleScoreBoard()
			Citizen.Wait(200)

		-- D-pad up on controllers works, too!
		elseif IsControlJustReleased(0, 172) and not IsInputDisabled(0) then
			ToggleScoreBoard()
			Citizen.Wait(200)
		end
	end
end)

-- Close scoreboard when game is paused
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end

Citizen.CreateThread(function()
	local playMinute, playHour = 0, 0

	while true do
		Citizen.Wait(1000 * 60) -- every minute
		playMinute = playMinute + 1
	
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end

		SendNUIMessage({
			action = 'updateServerInfo',
			playTime = string.format("%02dh %02dm", playHour, playMinute)
		})
	end
end)
