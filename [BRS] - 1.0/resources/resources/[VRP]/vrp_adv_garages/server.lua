local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPgarage = Tunnel.getInterface("vrp_adv_garages")
  
vRP._prepare("vRP/move_vehicle","UPDATE vrp_user_vehicles SET user_id = @tuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,ipva) VALUES(@user_id,@vehicle,7)") 
vRP._prepare("vRP/remove_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/get_vehicles","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/get_vehicle","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/get_detido","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/set_detido","UPDATE vrp_user_vehicles SET detido = @detido WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/set_ipva","UPDATE vrp_user_vehicles SET ipva = @ipva WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/get_maxcars","SELECT COUNT(vehicle) as quantidade FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/set_vehstatus","UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/count_vehicle","SELECT COUNT(*) as qtd FROM vrp_user_vehicles WHERE vehicle = @vehicle")

local cfg = module("vrp_adv_garages","cfg/garages")
local cfg_inventory = module("vrp","cfg/inventory")

local garage_types = cfg.garage_types
local maxCarsPerm = 5

local veh_models_ids = Tools.newIDGenerator()
local veh_models = {}

for group,vehicles in pairs(garage_types) do
	for veh_model,_ in pairs(vehicles) do
		if not veh_models[veh_model] then
			veh_models[veh_model] = veh_models_ids:gen()
		end
	end
end

