local Tools = module("lib/Tools")
local cfg = module("cfg/gui")

local menu_ids = Tools.newIDGenerator()
local client_menus = {}
local rclient_menus = {}

function vRP.openMenu(source,menudef)
	local menudata = {}
	menudata.choices = {}

	for k,v in pairs(menudef) do
		if k ~= "name" and k ~= "onclose" and k ~= "css" then
			table.insert(menudata.choices,{k,v[2]})
		end
	end

	table.sort(menudata.choices, function(a,b)
		return string.upper(a[1]) < string.upper(b[1])
	end)

	menudata.name = menudef.name or "Menu"
	menudata.css = menudef.css or {}
	menudata.id = menu_ids:gen() 

	client_menus[menudata.id] = { def = menudef, source = source }
	rclient_menus[source] = menudata.id

	vRPclient._closeMenu(source)
	vRPclient._openMenuData(source,menudata)
end

function vRP.closeMenu(source)
	vRPclient._closeMenu(source)
end

local prompts = {}
function vRP.prompt(source,title,default_text)
	local r = async()
	prompts[source] = r
	vRPclient._prompt(source,title,default_text)
	return r:wait()
end

local request_ids = Tools.newIDGenerator()
local requests = {}

function vRP.request(source,text,time)
	local r = async()
	local id = request_ids:gen()
	local request = { source = source, cb_ok = r, done = false }
	requests[id] = request

	vRPclient.request(source,id,text,time)

	SetTimeout(time*1000,function()
		if not request.done then
			request.cb_ok(false)
			request_ids:free(id)
			requests[id] = nil
		end
	end)
	return r:wait()
end

local menu_builders = {}
function vRP.registerMenuBuilder(name,builder)
	local mbuilders = menu_builders[name]
	if not mbuilders then
		mbuilders = {}
		menu_builders[name] = mbuilders
	end
	table.insert(mbuilders,builder)
end

function vRP.buildMenu(name,data)
	local r = async()
	local choices = {}
	local mbuilders = menu_builders[name]
	if mbuilders then
		local count = #mbuilders
		for k,v in pairs(mbuilders) do
			local done = false
			local function add_choices(bchoices)
				if not done then
					done = true

					if bchoices then
						for k,v in pairs(bchoices) do
							choices[k] = v
						end
					end

					count = count-1
					if count == 0 then
						r(choices)
					end
				end
			end
			v(add_choices,data)
		end
		return r:wait()
	end

	return {}
end

function vRP.openMainMenu(source)
	local menudata = vRP.buildMenu("main",{ player = source })
	menudata.name = "Telefone"
	vRP.openMenu(source,menudata)
end

function tvRP.closeMenu(id)
	local source = source
	local menu = client_menus[id]
	if menu and menu.source == source then
		if menu.def.onclose then
			menu.def.onclose(source)
		end
		menu_ids:free(id)
		client_menus[id] = nil
		rclient_menus[source] = nil
	end
end

function tvRP.validMenuChoice(id,choice,mod)
	local source = source
	local menu = client_menus[id]
	if menu and menu.source == source then
		local ch = menu.def[choice]
		if ch then
			local cb = ch[1]
			if cb then
				cb(source,choice,mod)
			end
		end
	end
end

function tvRP.promptResult(text)
	if text == nil then
		text = ""
	end

	local prompt = prompts[source]
	if prompt ~= nil then
		prompts[source] = nil
		prompt(text)
	end
end

function tvRP.requestResult(id,ok)
	local request = requests[id]
	if request and request.source == source then
		request.done = true
		request.cb_ok(not not ok)
		request_ids:free(id)
		requests[id] = nil
	end
end

function tvRP.openMainMenu()
	vRP.openMainMenu(source)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENUS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local static_menu_choices = {}

function vRP.addStaticMenuChoices(name, choices)
  local mchoices = static_menu_choices[name]
  if mchoices == nil then
    static_menu_choices[name] = {}
    mchoices = static_menu_choices[name]
  end

  for k,v in pairs(choices) do
    mchoices[k] = v
  end
end

local static_menus = {}
SetTimeout(30000,function()
  for k,v in pairs(cfg.static_menu_types) do
    local menu = {name=v.title, css={top="75px"}}
    local choices = static_menu_choices[k] or {}

    for l,w in pairs(choices) do
      menu[l] = w
    end

    static_menus[k] = menu
  end
end)

local function build_client_static_menus(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k,v in pairs(cfg.static_menus) do
      local mtype,x,y,z = table.unpack(v)
      local menu = static_menus[mtype]
      local smenu = cfg.static_menu_types[mtype]

      if menu and smenu then
        local function smenu_enter()
          local user_id = vRP.getUserId(source)
          if user_id ~= nil and vRP.hasPermissions(user_id,smenu.permissions or {}) then
            vRP.openMenu(source,menu) 
          end
        end

        local function smenu_leave()
          vRP.closeMenu(source)
        end
		vRPclient._addMarker(source,23,x,y,z-0.95,1,1,0.5,0,95,140,50,100)
		vRP.setArea(source,"vRP:open_menu:"..k,x,y,z,1.5,1.5,smenu_enter,smenu_leave)
      end
    end
  end
end  

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    build_client_static_menus(source)
  end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	local id = rclient_menus[source]
	if id then
		local menu = client_menus[id]
		if menu and menu.source == source then
			if menu.def.onclose then
				menu.def.onclose(source)
			end

			menu_ids:free(id)
			client_menus[id] = nil
			rclient_menus[source] = nil
		end
	end
end)

RegisterServerEvent("AC:ac_Armas:ACC49129120")
AddEventHandler("AC:ac_Armas:ACC49129120",function()
	local source = source
  local user_id = vRP.getUserId(source)
	if user_id ~= nil then
    vRP.log("nzk_logs/anticheat/spawnArmas.txt","O [ID:"..user_id.."] Esta Suspeito.")
	end
end)