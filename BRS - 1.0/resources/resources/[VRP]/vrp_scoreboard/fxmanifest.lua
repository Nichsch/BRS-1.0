fx_version 'bodacious'
game 'gta5'

description 'vRP Scoreboard'

version '1.0.0'

dependency "vrp"

client_script 'client/main.lua'

server_scripts {
    "@vrp/lib/utils.lua",
	"server/main.lua"
}

ui_page 'html/scoreboard.html'

files {
	'html/scoreboard.html',
	'html/style.css',
	'html/listener.js'
}