local carros = {
	["18performante"] = { price = 1000000},
		["toyotasupra"] = { price = 1000000},
		["r1250"] = { price = 400000},
		["furia"] = { price = 1000000},
		["thrax"] = { price = 1000000},
		["coquette4"] = { price = 1000000},
		["cheetah"] = { price = 390000 },
		["sentinel0"] = { price = 390000 },
		["aqv"] = { price = 1000000},
		["bmws"] = { price = 1200000 }, 
		["x6m"] = { price = 1300000 },
		["ellie"] = { price = 450000 },
		["sabregt"] = { price = 400000 },
		["dm1200"] = { price = 800000 },
		["ram2500"] = { price = 1800000 },
		["veneno"] = { price = 8000000 },
		["divo"] = { price = 1000000 },
		["c8"] = { price = 1600000 },
		["shotaro"] = { price = 1000000},
		["nightblade"] = { price = 380000 },
		["brickade"] = { price = 1000000 },
		["boss302"] = { price = 350000 },
		["tritonhpe"] = { price = 1200000 },
		["nissantitan17"] = { price = 1000000 },
		["hexer"] = { price = 240000 },
		["fct"] = { price = 1000000 },
		["pturismo"] = { price = 1000000 },
		["nh2r"] = { price = 1000000 },
		["370z"] = { price = 1000000 },
		["daemon"] = { price = 190000 },
		["trophytruck"] = { price = 300000 },
		["elegy"] = { price = 200000 },
		["cayenne"] = { price = 1000000},
		["vamos"] = { price = 180000 },
		["guardian"] = { price = 400000 },
		["dominator"] = { price = 1000000 },
		["ts1"] = { price = 370000 },
		["dominator3"] = { price = 1000000 },
		["impaler"] = { price = 200000 },
		["habanero"] = { price = 80000 },
		["sultanrs"] = { price = 500000 },
		["blazer5"] = { price = 300000 },
		["volatus"] = { price = 700000 },
		["frogger"] = { price = 700000 },
		["kuruma"] = { price = 400000 },
		["gt3rs"] = { price = 1000000 },
		["wolfsbane"] = { price = 100000 },
		["zombieb"] = { price = 100000 },
		["diablous"] = { price = 300000 },
		["cliffhanger"] = { price = 140000 },
		["hakuchou"] = { price = 200000 },
		["swift2"] = { price = 700000},
		["elegy"] = { price = 200000},
		["double"] = { price = 80000},
		["faggio"] = { price = 20000},
		["carbonrs"] = { price = 200000},
		["vader"] = { price = 120000},
		["chimera"] = { price = 120000},
		["akuma"] = { price = 300000},
		["sanchez2"] = { price = 100000},
		["benson"] = { price = 3000000 },
		["mule2"] = { price = 1500000 },
		["brawler"] = { price = 150000 },
		["mesa3"] = { price = 350000 },
		["dubsta3"] = { price = 250000 },
		["picador"] = { price = 150000 },
		["riata"] = { price = 750000 },
		["toros"] = { price = 350000 },
		["xls2"] = { price = 1500000 },
		["rocoto"] = { price = 150000 },
		["dubsta"] = { price = 350000 },
		["patriot"] = { price = 900000 },
		["fq2"] = { price = 200000 },
		["sadler"] = { price = 300000 },
		["surfer"] = { price = 200000 },
		["blista"] = { price = 50000 },
		["brioso"] = { price = 37000 },
		["dilettante"] = { price = 65000 },
		["rhapsody"] = { price = 45000 },
		["prairie"] = { price = 70000 },
		["f620"] = { price = 200000 },
		["sentinel2"] = { price = 150000 },
		["zion2"] = { price = 250000 },
		["jackal"] = { price = 70000 },
		["cogcabrio"] = { price = 150000 },
		["baller2"] = { price = 300000 },
		["asea"] = { price = 50000 },
		["schafter2"] = { price = 200000 },
		["schlagen"] = { price = 350000 },
		["fugitive"] = { price = 350000 },
		["surge"] = { price = 150000 },
		["burrito4"] = { price = 300000 },
		["verlierer2"] = { price = 120000 },
		["nero"] = { price = 1000000 },
		["specter"] = { price = 1800000 },
		["nero2"] = { price = 1000000 },
		["tempesta"] = { price = 300000 },
		["reaper"] = { price = 200000 },
		["zentorno"] = { price = 800000 },
		["xa21"] = { price = 250000 },
		["aperta"] = { price = 1000000 },
		["visione"] = { price = 500000 },
		["cyclone"] = { price = 800000 },
		["entity2"] = { price = 500000 },
		["fmj"] = { price = 350000 },
		["prototipo"] = { price = 380000 },
		["t20"] = { price = 3000000 },
		["Primo"] = { price = 100000 },
		["stafford"] = { price = 350000 },
		["superd"] = { price = 280000 },
		["cheburek"] = { price = 60000 },
		["rapidgt3"] = { price = 90000 }, 
		["bdivo"] = { price = 3500000 },
		["peyote"] = { price = 75000 },
		["yosemite"] = { price = 700000 },
		["bodhi2"] = { price = 550000 },
		["emperor"] = { price = 70000 },
		["vagner"] = { price = 900000 },
		["sc1"] = { price = 400000 },
		["flashgt"] = { price = 700000 },
		["carbonizzare"] = { price = 1200000 },
		["everon"] = { price = 1000000 },
		["seven70"] = { price = 350000 },
		["blazer4"] = { price = 300000 },
		["khamelion"] = { price = 400000 },
		["massacro"] = { price = 280000 },
		["jester"] = { price = 250000 },
		["ruston"] = { price = 100000 },
		["pariah"] = { price = 380000 },
		["dominator3"] = { price = 170000 },
		["sandking2"] = { price = 320000 },
		["panto"] = { price = 20000 },		
		["comet2"] = { price = 720000 },
		["tyrant"] = { price = 600000 },
		["zx10r"] = { price = 1000000 },
		["bmx"] = { price = 0 },
		["fixter"] = { price = 0 },
		["tribike3"] = { price = 0 },
		["vacca"] = { price = 0 },
		["taipan"] = { price = 1500000 },
		["baller4"] = { price = 200000 },
		["granger"] = { price = 250000 },
		["cavalcade2"] = { price = 200000 },
		["serrano"] = { price = 400000 },
		["xls"] = { price = 200000 },
		["huntley"] = { price = 250000 },
		["gresley"] = { price = 150000 },
		["blazer"] = { price = 50000 },
		["bfinjection"] = { price = 250000 },
		["dubsta2"] = { price = 200000 },
		["vagrant"] = { price = 200000 },
		["rumpo3"] = { price = 500000 },
		["sultan2"] = { price = 350000 },
		["elegy2"] = { price = 200000 },
		["ninef"] = { price = 300000 },
		["banshee2"] = { price = 500000 },
		["jester3"] = { price = 500000 },
		["voltic"] = { price = 300000 },
		["raiden"] = { price = 500000 },
		["tezeract"] = { price = 500000 },
		["neon"] = { price = 1500000 },
		["entityxf"] = { price = 350000 },
		["sentinel3"] = { price = 100000 },
		["taipan"] = { price = 1000000 },
		["turismor"] = { price = 390000 },
		["osiris"] = { price = 400000 },
		["italigto"] = { price = 700000 },
		["rmodgt63"] = { price = 1000000 },
		["komoda"] = { price = 1000000 },
		["imorgon"] = { price = 1000000 },
		["caracara2"] = { price = 1000000 },
		["sanctus"] = { price = 400000 },
		["gburrito"] = { price = 140000 },
		["senna"] = { price = 1000000 },
		["outlaw"] = { price = 200000 },
		["lancerevolutionx"] = { price = 1000000 },
		["kanjo"] = { price = 150000 },
		["asbo"] = { price = 150000 }, 
        ["kamacho"] = { price = 400000 }, 
		["bmwm3f80"] = { price = 2500000 }, 
		["mazdarx7"] = { price = 2800000 }, 
		["fordmustang"] = { price = 2200000 }, 
		["dodgechargersrt"] = { price = 1800000 }, 
		["bf400"] = { price = 150000 }, 
		["fz07"] = { price = 1000000 },
		["dm1200"] = { price = 1000000 },
		["rt70"] = { price = 20000 },
		["mercedesa45"] = { price = 1000000 },
		["club"] = { price = 40000 },
		["bugatti"] = { price = 1000000 },
		["bnsgtr99"] = { price = 1000000 },
		["amggtsprior"] = { price = 1000000 }, 
		["gt3rs"] = { price = 1000000 },
		["cayenne"] = { price = 1000000 },
		["audirs6"] = { price = 1000000 },
		["audirs7"] = { price = 1000000 },
		["fatboy"] = { price = 1000000 },
		["hondafk8"] = { price = 1000000 },
		["206"] = { price = 50000 },
		["mk3"] = { price = 80000 },
		["macan"] = { price = 1000000 },
		["q820"] = { price = 1000000 },
		["rs62"] = { price = 1000000 },
		["mgt"] = { price = 1000000 }, 
		["supervolito"] = { price = 20000 },
		["rmodlp750"] = { price = 1000000 },
		["nissanskyliner34"] = { price = 1000000 },
	    ["pistas"] = { price = 1000000 },
		["bmwm8"] = { price = 1000000 },
		["r820"] = { price = 1000000 },
		["nissangtrnismo"] = { price = 1000000 },
		["ferrariitalia"] = { price = 1000000 },
		["patriot2"] = { price = 350000 },
		["sandking"] = { price = 3000000 },
		["z4alchemist"] = { price = 1000000 },
		["mig"] = { price = 1000000 },
		["nissan370z"] = { price = 1000000 },
		["sbc9"] = { price = 1000000 },
		["amggtsprior"] = { price = 1000000 },
		["trossa"] = { price = 1000000 },
		["f100"] = { price = 90000 },
		["f80"] = { price = 90000 },
		["pts21"] = { price = 1000000 },
		["tr22"] = { price = 1000000 },

}

