local cfg = module("cfg/inventory")


mochila = {}

function vRP.setMochila(user_id,tMochila)
    if not mochila[user_id] then mochila[user_id] = 0 end

    if vRP.getInventoryWeight(user_id) <= (vRP.getInventoryMaxWeight(user_id) - mochila[user_id] + tMochila) then
        mochila[user_id] = tMochila
        if tMochila == 0 then
            TriggerClientEvent('nzk:mochila',source)
        end
        return true
    else
        return false
    end

end

function vRP.getMochila(user_id)
    if user_id then
        return mochila[user_id]
    end
end
 
local itemlist = {
	["pacote_ilegal"] = { index = "pacote_ilegal", type = "none" },
	["garrafavazia"] = { index = "garrafavazia", type = "none" },
	["garrafadeleite"] = { index = "garrafaleite", type = "none" },
	["bank_money"] = { index = "dinheirobanco", type = "none" },
	["furadeira"] = { index = "furadeira", type = "none" },
	["solda"] = { index = "solda", type = "none" },
	["isca"] = { index = "isca", type = "none" },
	["dourado"] = { index = "dourado", type = "none" },
	["corvina"] = { index = "corvina", type = "none" },
	["salmao"] = { index = "salmao", type = "none" },
	["pacu"] = { index = "pacu", type = "none" },
	["pintado"] = { index = "pintado", type = "none" },
	["pirarucu"] = { index = "pirarucu", type = "none" },
	["tilapia"] = { index = "tilapia", type = "none" },
	["tucunare"] = { index = "tucunare", type = "none" },
	["lambari"] = { index = "lambari", type = "none" },
	["nitro"] = { index = "nitro", type = "none" },
	["alianca"] = { index = "alianca", type = "none" },
	["certificado"] = { index = "certificado", type = "none" },
	["documento"] = { index = "documento", type = "none" },
	["escudo"] = { index = "escudo", type = "none" },
	["medal1"] = { index = "medal1", type = "none" },
	["medal2"] = { index = "medal2", type = "none" },
	["medal3"] = { index = "medal3", type = "none" },
	["medkit"] = { index = "medkit", type = "none" },
	["radio"] = { index = "radio", type = "none" },
	["repairkit"] = { index = "repairkit", type = "usar" },
	["cartaovirgem"] = { index = "cartaovirgem", type = "none" },
	["cartaoclonado"] = { index = "cartaoclonado", type = "none" },
	["tartaruga"] = { index = "tartaruga", type = "none" },
	["carnetartaruga"] = { index = "carnetartaruga", type = "none" },
	["rocha"] = { index = "rocha", type = "none" },
	["ouro"] = { index = "ouro", type = "none" },
	["ferro"] = { index = "ferro", type = "none" },
	["bronze"] = { index = "bronze", type = "none" },
	["diamantelap"] = { index = "diamantelap", type = "none" },
	["mandado_b_a"] = { index = "mandados", type = "none" },
	["mandado_prisao"] = { index = "mandados", type = "none" },
	["mandado_intimacao"] = { index = "mandados", type = "none" },
	["processosjudiciais"] = { index = "pasta", type = "none" },
	["pack_parts"] = { index = "componentes", type = "none" },
	["pistol_parts"] = { index = "componentes", type = "none" },
	["shotgun_parts"] = { index = "componentes", type = "none" },
	["mtar_parts"] = { index = "componentes", type = "none" },
	["adv_parts"] = { index = "componentes", type = "none" },
	["sns_parts"] = { index = "componentes", type = "none" },
	["ak47_parts"] = { index = "componentes", type = "none" },
	["body_parts"] = { index = "componentes", type = "none" },
	["dirty_money"] = { index = "dirty_money", type = "none" },
	["madeira"] = { index = "madeira", type = "none" },
	["tora"] = { index = "tora", type = "none" },
	["nitro"] = { index = "nitro", type = "none" },
	["rgfalso"] = { index = "rgfalso", type = "none" },
	["cadaver"] = { index = "cadaver", type = "none" },
	["orgaos"] = { index = "orgaos", type = "none" },
	["mascara"] = { index = "mascara", type = "none" },
	["roupas"] = { index = "roupas", type = "none" },
	["chapeu"] = { index = "chapeu", type = "none" },
	["sapatos"] = { index = "sapatos", type = "none" },
	["oculos"] = { index = "oculos", type = "none" },
	["celular"] = { index = "celular", type = "none" },
	["carnetartaruga"] = { index = "carnetartaruga", type = "none" },
	["tartaruga"] = { index = "tartaruga", type = "none" },
	["barra"] = { index = "barra", type = "none" },
	["brincos"] = { index = "brincos", type = "none" },
	["colar"] = { index = "colar", type = "none" },
	["relogio"] = { index = "relogio", type = "none" },
	["joia"] = { index = "joia", type = "none" },
	["ticket_race"] = { index = "ticket_race", type = "none" },
	["dirty_money"] = { index = "dirty_money", type = "none" },
	["oab_identidade"] = { index = "oab", type = "none" },
	["seeds"] = { index = "seedmaconha", type = "none" },
	["benzoilmetilecgonina"] = { index = "seedcocaina", type = "none" },
	["anfetamina"] = { index = "seedmetafetamina", type = "none" },
	["parafuso"] = { index = "parafuso", type = "none" },
	["metal"] = { index = "metal", type = "none" },
	["bateria"] = { index = "bateria", type = "none" },
	["cabo"] = { index = "cabo", type = "none" },
-- USAR
	["lockpick"] = { index = "lockpick", type = "usar" },
	["esmeralda"] = { index = "esmeralda", type = "usar" },
	["weed"] = { index = "weed", type = "usar" },
	["cocaine"] = { index = "cocaine", type = "usar" },
	["md"] = { index = "md", type = "usar" },
	["mochila1"] = { index = "mochila1", type = "usar" },
	["mochila2"] = { index = "mochila2", type = "usar" },
	["mochila3"] = { index = "mochila3", type = "usar" },
	["metanfetamina"] = { index = "mentafetamina", type = "usar" },
	["night_vison"] = { index = "nightvision", type = "usar" },
	["vendaolhos"] = { index = "vendaolhos", type = "usar" },
	["algemas"] = { index = "algemas", type = "usar" },
	["chave_algemas"] = { index = "chave_algemas", type = "usar" },
	["scubagear"] = { index = "scubagear", type = "usar" },
	["body_armor"] = { index = "colete", type = "usar"},
-- REMEDIOS
	["dipiroca"] = { index = "pills", type = "remedio", vida = 50 },
	["nocucedin"] = { index = "pills", type = "remedio", vida = 40 },
	["paracetanal"] = { index = "pills", type = "remedio", vida = 50 },
	["decupramim"] = { index = "pills", type = "remedio", vida = 15 },
	["buscopau"] = { index = "pills", type = "remedio", vida = 20 },
	["navagina"] = { index = "pills", type = "remedio", vida = 50 },
	["analdor"] = { index = "pills", type = "remedio", vida = 35 },
	["sefodex"] = { index = "pills", type = "remedio", vida = 15 },
	["phodac"] = { index = "pills", type = "remedio", vida = 25 },
	["danec"] = { index = "pills", type = "remedio", vida = 45 },
	["cotovelol"] = { index = "pills", type = "remedio", vida = 10 },
	["nokusin"] = { index = "pills", type = "remedio", vida = 50 },
	["viagral"] = { index = "pills", type = "remedio", vida = 10 },
	["glicoanal"] = { index = "pills", type = "remedio", vida = 30 },
	["quigosado"] = { index = "pills", type = "remedio", vida = 50 },
-- COMER
	["bread"] = { index = "bread", type = "comer", fome = -5 },
	["donut"] = { index = "donut", type = "comer", fome = -8 },
	["tacos"] = { index = "taco", type = "comer", fome = -12 },
	["sandwich"] = { index = "burger", type = "comer", fome = -15 },
	["kebab"] = { index = "kebab", type = "comer", fome = -10 },
	["pdonut"] = { index = "pdonut", type = "comer", fome = -10 },
	["catfish"] = { index = "fish", type = "comer", fome = -12 },
	["lasanha"] = { index = "lasagna", type = "comer", fome = -30 },
	["vitamina"] = { index = "vitamina", type = "comer", fome = -15 },
-- BEBER
	["water"] = { index = "water", type = "beber", sede = -20 },
	["milk"] = { index = "milk", type = "beber", sede = -10 },
	["coffee"] = { index = "coffee", type = "beber", sede = -5 },
	["tea"] = { index = "coffee-cup", type = "beber", sede = -5 },
	["icetea"] = { index = "icetea", type = "beber", sede = -15 },
	["orangejuice"] = { index = "orange-juice", type = "beber", sede = -25 },
	["gocagola"] = { index = "soft-drink", type = "beber", sede = -15 },
	["redgull"] = { index = "energy-drink", type = "beber", sede = -10 },
	["lemonlimonad"] = { index = "juice", type = "beber", sede = -25 },
	["vodka"] = { index = "vodka", type = "beber" },
-- ARMAS
	["wbody|WEAPON_SMG"] = { index = "mp5", type = "equipar" },
	["wammo|WEAPON_SMG"] = { index = "m-mp5", type = "recarregar" },
	["wbody|WEAPON_SPECIALCARBINE"] = { index = "specialcarbine", type = "equipar" },
	["wammo|WEAPON_SPECIALCARBINE"] = { index = "m-musket", type = "recarregar" },
	["wbody|WEAPON_DAGGER"] = { index = "dagger", type = "equipar" },
	["wammo|WEAPON_DAGGER"] = { index = "m-dagger", type = "recarregar" },
	["wbody|WEAPON_BAT"] = { index = "bat", type = "equipar" },
	["wammo|WEAPON_BAT"] = { index = "m-bat", type = "recarregar" },
	["wbody|WEAPON_BOTTLE"] = { index = "bottle", type = "equipar" },
	["wammo|WEAPON_BOTTLE"] = { index = "m-bottle", type = "recarregar" },
	["wbody|WEAPON_CROWBAR"] = { index = "crowbar", type = "equipar" },
	["wammo|WEAPON_CROWBAR"] = { index = "m-crowbar", type = "recarregar" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "flashlight", type = "equipar" },
	["wammo|WEAPON_FLASHLIGHT"] = { index = "m-flashlight", type = "recarregar" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golfclub", type = "equipar" },
	["wammo|WEAPON_GOLFCLUB"] = { index = "m-golfclub", type = "recarregar" },
	["wbody|WEAPON_HAMMER"] = { index = "hammer", type = "equipar" },
	["wammo|WEAPON_HAMMER"] = { index = "m-hammer", type = "recarregar" },
	["wbody|WEAPON_HATCHET"] = { index = "hatchet", type = "equipar" },
	["wammo|WEAPON_HATCHET"] = { index = "m-hatchet", type = "recarregar" },
	["wbody|WEAPON_KNUCKLE"] = { index = "knuckle", type = "equipar" },
	["wammo|WEAPON_KNUCKLE"] = { index = "m-knuckle", type = "recarregar" },
	["wbody|WEAPON_KNIFE"] = { index = "knife", type = "equipar" },
	["wammo|WEAPON_KNIFE"] = { index = "m-knife", type = "recarregar" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", type = "equipar" },
	["wammo|WEAPON_MACHETE"] = { index = "m-machete", type = "recarregar" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "switchblade", type = "equipar" },
	["wammo|WEAPON_SWITCHBLADE"] = { index = "m-switchblade", type = "recarregar" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "nightstick", type = "equipar" },
	["wammo|WEAPON_NIGHTSTICK"] = { index = "m-nightstick", type = "recarregar" },
	["wbody|WEAPON_WRENCH"] = { index = "wrench", type = "equipar" },
	["wammo|WEAPON_WRENCH"] = { index = "m-wrench", type = "recarregar" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "battleaxe", type = "equipar" },
	["wammo|WEAPON_BATTLEAXE"] = { index = "m-battleaxe", type = "recarregar" },
	["wbody|WEAPON_POOLCUE"] = { index = "poolcue", type = "equipar" },
	["wammo|WEAPON_POOLCUE"] = { index = "m-poolcue", type = "recarregar" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "hatchet", type = "equipar" },
	["wammo|WEAPON_STONE_HATCHET"] = { index = "m-hatchet", type = "recarregar" },
	["wbody|WEAPON_PISTOL"] = { index = "pistol", type = "equipar" },
	["wammo|WEAPON_PISTOL"] = { index = "m-pistol", type = "recarregar" },
	["wbody|WEAPON_APPISTOL"] = { index = "appistol", type = "equipar" },
	["wammo|WEAPON_APPISTOL"] = { index = "m-appistol", type = "recarregar" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "pistolmk2", type = "equipar" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-pistolmk2", type = "recarregar" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "combatpistol", type = "equipar" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-combatpistol", type = "recarregar" },
	["wbody|WEAPON_STUNGUN"] = { index = "stungun", type = "equipar" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-stungun", type = "recarregar" },
	["wbody|WEAPON_SNSPISTOL_MK2"] = { index = "hk310m", type = "equipar" },
	["wammo|WEAPON_SNSPISTOL_MK2"] = { index = "m-heavy", type = "recarregar" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "vintage", type = "equipar" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-vintage", type = "recarregar" },
	["wbody|WEAPON_REVOLVER"] = { index = "revolver", type = "equipar" },
	["wammo|WEAPON_REVOLVER"] = { index = "m-revolver", type = "recarregar" },
	["wbody|WEAPON_MUSKET"] = { index = "musket", type = "equipar" },
	["wammo|WEAPON_MUSKET"] = { index = "m-musket", type = "recarregar" },
	["wbody|WEAPON_FLARE"] = { index = "flare", type = "equipar" },
	["wammo|WEAPON_FLARE"] = { index = "m-flare", type = "recarregar" },
	["wbody|GADGET_PARACHUTE"] = { index = "parachute", type = "equipar" },
	["wammo|GADGET_PARACHUTE"] = { index = "m-parachute", type = "recarregar" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "fire", type = "equipar" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-fire", type = "recarregar" },
	["wbody|WEAPON_MICROSMG"] = { index = "microsmg", type = "equipar" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-vintage", type = "recarregar" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "M-TAR", type = "equipar" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-vintage", type = "recarregar" },
	["wbody|WEAPON_RAYPISTOL"] = { index = "raypistol", type = "equipar" },
	["wammo|WEAPON_RAYPISTOL"] = { index = "m-raypistol", type = "recarregar" },
	["wbody|WEAPON_COMBATPDW"] = { index = "combatpdw", type = "equipar" },
	["wbody|WEAPON_ADVANCEDRIFLE"] = { index = "advrifle", type = "equipar" },
	["wammo|WEAPON_ADVANCEDRIFLE"] = { index = "m-advrifle", type = "recarregar" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-combatpdw", type = "recarregar" },
	["wbody|WEAPON_HEAVYPISTOL"] = { index = "heavy", type = "equipar" },
	["wammo|WEAPON_HEAVYPISTOL"] = { index = "m-heavy", type = "recarregar" },
	["wbody|WEAPON_PUMPSHOTGUN"] = { index = "shotgun", type = "equipar" },
	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "pistol_ammo", type = "recarregar" },
	["wbody|WEAPON_PETROLCAN"] = { index = "petrolcan", type = "equipar" },
	["wammo|WEAPON_PETROLCAN"] = { index = "petrolcan", type = "recarregar" },

	["wbody|WEAPON_CARBINERIFLE"] = { index = "M4", type = "equipar" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-gunsenberg", type = "recarregar" },
	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "assaultrifle", type = "equipar" },
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-assaultrifle", type = "recarregar" },
	["wbody|WEAPON_GUSENBERG"] = { index = "gunsenberg", type = "equipar" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-gunsenberg", type = "recarregar" },
}

function vRP.itemIndexList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].index
	end
end

function vRP.itemTypeList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].type
	end
end

function vRP.itemBodyList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

function vRP.itemVida(item)
	if itemlist[item] ~= nil then
		return itemlist[item].vida
	end
end

function vRP.itemFome(item)
	if itemlist[item] ~= nil then
		return itemlist[item].fome
	end
end

function vRP.itemSede(item)
	if itemlist[item] ~= nil then
		return itemlist[item].sede
	end
end


vRP.items = {}
function vRP.defInventoryItem(idname,name,weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemName(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args)
	end
	return args[1]
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

function vRP.giveInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry then
			entry.amount = entry.amount + amount
		else
			data.inventory[idname] = { amount = amount }
		end
	end
end

function vRP.tryGetInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry and entry.amount >= amount then
			entry.amount = entry.amount - amount

			if entry.amount <= 0 then
				data.inventory[idname] = nil
			end
			return true
		end
	end
	return false
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	if not mochila[user_id] then mochila[user_id] = 0 end
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3+ mochila[user_id]
end

function vRP.clearInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		data.inventory = {}
	end
end

AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)

local chests = {}
local function build_itemlist_menu(name,items,cb)
	local menu = { name = name }
	local kitems = {}

	local choose = function(player,choice)
		local idname = kitems[choice]
		if idname then
			cb(idname)
		end
	end

	for k,v in pairs(items) do 
		local name,weight = vRP.getItemDefinition(k)
		if name then
			kitems[name] = k
			menu[name] = { choose,"<text01>Quantidade:</text01> <text02>"..v.amount.."</text02><br><br><text01>Peso:</text01> <text02>"..string.format("%.2f",weight).."kg</text02>" }
		end
	end

	return menu
end
 
function vRP.openChest2(source,name,max_weight,cb_close,cb_in,cb_out)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data.inventory then
			if not chests[name] then
				local close_count = 0
				local chest = { max_weight = max_weight }
				chests[name] = chest 
				local cdata = vRP.getSData(name)
				chest.items = json.decode(cdata) or {}

				local menu = { name = "Baú" }
				local cb_take = function(idname)
					local citem = chest.items[idname]
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					if amount > 0 and amount <= citem.amount then
						local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*amount
						if new_weight <= vRP.getInventoryMaxWeight(user_id) then
							vRP.giveInventoryItem(user_id,idname,amount)
							citem.amount = citem.amount - amount

							if citem.amount <= 0 then
								chest.items[idname] = nil
							end

							if cb_out then
								cb_out(idname,amount)
							end
							vRP.log("nzk_logs/player/chestBau.txt", "**RETIRAR** O [ID: "..user_id.."] retirar"..vRP.getItemName(idname).." "..amount.."x")

							if name == "faccao_bau:motoclube" then
								SendWebhookMessage(ac_webhook_motoclube_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:bahamas" then
								SendWebhookMessage(ac_webhook_bahamas_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:mc" then
								SendWebhookMessage(ac_webhook_mc_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:mafia" then
								SendWebhookMessage(ac_webhook_mafia_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:vermelhos" then
								SendWebhookMessage(ac_webhook_vermelhos_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:azuis" then
								SendWebhookMessage(ac_webhook_azuis_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:sr" then
								SendWebhookMessage(ac_webhook_sr_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:pc" then
								SendWebhookMessage(ac_webhook_pc_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:pm" then
								SendWebhookMessage(ac_webhook_pm_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:unizk" then
								SendWebhookMessage(ac_webhook_unizk_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:galaxy" then
								SendWebhookMessage(ac_webhook_galaxy_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:roxos" then
								SendWebhookMessage(ac_webhook_roxos_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:ml" then
							    SendWebhookMessage(ac_webhook_ml, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						    elseif name == "faccao_bau:diabo" then
								SendWebhookMessage(ac_webhook_diabo_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:coruja" then
							    SendWebhookMessage(ac_webhook_coruja_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
							elseif name == "faccao_bau:macaco" then
							    SendWebhookMessage(ac_webhook_macaco_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						    end

							TriggerClientEvent('chatMessage', source, "^5Você retirou "..vRP.getItemName(idname).." "..parseInt(amount).."x")
							
							vRP.closeMenu(source)
						else
							TriggerClientEvent('chatMessage', source, "^9Mochila cheia.")
						end
					else
						TriggerClientEvent('chatMessage', source, "^9Valor inválido.")
					end
				end

				local ch_take = function(player,choice)
					local weight = vRP.computeItemsWeight(chest.items)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",chest.items,cb_take)

					submenu.onclose = function()
						close_count = close_count - 1
						vRP.openMenu(player,menu)
					end
					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				local cb_put = function(idname)
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*amount
					if new_weight <= max_weight then
						if amount > 0 and vRP.tryGetInventoryItem(user_id,idname,amount) then
							local citem = chest.items[idname]
							if citem ~= nil then
								citem.amount = citem.amount + amount
							else
								chest.items[idname] = { amount = amount }
							end

							if cb_in then
								cb_in(idname,amount)
							end
							vRP.closeMenu(source)
						end
						vRP.log("nzk_logs/player/chestBau.txt", "**GUARDAR** O [ID: "..user_id.."] guardou "..vRP.getItemName(idname).." "..amount.."x")
						TriggerClientEvent('chatMessage', source, "^5Você guardou "..vRP.getItemName(idname).." "..parseInt(amount).."x")
						
						if name == "faccao_bau:motoclube" then
							SendWebhookMessage(ac_webhook_motoclube_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:bahamas" then
							SendWebhookMessage(ac_webhook_bahamas_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:mc" then
							SendWebhookMessage(ac_webhook_mc_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:mafia" then
							SendWebhookMessage(ac_webhook_mafia_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:vermelhos" then
							SendWebhookMessage(ac_webhook_vermelhos_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:azuis" then
							SendWebhookMessage(ac_webhook_azuis_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:sr" then
							SendWebhookMessage(ac_webhook_sr_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:pc" then
							SendWebhookMessage(ac_webhook_pc_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:pm" then
							SendWebhookMessage(ac_webhook_pm_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:unizk" then
							SendWebhookMessage(ac_webhook_unizk_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:galaxy" then
							SendWebhookMessage(ac_webhook_galaxy_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:roxos" then
							SendWebhookMessage(ac_webhook_roxos_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
					    elseif name == "faccao_bau:ml" then
						    SendWebhookMessage(ac_webhook_ml_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
					    elseif name == "faccao_bau:diabo" then
							SendWebhookMessage(ac_webhook_diabo_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:coruja" then
							SendWebhookMessage(ac_webhook_coruja_bau, "```css\n** Retirar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] retirou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
						elseif name == "faccao_bau:macaco" then
						    SendWebhookMessage(ac_webhook_macaco_bau, "```css\n** Guardar **\n"..os.date("[%d/%m/%Y as %X]").."\nO [ID: "..user_id.."] guardou ["..vRP.getItemName(idname).. "] " ..amount.."x```")
					    end
						
					else
						TriggerClientEvent('chatMessage', source, "^9Bau Cheio")
					end
				end

				local ch_put = function(player,choice)
					local weight = vRP.computeItemsWeight(data.inventory)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",data.inventory,cb_put)

					submenu.onclose = function()
						close_count = close_count-1
						vRP.openMenu(player,menu)
					end

					close_count = close_count+1
					vRP.openMenu(player,submenu)
				end

				menu["Retirar"] = { ch_take }
				menu["Colocar"] = { ch_put }

				menu.onclose = function()
					if close_count == 0 then
						vRP.setSData(name,json.encode(chest.items))
						chests[name] = nil
						if cb_close then
							cb_close()
						end
					end
				end
				vRP.openMenu(source,menu)
			else
				TriggerClientEvent('chatMessage', source, "^9Está sendo utilizado no momento.")
			end
		end
	end
end

local function build_client_static_chests(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(cfg.static_chests) do
			local mtype,x,y,z = table.unpack(v)
			local schest = cfg.static_chest_types[mtype]

			if schest then
				local function schest_enter(source)
					local user_id = vRP.getUserId(source)
					if user_id and vRP.hasPermissions(user_id,schest.permissions or {}) then
						vRP.openChest2(source,"faccao_bau:"..schest.id,schest.weight or 0)
					end
				end

				local function schest_leave(source)
					vRP.closeMenu(source)
				end

				vRP.setArea(source,"vRP:static_chest:"..schest.id,x,y,z,1,1,schest_enter,schest_leave)
			end
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_static_chests(source)
	end
end)

Citizen.CreateThread(function()

	ac_webhook_motoclube_bau = "https://discordapp.com/api/webhooks/690713623437508639/hlDTfqGsu5_jgqA94WUZ3BPl-i58fqQpMPaj6Sw1Ojddbp7RkUyP-ShBB8nY-n8GT7CT"
	ac_webhook_bahamas_bau = "https://discordapp.com/api/webhooks/750355807086051343/QQ799_-pjtcQ2J1i-ICF-oWuzeqqtAvUA4ob8ydB5ZslfOS3MmxbZcLZGKjufJZtA3PP"
	ac_webhook_mc_bau = "https://discordapp.com/api/webhooks/750719121276272651/GgwRDowMq9T6e5AslAN2r8n9thWqfX-e9fC8vZeO4CKuPikDvQJyxRPpSbKfjr0maDx8"
	ac_webhook_mafia_bau = "https://discordapp.com/api/webhooks/747854248838037606/oU8O6lTU1ptvGDjm6V0QgZ8qsEvIIWHLFKmTnXBElEFeycJQ15yUHUuVbNxw42JJSmTu"
	ac_webhook_vermelhos_bau = "https://discordapp.com/api/webhooks/744348644320346144/hPvYTXFm8bPCKgcN1xSAie_Ci23O_TjfNkzpOL5HuPoXD_sSJU2kSjhPgUJENbz6hNiL"
	ac_webhook_roxos_bau = "https://discordapp.com/api/webhooks/751818236391194726/Unw9zKKkQBjgtlX88KUK6Y4UCcFzEjkFlpP1xsxvUgmob1OaWC2JZsWWyRX224GHGyzx"
	ac_webhook_azuis_bau = "https://discordapp.com/api/webhooks/747223442356568065/lbsYgBty32v6vN5RcJHLDQvhvX_bJ-SPkxNHK-gRd73N_n4eRJXy_4BcJdrbQ--LHotP"
	ac_webhook_sr_bau = "https://discordapp.com/api/webhooks/747909747377831956/PDotQYWytuzuxP87WdAyRnGNKglOwrSIbhbL7en7TJMWtuOLgzchspVpV0TZD_W6e44N"
	ac_webhook_pc_bau = "https://discordapp.com/api/webhooks/697636106547494954/M3L0AAY736NXkwRRxKvWkbgx9VjHbHBXsdPOUL7j50PHyXuxAQVdrYJPhY9FlfV_SrzW"
	ac_webhook_pm_bau = "https://discordapp.com/api/webhooks/697636016441262091/tay2SUKzBShCvFqum-rWVHWFyjW5UMJwK3kp7j3hGr4zRcK_cID5hpXwbvr1pnJLkeRP"
	ac_webhook_unizk_bau = "https://discordapp.com/api/webhooks/692517463291723858/8fRV3sFU7R4NHTlcGa9Ftro58aMzEGUOUcxMNgKAeoFC2tQiKRsEhTEmOgOvK5NQ3BMR"
	ac_webhook_galaxy_bau = "https://discordapp.com/api/webhooks/760828518979862568/ccxhOnm8gHMa2NhsAYN59GXfqdjnxgGfcXwUPKN3_IcPQiUIerBP2nnKy14Ig6N22AAg"
	ac_webhook_ml_bau = "https://discordapp.com/api/webhooks/750719121276272651/GgwRDowMq9T6e5AslAN2r8n9thWqfX-e9fC8vZeO4CKuPikDvQJyxRPpSbKfjr0maDx8"
	ac_webhook_diabo_bau = "https://discordapp.com/api/webhooks/758293500449390612/tKLENipgDerBgIq7hKKwvNEtpIuYQjbEgULzaRKmqL00l2IvIRb23zWQMNwCf8p1uMG_"
	ac_webhook_macaco_bau = "https://discordapp.com/api/webhooks/760828314335576084/Xk_b78_YjHvuoExOQew-x3LnRev1Kl1amdOdVTtLHo8_vIpw-bbhLbBaU436AcvewWrb"
	ac_webhook_coruja_bau = "https://discordapp.com/api/webhooks/761226576749789235/gajK6rnAACMoYcpRIEtAOxdgZbPulq1SCwOcwxaeni_RZ8MHcyhWe2WtHZDNgYYlhEyJ"

	function SendWebhookMessage(webhook,message)
		if webhook ~= "none" then
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
end)