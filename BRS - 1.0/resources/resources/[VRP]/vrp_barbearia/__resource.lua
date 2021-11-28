resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page "ui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"ui/index.html",
	"ui/assets/arrow-left.png",
	"ui/assets/arrow-right.png",
	"ui/assets/radio-check.png",
	"ui/assets/radio-check-black.png",
	"ui/assets/head.png",
	"ui/assets/pilosite.png",
	"ui/assets/cursor.png",
	"ui/fonts/Circular-Bold.ttf",
	"ui/fonts/Circular-Book.ttf",
	"ui/front.js",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js"
}