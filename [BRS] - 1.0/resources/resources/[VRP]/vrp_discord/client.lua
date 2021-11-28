local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emD = Tunnel.getInterface("vrp_discord")
----------------------------------------------------------------------------------------------------
--[ DISCORD ]---------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        SetDiscordAppId(762462698822172693)

	    local players = emD.discord()
		
	    SetDiscordRichPresenceAsset('brs')
		SetDiscordRichPresenceAssetText('')
		SetRichPresence("discord.gg/brsrp")
	    SetRichPresence("Jogadores: "..players.."")
		Citizen.Wait(10000)
	end
end)