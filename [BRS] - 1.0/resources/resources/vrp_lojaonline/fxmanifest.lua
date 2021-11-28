fx_version 'adamant'
game 'gta5'

author 'JesterIruka'
description 'Script da five-m.store'
version '1.0.0'

ui_page "nui/index.html"

files {
	"nui/index.html",
	"nui/index.css"
}

client_scripts {
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua", 
	"server.js"
}