local idveh = {}
RegisterServerEvent("vrp_adv_garages_id")
AddEventHandler("vrp_adv_garages_id",function(netid,enginehealth,bodyhealth,fuel)
	if idveh[netid] and netid ~= 0 then
		local user_id = idveh[netid][1]
		local carname = idveh[netid][2]
		local player = vRP.getUserSource(user_id)
		if player then
			vRPgarage.despawnGarageVehicle(player,carname)
		end

		if enginehealth < 0 then
			enginehealth = 0
		end

		if bodyhealth < 0 then
			bodyhealth = 0
		end

		if fuel > 100 then
			fuel = 100
		end

		local rows = vRP.query("vRP/get_detido",{ user_id = user_id, vehicle = carname })
		if #rows > 0 then
			vRP.execute("vRP/set_vehstatus",{ user_id = user_id, vehicle = carname, engine = parseInt(enginehealth), body = parseInt(bodyhealth), fuel = parseInt(fuel) })
		end
	end
end)

function openGarage(source,gid,location)
	local source = source
	local user_id = vRP.getUserId(source)
	local vehicles = garage_types[gid]
	local gtypes = vehicles._config.gtype
	local mods = vehicles._shop
	local menu = { name = gid }

	for _,gtype in pairs(gtypes) do
		if gtype == "personal" then
			menu["Possuídos"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				if user_id then
					local kitems = {}
					local submenu = { name = "Possuídos" }
					submenu.onclose = function()
						vRP.openMenu(source,menu) 
					end

					local choose = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local rows = vRP.query("vRP/get_detido",{ user_id = user_id, vehicle = vname })
							local data = vRP.getSData("tuningCarro:id"..user_id.."veh:"..vname)
							local custom = json.decode(data) or ""

							local value = vRP.getUData(parseInt(user_id),"vRP:multas")
							local multas = json.decode(value) or 0
							if multas <= 50000 then
								if vname == 'swift2' then
									if location == 75 then
										local cond,netid,carname = vRPgarage.spawnGarageVehicle(source,vname,custom,parseInt(rows[1].engine),parseInt(rows[1].body),parseInt(rows[1].fuel),parseInt(75), 2)
										if cond then
											idveh[netid] = { user_id,carname }
										else
											TriggerClientEvent('chatMessage', source, "^2Já tem um veículo deste modelo fora da garagem.")
										end
									else
										TriggerClientEvent('chatMessage', source, "^2Voce so pode spawnar seu helicoptero no aeroporto.")
									end
								else
									local cond,netid,carname = vRPgarage.spawnGarageVehicle(source,vname,custom,parseInt(rows[1].engine),parseInt(rows[1].body),parseInt(rows[1].fuel),parseInt(location), 2)
									if cond then
										idveh[netid] = { user_id,carname }
									else
										TriggerClientEvent('chatMessage', source, "^2Já tem um veículo deste modelo fora da garagem.")
									end
								end
							else
								TriggerClientEvent('chatMessage', source, "^2Você possui ^5["..vRP.format(multas).."/500.000]^2 de multas pendentes e nao pode retirar seu veiculo!")
							end



							vRP.closeMenu(source)
						end
					end

					local choosedetido = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local ok = vRP.request(source,"Veículo na detenção, deseja acionar o seguro pagando $"..vRP.format(parseInt(carros[vname].price*0.1)).." dólares?",60)
							if ok then
								if vRP.tryFullPayment(user_id,parseInt(carros[vname].price*0.1)) then
									vRP.closeMenu(source)
									vRP.execute("vRP/set_detido",{ user_id = user_id, vehicle = vname, detido = 0})
									TriggerClientEvent('chatMessage', source, "^5Veículo liberado.")
								else
									TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
								end
							end
						end
					end

					local chooseipva = function(source,choice)
						local vname = kitems[choice]
						if vname then
							local ok = vRP.request(source,"Veículo com IPVA vencido, deseja libera-lo pagando $"..vRP.format(parseInt(carros[vname].price*0.01)).." dólares?",60)
							if ok then
								if vRP.tryFullPayment(user_id,parseInt(carros[vname].price*0.01)) then
									vRP.closeMenu(source)
									TriggerClientEvent('chatMessage', source, "^5Você pagou o IPVA do seu veiculo.")
									vRP.execute("vRP/set_ipva",{ user_id = user_id, vehicle = vname, ipva = 7})
								else
									TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
								end
							end
						end
					end

					local choosedetidotime = function(source,choice)
						local vname = kitems[choice]
						if vname then
							local ok = vRP.request(source,"Veículo na retenção, deseja acionar o seguro pagando $"..vRP.format(parseInt(carros[vname].price*0.25)).." dólares?",60)
							if ok then
								if vRP.tryFullPayment(user_id,parseInt(carros[vname].price*0.15)) then
									vRP.closeMenu(source)
									TriggerClientEvent('chatMessage', source, "^5Seguradora foi acionada, aguarde a notificação da liberação.")
									TriggerClientEvent("progress",source,30000,"liberando")
									SetTimeout(30000,function()
										vRP.execute("vRP/set_detido",{ user_id = user_id, vehicle = vname, detido = 0 })
										TriggerClientEvent('chatMessage', source, "^5Veículo liberado.")
									end)
								else
									TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
								end
							end
						end
					end

					local pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
					for k,v in pairs(pvehicles) do
						local vehicle
						for x,garage in pairs(garage_types) do
							vehicle = garage[v.vehicle]
							if vehicle then break end
						end

						if vehicle then
							local rows = vRP.query("vRP/get_detido",{ user_id = user_id, vehicle = v.vehicle })
							local checkIpva = parseInt(rows[1].ipva)
							if checkIpva == 0 then checkIpva = "VENCIDO" else checkIpva = checkIpva.." dia(s)" end

							if parseInt(rows[1].ipva) == 0 then
								submenu[vehicle[1]] = { chooseipva,"<text01>Lataria:</text01> <text02>"..vRP.format(parseInt(rows[1].body*0.1)).."%</text02><br><br><text01>Motor:</text01> <text02>"..vRP.format(parseInt(rows[1].engine*0.1)).."%</text02><br><br><text01>Gasolina:</text01> <text02>"..vRP.format(parseInt(rows[1].fuel)).."%</text02><br><br><text01>Seguro:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.005)).."</text02><br><br><text01>Detenção:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.1)).."</text02><br><br><text01>Retenção:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.25)).."</text02><br><br> <text01>Ipva:</text01> <text02>"..checkIpva.."</text02>" }
							end

							if parseInt(rows[1].detido) == 1 then
								submenu[vehicle[1]] = { choosedetidotime,"<text01>Lataria:</text01> <text02>"..vRP.format(parseInt(rows[1].body*0.1)).."%</text02><br><br><text01>Motor:</text01> <text02>"..vRP.format(parseInt(rows[1].engine*0.1)).."%</text02><br><br><text01>Gasolina:</text01> <text02>"..vRP.format(parseInt(rows[1].fuel)).."%</text02><br><br><text01>Seguro:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.005)).."</text02><br><br><text01>Detenção:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.1)).."</text02><br><br><text01>Retenção:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.25)).."</text02><br><br> <text01>Ipva:</text01> <text02>"..checkIpva.."</text02>" }
							end

							if parseInt(rows[1].detido) == 2 then
								submenu[vehicle[1]] = { choosedetido,"<text01>Lataria:</text01> <text02>"..vRP.format(parseInt(rows[1].body*0.1)).."%</text02><br><br><text01>Motor:</text01> <text02>"..vRP.format(parseInt(rows[1].engine*0.1)).."%</text02><br><br><text01>Gasolina:</text01> <text02>"..vRP.format(parseInt(rows[1].fuel)).."%</text02><br><br><text01>Seguro:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.005)).."</text02><br><br><text01>Detenção:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.1)).."</text02><br><br><text01>Retenção:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.25)).."</text02><br><br> <text01>Ipva:</text01> <text02>"..checkIpva.."</text02>" }
							end

							if parseInt(rows[1].detido) == 0 and parseInt(rows[1].ipva) >= 1 then
								submenu[vehicle[1]] = { choose,"<text01>Lataria:</text01> <text02>"..vRP.format(parseInt(rows[1].body*0.1)).."%</text02><br><br><text01>Motor:</text01> <text02>"..vRP.format(parseInt(rows[1].engine*0.1)).."%</text02><br><br><text01>Gasolina:</text01> <text02>"..vRP.format(parseInt(rows[1].fuel)).."%</text02><br><br><text01>Seguro:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.005)).."</text02><br><br><text01>Detenção:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.1)).."</text02><br><br><text01>Retenção:</text01> <text02>$"..vRP.format(parseInt(carros[rows[1].vehicle].price*0.25)).."</text02><br><br> <text01>Ipva:</text01> <text02>"..checkIpva.."</text02>" }
							end

							kitems[vehicle[1]] = v.vehicle
						end
					end
					vRP.openMenu(source,submenu)
				end
			end }

			menu["Guardar"] = { function(player,choice)
				local vehicle = vRPclient.getNearestVehicle(source,15)
				if vehicle then
					TriggerClientEvent('deletarveiculo',source,vehicle)
				end
			end }
		elseif gtype == "alugar" then
			menu["Aluguel"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				if user_id then
					local kitems = {}
					local submenu = { name = "Aluguel" }
					submenu.onclose = function()
						vRP.openMenu(source,menu)
					end

					local choose = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local vehicle = vehicles[vname]
							if vehicle then
							local data = vRP.getSData("tuningCarro:id"..user_id.."veh:"..vname)
							local custom = json.decode(data) or ""
								if vRP.tryPayment(user_id,vehicle[2]) then
										local cond,netid,carname = vRPgarage.spawnGarageVehicle(source,vname,custom,1000,1000,100,parseInt(location), 1)
										if cond then
											idveh[netid] = { user_id,carname }
											vRP.log("nzk_logs/player/aluguel.txt", "O [ID: "..user_id.."] alugou o veiculo "..vname.." pelo valor "..vehicle[2].."")
										else
											TriggerClientEvent('chatMessage', source, "^2Já tem um veículo deste modelo fora da garagem.")
										end
									else
										TriggerClientEvent('chatMessage', source, "^2Você não possui ^5$"..vehicle[2]..".")
									end
									vRP.closeMenu(source)
								end
						end
					end

					local _pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
					local pvehicles = {}
					for k,v in pairs(_pvehicles) do
						pvehicles[string.lower(v.vehicle)] = true
					end

					for k,v in pairs(vehicles) do
						if k ~= "_config" and k ~= "_shop" and pvehicles[string.lower(k)] == nil then
							if v[2] > 0 then
								submenu[v[1]] = { choose,"<text01>Valor:</text01> <text02>$"..v[2] }
							else
								submenu[v[1]] = { choose }
							end
							kitems[v[1]] = k
						end
					end
					vRP.openMenu(source,submenu)
				end
			end }

		elseif gtype == "rent" then
			menu["Aluguel"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				if user_id then
					local kitems = {}
					local submenu = { name = "Aluguel" }
					submenu.onclose = function()
						vRP.openMenu(source,menu)
					end

					local choose = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local data = vRP.getSData("custom:u"..user_id.."veh_"..vname)
							local custom = json.decode(data) or ""
							local cond,netid,carname = vRPgarage.spawnGarageVehicle(source,vname,custom,1000,1000,100,parseInt(location), 1)
							if cond then
								idveh[netid] = { user_id,carname }
							else
								TriggerClientEvent('chatMessage', source, "^2Já tem um veículo deste modelo fora da garagem.")
							end
							vRP.closeMenu(source)
						end
					end

					local _pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
					local pvehicles = {}
					for k,v in pairs(_pvehicles) do
						pvehicles[string.lower(v.vehicle)] = true
					end

					for k,v in pairs(vehicles) do
						if k ~= "_config" and k ~= "_shop" and pvehicles[string.lower(k)] == nil then
							submenu[v[1]] = { choose }
							kitems[v[1]] = k
						end
					end
					vRP.openMenu(source,submenu)
				end
			end }
 	
			menu["Guardar"] = { function(player,choice)
				local vehicle = vRPclient.getNearestVehicle(source,15)
				if vehicle then
					TriggerClientEvent('deletarveiculo',source,vehicle)
				end
			end }
		elseif gtype == "store" then
			menu["Comprar"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				if user_id then
					local kitems = {}
					local submenu = { name = "Comprar" }
					submenu.onclose = function()
						vRP.openMenu(source,menu)
					end

					local choose = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local vehicle = vehicles[vname]
							if vehicle then
								local ok = vRP.request(source,"Tem certeza que deseja comprar este veículo?",30)
								if ok then
									local rows = vRP.query("vRP/count_vehicle",{ vehicle = vname })
									if vehicle[4] ~= -1 and parseInt(rows[1].qtd) >= vehicle[4] then
										TriggerClientEvent('chatMessage', source, "^2Estoque indisponivel.")
									else
										local totalv = vRP.query("vRP/get_maxcars",{ user_id = user_id })
										local priceBuyCar = vehicle[2]
										local discountBuyCar = 0
										if vRP.hasPermission(user_id, "perm.prata") then
											discountBuyCar = priceBuyCar * 0.05
											maxCarsPerm = 6
										elseif vRP.hasPermission(user_id, "perm.ouro") then
											discountBuyCar = priceBuyCar * 0.07
											maxCarsPerm = 8
										elseif vRP.hasPermission(user_id, "perm.diamante") then
											discountBuyCar = priceBuyCar * 0.10
											maxCarsPerm = 10
										elseif vRP.hasPermission(user_id, "perm.platina") then
											discountBuyCar = priceBuyCar * 0.15
											maxCarsPerm = 12
										elseif vRP.hasPermission(user_id, "perm.esmeralda") then
											discountBuyCar = priceBuyCar * 0.20
											maxCarsPerm = 16
										else
											discountBuyCar = 0
											maxCarsPerm = 5
										end

										priceBuyCar = priceBuyCar - discountBuyCar

										if maxCarsPerm ~= -1 and totalv[1].quantidade >= maxCarsPerm then
											TriggerClientEvent('chatMessage', source, "^2A pessoa atingiu o número máximo de veículos na garagem. (Max: ^5" .. maxCarsPerm .."^2)")
										else
											--if vRP.hasGroup(user_id, "CNH") then
												if vRP.tryFullPayment(user_id,priceBuyCar) then
													vRP.execute("vRP/add_vehicle",{ user_id = user_id, vehicle = vname })
													if vehicle[2] > 0 then
														TriggerClientEvent('chatMessage', source, "^5Pagou $"..vRP.format(parseInt(priceBuyCar)).." dólares.")
														vRP.log("nzk_logs/player/comprarcarro.txt", "O [ID: "..user_id.."] Comprou o veiculo "..vname.." por "..vRP.format(parseInt(priceBuyCar)).."")
													end
													vRP.closeMenu(source)
												else
													TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
												end
											--else
											--	TriggerClientEvent('chatMessage', source, "^2Você Não possui carteira de motorista (CNH) e não pode comprar veiculos em uma concessionária.")
											--end
										end
									end
								end
							end
						end
					end

					local _pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
					local pvehicles = {}
					for k,v in pairs(_pvehicles) do
						pvehicles[string.lower(v.vehicle)] = true
					end

					for k,v in pairs(vehicles) do
						if k ~= "_config" and k ~= "_shop" and pvehicles[string.lower(k)] == nil then
							if v[2] > 0 then
								submenu[v[1]] = { choose,"<text01>Valor:</text01> <text02>$"..v[2].."</text02><br><br><text01>P-Malas:</text01> <text02>"..v[3].."</text02>" }
							else
								submenu[v[1]] = { choose }
							end
							kitems[v[1]] = k
						end
					end
					vRP.openMenu(source,submenu)
				end
			end }
			menu["Vender"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				if user_id then
					local kitems = {}
					local submenu = { name = "Vender" }
					submenu.onclose = function()
						vRP.openMenu(source,menu)
					end

					local choose = function(player,choice)
						local vname = kitems[choice]
						if vname then
							local vehicle = vehicles[vname]
							if vehicle then
								local ok = vRP.request(source,"Tem certeza que deseja vender este veículo?",30)
								if ok then
									local price = math.ceil(vehicle[2]*0.7)
									local rows = vRP.query("vRP/get_vehicle",{ user_id = user_id, vehicle = vname })
									if #rows <= 0 then
										return
									end
									if parseInt(rows[1].detido) >= 1 then
										TriggerClientEvent('chatMessage', source, "^2Acione a seguradora antes de vender.")
										return
									end
									vRP.execute("vRP/remove_vehicle",{ user_id = user_id, vehicle = vname })
									vRP.setSData("tuningCarro:id"..user_id.."veh:"..vname,json.encode())
									vRP.giveMoney(user_id,parseInt(price))
									if parseInt(price) > 0 then
										TriggerClientEvent('chatMessage', source, "^5Recebeu $"..vRP.format(parseInt(price)).." dólares.")
										vRP.log("nzk_logs/player/vendercarro.txt", "O [ID: "..user_id.."] Vendeu o veiculo "..vname.." por "..vRP.format(parseInt(price)).."")
									end
									vRP.closeMenu(source)
								end
							end
						end
					end

					local _pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
					local pvehicles = {}
					for k,v in pairs(_pvehicles) do
						pvehicles[string.lower(v.vehicle)] = true
					end

					for k,v in pairs(pvehicles) do
						local vehicle = vehicles[k]
						if vehicle then
							if vehicle[2] > 0 then
								submenu[vehicle[1]] = { choose,"<text01>Valor:</text01> <text02>$"..parseInt(math.ceil(vehicle[2]*0.7)).."</text02>" }
							else
								submenu[vehicle[1]] = { choose }
							end
							kitems[vehicle[1]] = k
						end
					end
					vRP.openMenu(source,submenu)
				end
			end }
		elseif gtype == "shop" then
			menu["Loja"] = { function(player,choice)
				local user_id = vRP.getUserId(source)
				local tosub = false
				if user_id then
					local submenu = { name = "Loja" }
					submenu.onclose = function()
						if not tosub then
							vRP.openMenu(source,menu)
						end
					end

					local ch_color = function(player,choice)
						local old_vname,old_custom = vRPgarage.getVehicleMods(source)
						local subsubmenu = { name = "Cores" }
						subsubmenu.onclose = function()
							tosub = false
							local vname,custom = vRPgarage.getVehicleMods(source)
							if custom then
								if vRP.tryFullPayment(user_id,3000) then
									if vname then
										local mPlaca = vRPclient.ModelName(player,7)
										local mPlacaUser = vRP.getUserByRegistration(mPlaca)
										if mPlacaUser then
											vRP.setSData("tuningCarro:id"..mPlacaUser.."veh:"..vname,json.encode(custom))
										end
										TriggerClientEvent('chatMessage', player, "^5Você Pagou $3.000 dólares.")
									end
								else
									vRPgarage.setVehicleMods(source,old_custom)
									TriggerClientEvent('chatMessage', player, "^9Dinheiro insuficiente.")
								end
							end
						vRP.openMenu(source,submenu)
					end

					local ch_pri = function(player,choice,mod)
						vRPgarage.scrollVehiclePrimaryColour(source,mod)
					end

					local ch_sec = function(player,choice,mod)
						vRPgarage.scrollVehicleSecondaryColour(source,mod)
					end

					local ch_primaria = function(player,choice)
						local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
						rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
						local r,g,b = table.unpack(splitString(rgb," "))
						vRPgarage.setCustomPrimaryColour(source,tonumber(r),tonumber(g),tonumber(b))
					end

					local ch_secundaria = function(player,choice)
						local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
						rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
						local r,g,b = table.unpack(splitString(rgb," "))
						vRPgarage.setCustomSecondaryColour(source,tonumber(r),tonumber(g),tonumber(b))
					end

					local ch_perolada = function(player,choice,mod)
						vRPgarage.scrollVehiclePearlescentColour(source,mod)
					end

					local ch_rodas = function(player,choice,mod)
						vRPgarage.scrollVehicleWheelColour(source,mod)
					end

					local ch_fumaca = function(player,choice)
						local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
						rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
						local r,g,b = table.unpack(splitString(rgb," "))
						vRPgarage.setSmokeColour(source,tonumber(r),tonumber(g),tonumber(b))
					end

					subsubmenu["Primária"] = { ch_pri }
					subsubmenu["Secundária"] = { ch_sec }
					subsubmenu["Primária RGB"] = { ch_primaria }
					subsubmenu["Secundária RGB"] = { ch_secundaria }
					subsubmenu["Perolada"] = { ch_perolada }
					subsubmenu["Rodas"] = { ch_rodas }
					subsubmenu["Fumaça"] = { ch_fumaca }

					tosub = true
					vRP.openMenu(source,subsubmenu)
				end

				submenu["Cores"] = { ch_color,"<text01>Valor:</text01> <text02>$3.000</text02>" }

				local ch_neon = function(player,choice)
					local old_vname,old_custom = vRPgarage.getVehicleMods(source)
					local subsubmenu = { name = "Neon" }
					subsubmenu.onclose = function()
						tosub = false
						local vname,custom = vRPgarage.getVehicleMods(source)
						if custom then
							if vRP.tryFullPayment(user_id,3000) then
								if vname then
									local mPlaca = vRPclient.ModelName(player,7)
									local mPlacaUser = vRP.getUserByRegistration(mPlaca)
									if mPlacaUser then
										vRP.setSData("tuningCarro:id"..mPlacaUser.."veh:"..vname,json.encode(custom))
									end
									TriggerClientEvent('chatMessage', player, "^2Você Pagou $3.000 dólares.")
								end
							else
								vRPgarage.setVehicleMods(source,old_custom)
								TriggerClientEvent('chatMessage', player, "^9Dinheiro insuficiente.")
							end
						end
						vRP.openMenu(source,submenu)
					end

					local ch_nleft = function(player,choice)
						vRPgarage.toggleNeon(source,0)
					end

					local ch_nright = function(player,choice)
						vRPgarage.toggleNeon(source,1)
					end

					local ch_nfront = function(player,choice)
						vRPgarage.toggleNeon(source,2)
					end

					local ch_nback = function(player,choice)
						vRPgarage.toggleNeon(source,3)
					end

					local ch_ncolor = function(player,choice)
						local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
						rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
						local r,g,b = table.unpack(splitString(rgb," "))
						vRPgarage.setNeonColour(source,tonumber(r),tonumber(g),tonumber(b))
					end

					subsubmenu["Traseiro"] = { ch_nback }
					subsubmenu["Dianteiro"] = { ch_nfront }
					subsubmenu["Esquerdo"] = { ch_nleft }
					subsubmenu["Direito"] = { ch_nright }
					subsubmenu["Cor"] = { ch_ncolor }
					tosub = true
					vRP.openMenu(source,subsubmenu)
				end

				submenu["Neon"] = { ch_neon,"<text01>Valor:</text01> <text02>$3.000</text02>" }

				local ch_mods = function(player,choice)
					local kitems = {}
					local old_vname,old_custom = vRPgarage.getVehicleMods(source)
					local subsubmenu = { name = "Modificações" }
					subsubmenu.onclose = function()
						tosub = false
						local vname,custom = vRPgarage.getVehicleMods(source)
						local price = 0
						local items = {}
						if custom then
							for k,v in pairs(custom.mods) do
								local old = old_custom.mods[k]
								local mod = mods[k]
								if mod then
									if old ~= v then
										if mod[4] then
											items[k] = { mod[4],mod[2] }
										else
											price = price + mod[2]
										end
									end
								end
							end
							if vRP.tryFullPayment(user_id,price) then
								if vname then
									local mPlaca = vRPclient.ModelName(player,7)
									local mPlacaUser = vRP.getUserByRegistration(mPlaca)
									if mPlacaUser then
										vRP.setSData("tuningCarro:id"..mPlacaUser.."veh:"..vname,json.encode(custom))
									end
									if price > 0 then
										TriggerClientEvent('chatMessage', source, "^5Você Pagou $"..vRP.format(parseInt(price)).." dólares.")
									end
								end
							else
								vRPgarage.setVehicleMods(source,old_custom)
								TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
							end
						end
						vRP.openMenu(source,submenu)
					end

					local ch_mod = function(player,choice,mod)
						vRPgarage.scrollVehicleMods(source,kitems[choice],mod)
					end

					for k,v in pairs(mods) do
						if v[2] > 0 then
							subsubmenu[v[1]] = { ch_mod,"<text01>Valor:</text01> <text02>$"..parseInt(math.max(v[2],0)).."</text02>" }
						else
							subsubmenu[v[1]] = { ch_mod }
						end
						kitems[v[1]] = k
					end
					tosub = true
					vRP.openMenu(source,subsubmenu)
				end

				local ch_repair = function(player,choice)
					if vRP.tryFullPayment(user_id,3000) then
						TriggerClientEvent('reparar',source)
						TriggerClientEvent('chatMessage', source, "^2Veículo reparado.")
					else
						TriggerClientEvent('chatMessage', source, "^9Dinheiro insuficiente.")
					end
				end

				submenu["Modificações"] = { ch_mods }
				submenu["Reparar"] = { ch_repair,"<text01>Valor:</text01> <text02>$3.000</text02>" }
				vRP.openMenu(source,submenu)
				end
			end }
		end
	end
	vRP.openMenu(source,menu)
