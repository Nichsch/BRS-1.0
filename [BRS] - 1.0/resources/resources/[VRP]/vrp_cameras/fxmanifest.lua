fx_version 'bodacious'
game 'gta5'

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/vue.min.js",
    "ui/script.js"
}

dependency "vrp"

client_scripts{ 
  '@vrp/lib/utils.lua',
  "config.lua",
  "client.lua"
}

server_scripts {
  '@vrp/lib/utils.lua',
  'server.lua'
}