end 
local function build_garages(source)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(cfg.garages) do
			local i,x,y,z,pay,loc = table.unpack(v)
			local g = cfg.garage_types[i]

			if g then
				local cfg = g._config
					if not cfg.ghome then
						local garage_enter = function(player,area)
						if user_id and vRP.hasPermissions(user_id,cfg.permissions or {}) then
							openGarage(source,i,pay,loc)
						end
					end

					local garage_leave = function(player,area)
						vRP.closeMenu(source)
					end
					
					vRPclient._addMarker(source,23,x,y,z-0.95,1,1,0.5,0,95,140,100,100)
					vRP.setArea(source,"vRP:garage"..k,x,y,z,1.0,1.0,garage_enter,garage_leave)
				end
			end
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_garages(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER O VEÍCULO PARA OUTRO JOGADOR 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vehs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local menu = vRP.buildMenu("vehicle",{ user_id = user_id, player = source, vname = name })
		menu.name = "Veículos"

		local kitems = {}
		local choose = function(source,choice)
			local tosub = false
			local vehicle = choice
			local vname = kitems[vehicle]
			local submenu = { name = vehicle }
			submenu.onclose = function()
				tosub = false
				vRP.openMenu(source,menu)
			end

			local ch_sell = function(source,choice)
				local nplayer = vRPclient.getNearestPlayer(source,3)
				if nplayer then
					local tuser_id = vRP.getUserId(nplayer)
					local totalv = vRP.query("vRP/get_maxcars",{ user_id = tuser_id })
					if vRP.hasPermission(user_id, "perm.prata") then
						maxCarsPerm = 7
					elseif vRP.hasPermission(user_id, "perm.ouro") then
						maxCarsPerm = 9
					elseif vRP.hasPermission(user_id, "perm.diamante") then
						maxCarsPerm = 12
					elseif vRP.hasPermission(user_id, "perm.platina") then
						maxCarsPerm = 20
					elseif vRP.hasPermission(user_id, "perm.platina") then
						maxCarsPerm = 26
					else
						maxCarsPerm = 5
					end
					
					if maxCarsPerm ~= -1 and totalv[1].quantidade >= maxCarsPerm then
						TriggerClientEvent('chatMessage', source, "^2A pessoa atingiu o número máximo de veículos na garagem. (Max: ^5" .. maxCarsPerm .."^2)")
					else
						local owned = vRP.query("vRP/get_vehicle",{ user_id = tuser_id, vehicle = vname })
						if #owned == 0 then
							local price = tonumber(sanitizeString(vRP.prompt(source,"Valor:",""),"\"[]{}+=?!_()#@%/\\|,.",false))
							local ok = vRP.request(nplayer,"Aceita comprar um "..vehicle.." por $"..vRP.format(parseInt(price)).." dólaresZ?",30)
							if ok then
								if parseInt(price) > 0 then
									if vRP.tryFullPayment(tuser_id,parseInt(price)) then
										vRP.execute("vRP/move_vehicle",{ user_id = user_id, tuser_id = tuser_id, vehicle = vname })
										local data = vRP.getSData("tuningCarro:id"..user_id.."veh:"..vname)
										local custom = json.decode(data) or ""
										vRP.setSData("tuningCarro:id"..tuser_id.."veh:"..vname, json.encode(custom))
										vRP.setSData("tuningCarro:id"..user_id.."veh:"..vname, json.encode())
										vRP.giveMoney(user_id,parseInt(price))
										TriggerClientEvent('chatMessage', nplayer, "^5Você Pagou $"..vRP.format(parseInt(price)).." dólares.")
										TriggerClientEvent('chatMessage', source, "^5Você Recebeu $"..vRP.format(parseInt(price)).." dólares.")
										vRP.log("nzk_logs/player/vendercarroplayer.txt", "O [ID: "..user_id.."] vendeu o carro ["..vname.."] por ($: "..vRP.format(parseInt(price))..") para o [ID: "..tuser_id.."]")
									else
										TriggerClientEvent('chatMessage', source, "^2Dinheiro insuficiente.")
										TriggerClientEvent('chatMessage', nplayer, "^2Dinheiro insuficiente.")
									end
								end
							end
						else
							TriggerClientEvent('chatMessage', source, "^2Este jogador ja possui este veiculo.")
						end
					end
				end
			end
			submenu["Vender"] = { ch_sell }
			tosub = true
			vRP.openMenu(source,submenu)
		end

		local choosedetido = function(source,choice)
			TriggerClientEvent('chatMessage', source, "^9Veículo roubado ou detido pela policia, acione a seguradora.")
		end

		local pvehicles = vRP.query("vRP/get_vehicles",{ user_id = user_id })
		for k,v in pairs(pvehicles) do
			local vehicle
			for x,garage in pairs(garage_types) do
				vehicle = garage[v.vehicle]
				if vehicle then break end
			end

			if vehicle then
				local rows = vRP.query("vRP/get_detido",{ user_id = user_id, vehicle = v.vehicle })
				if parseInt(rows[1].detido) <= 0 then
					menu[vehicle[1]] = { choose }
				else
					menu[vehicle[1]] = { choosedetido }
				end
				kitems[vehicle[1]] = v.vehicle
			end
		end

		vRP.openMenu(source,menu)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOTÃO L PARA TRANCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("buttonLock")
AddEventHandler("buttonLock",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local mPlaca = vRPclient.ModelName(source,3)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		if not vRPclient.isInComa(source) then
			if user_id then 
				registro = identity.registration.." "
				if mPlaca == registro then
					vRPgarage.toggleLock(source, mPlaca, registro)
					TriggerClientEvent("vrp_sound:source",source,'lock',0.1)
				end
			end
		end 
	end
end)

RegisterServerEvent("tryLock")
AddEventHandler("tryLock",function(nveh)
	TriggerClientEvent("syncLock",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ancorar',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local mPlaca = vRPclient.ModelName(source,7)
	local mPlacaUser = vRP.getUserByRegistration(mPlaca)
	if user_id == mPlacaUser then
		vRPgarage.toggleAnchor(source)
	end
end)