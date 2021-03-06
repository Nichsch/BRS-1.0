local cfg = {}

cfg.vehicle_chest_weights = {
--SUV
	["brawler"] = 30,
	["mesa3"] = 60,
	["dubsta3"] = 80,
	["riata"] = 100,
	["picador"] = 75,
	["toros"] = 40,
	["xls"] = 60,
	["rocoto"] = 40,
	["bjxl"] = 50,
	["dubsta"] = 50,
	["fq2"] = 40,
	["sadler"] = 100,
	["surfer"] = 120,
	["kamacho"] = 100,
	["x6m"] = 60,
	["tritonhpe"] = 100,
	["ram2500"] = 140,
	["guardian"] = 140,
	["yosemite"] = 100,
	["bodhi2"] = 90,
	["dubsta3"] = 100, 
	["kamacho"] = 150,
	["baller4"] = 50,
	["caracara2"] = 100,
	["senna"] = 20,
	["brickade"] = 2500,
	["lancerevolutionx"] = 50,
	["mercedesa45"] = 50,
--Populares
	["blista"] = 30,
	["brioso"] = 15,
	["f100"] = 120,
	["dilettante"] = 40, 
	["rhapsody"] = 20,
	["sanctus"] = 5,
	["Prairie"] = 20,
	["f620"] = 20,
	["sentinel2"] = 40,
	["zion2"] = 40,
	["jackal"] = 35,
	["cogcabrio"] = 20,
	["baller2"] = 50,
	["asea"] = 30,
	["schafter2"] = 35, 
	["fugitive"] = 40,
	["burrito4"] = 80,
	["verlierer2"] = 40,
	["370z"] = 40,
	["avq"] = 30,
	["370z"] = 30,
	["gt3rs"] = 60,
	["panto"] = 20,
	["komoda"] = 50,
	["imorgon"] = 40,
	["asbo"] = 40,
	["faggio"] = 5,
	["206"] = 40,
	["mk3"] = 40,
-- Super Carros
	["nero"] = 5,
	["nero2"] = 5, 
	["tempesta"] = 5, 
	["reaper"] = 5, 
	["zentorno"] = 5, 
	["taipan"] = 5,
	["cavalcade2"] = 50,
	["granger"] = 50,
	["xls"] = 50, 
	["serrano"] = 50,
	["gresley"] = 50,
	["huntley"] = 50,
	["xa21"] = 5, 
	["visione"] = 5, 
	["cyclone"] = 5, 
	["entity2"] = 5, 
	["fmj"] = 5, 
	["prototipo"] = 5, 
	["t20"] = 5, 
	["elegy"] = 20,
	["dominator"] = 20,
	["dominator3"] = 20, 
	["habanero"] = 20,
	["veneno"] = 20,
	["sultanrs"] = 30,
	["c8"] = 10,
	["ts1"] = 15,
	["cheetah"] = 15,
	["blazer"] = 5,
	["bfinjection"] = 20,
	["dubsta2"] = 20,
	["vagrant"] = 20, 
	["rumpo3"] = 50, 
	["sultan2"] = 30,
	["elegy2"] = 30,
	["ninef"] = 30,
	["banshee2"] = 30,
	["jester3"] = 30,
	["voltic"] = 30,
	["raiden"] = 30,
	["tezeract"] = 30,
	["neon"] = 30,
	["entityxf"] = 10,
	["sentinel3"] = 30,
	["taipan"] = 30,
	["osiris"] = 30,
	["italigto"] = 30,
	["turismor"] = 30,
-- Caminhões
	["benson"] = 1500,
	["mule2"] = 500,
	["pounder"] = 1000000,
-- Antigos
	["Primo"] = 25,
	["stafford"] = 20, 
	["superd"] = 30,
	["cheburek"] = 15, 
	["rapidgt3"] = 20,
	["peyote"] = 25,
	["emperor"] = 20,
	["impaler"] = 30,
	["vamos"] = 30,
	["boss302"] = 40,
	["sabregt"] = 30,
	["ellie"] = 30,
	["sentinel2"] = 20,
-- VIPS
	["vagner"] = 5,
	["sc1"] = 5,
	["flashgt"] = 5,
	["carbonizzare"] = 5,
	["seven70"] = 5,
	["everon"] = 150,
	["blazer4"] = 5,
	["khamelion"] = 5,
	["massacro"] = 5,
	["jester"] = 5,
	["ruston"] = 5,
	["pariah"] = 5,
	["dominator3"] = 5,
	["sandking"] = 150,
	["fct"] = 20,
	["nh2r"] = 10,
	["aperta"] = 20,
	["nissantitan17"] = 100,
	["ts1"] = 60,
	["bmwm3f80"] = 50,
	["mazdarx7"] = 50,
	["fordmustang"] = 50,
	["dodgechargersrt"] = 50,
	["cayenne"] = 60,
	["fatboy"] = 10,
	["hondafk8"] = 60,
	["macan"] = 60,
	["q820"] = 60,
	["rs62"] = 60,
	["mgt"] = 60,
	["supervolito"] = 100, 
	["nissanskyliner34"] = 60, 
	["r820"] = 60,
	["nissangtrnismo"] = 60,
	["ferrariitalia"] = 60,
	["mig"] = 60,
	["nissan370z"] = 60,
	["amggtsprior"] = 60,
	["f80"] = 20,
	["pts21"] = 20,
	["tr22"] = 20,
-- Motos
	["bati2"] = 5,
	["chimera"] = 5,
	["akuma"] = 5,
	["sanchez2"] = 5,
	["r1250"] = 5,
	["fz07"] = 10,
	["dm1200"] = 5,
	["fz07"] = 5,
	["nh2r"] = 5,
--MotoClube
	["hexer"] = 5,
	["nightblade"] = 5,
	["daemon"] = 5,
	["hakuchou"] = 15,
	["zombieb"] = 5,
	["wolfsbane"] = 5,
	["diablous"] = 15,
	["cliffhanger"] = 5,
	["dm1200"] = 5,
-- Exclusivos
	["pturismo"] = 30,
	["bdivo"] = 15,
	["patriot2"] = 15,
	["speedo2"] = 50,
	["volatus"] = 100,
	["frogger"] = 100,
	["shotaro"] = 10,
	["tyrant"] = 20,
	["zx10r"] = 15,
	["toyotasupra"] = 35,
	["vacca"] = 10,
	["rmodgt63"] = 50,
	["gburrito"] = 70,
	["rt70"] = 60,
	["club"] = 20,
	["bugatti"] = 5,
	["bnsgtr99"] = 55,
	["amggtsprior"] = 55, --524855022
	["gt3rs"] = 15,
	["cayenne"] = 45,
	["audirs6"] = 45,
	["audirs7"] = 55,
	["bmwm4gts"] = 55,
	["rmodlp750"] = 5,
	["pistas"] = 5,
	["bmwm8"] = 50,
	["patriot2"] = 50,
	["schlagen"] = 50,
	["dodgechargersrt"] = 50,
	["z4alchemist"] = 20,
	["sandking"] = 100,
	["fordmustang"] = 100,
	["sbc9"] = 100,
}

cfg.static_chest_types = {
	["fbb"] = {
		weight = 10000,
		id = "fbb",
		permissions = { "perm.motoclube" }
	},
	["bahamas"] = {
		weight = 10000,
		id = "bahamas",
		permissions = { "perm.tequilala" }
	},
	["roxos"] = {
		weight = 10000,
		id = "roxos",
		permissions = { "perm.brancos" }
	},
	["mafia"] = {
		weight = 10000,
		id = "mafia",
		permissions = { "perm.bratva" }
	},
	["mc"] = {
		weight = 10000,
		id = "mc",
		permissions = { "perm.yakuza" }
	},
	["vermelhos"] = {
		weight = 10000,
		id = "vermelhos",
		permissions = { "perm.vagos" }
	},
	["azuis"] = {
		weight = 10000,
		id = "azuis",
		permissions = { "perm.ballas" }
	},
	["cartel"] = {
		weight = 10000,
		id = "ct",
		permissions = { "perm.driftking" }
	},
	["civil"] = {
		weight = 10000,
		id = "civil",
		permissions = { "perm.civil" }
	},
	["pmilitar"] = {
		weight = 10000,
		id = "pm",
		permissions = { "perm.policia" }
	},
	["hospital"] = {
		weight = 5000,
		id = "hospital",
		permissions = { "perm.unizk" }
	},
	["galaxy"] = {
		weight = 10000,
		id = "galaxy",
		permissions = {"perm.vanilla" }
	},
	["thomas"] = {
		weight = 2000,
		id = "tm",
		permissions = { "perm.thomas" }
	},
	["luna"] = {
		weight = 2000,
		id = "ln",
		permissions = { "perm.luna" }
	},
	["milicia"] = {
		weight = 10000,
		id = "ml",
		permissions = { "perm.dragons" }
	},
	["playboy"] = {
		weight = 2000,
		id = "pl",
		permissions = { "perm.lucas" }
	},
	["vinhedo"] = {
		weight = 2000,
		id = "vd",
		permissions = { "perm.vinhedo" },
	},
	["palhacin"] = {
		weight = 2000,
		id = "pc",
		permissions = { "perm.palhacin" },
	},
	["mcn"] = {
		weight = 10000,
		id = "mcn",
		permissions = { "perm.mcn" },
	},
	["coruja"] = {
		weight = 10000,
		id = "coruja",
		permissions = { "perm.coruja" },
		
	}, 
	["rato"] = {
		weight = 10000,
		id = "rato",
		permissions = { "perm.rato" },
		
	},
	["urso"] = {
		weight = 10000,
		id = "urso",
		permissions = { "perm.urso" },
		
	},
	["lobo"] = {
		weight = 10000,
		id = "lobo",
		permissions = { "perm.lobo" },
		
	},
	["raposa"] = {
		weight = 10000,
		id = "raposa",
		permissions = { "perm.raposa" },
		
	},
	["diabo"] = {
		weight = 10000,
		id = "diabo",
		permissions = { "perm.diabo" },
		
	},
	["boi"] = {
		weight = 10000,
		id = "boi",
		permissions = { "perm.boi" },
		
	},
	["cavalo"] = {
		weight = 10000,
		id = "cavalo",
		permissions = { "perm.cavalo" },
		
	},
	["macaco"] = {
		weight = 10000,
		id = "macaco",
		permissions = { "perm.macaco" },
		
	},
	["fla"] = {
		weight = 2000,
		id = "fla",
		permissions = { "perm.fla" },
	},
	["flac"] = {
		weight = 2000,
		id = "flac",
		permissions = { "perm.flac" },
	},
		
}

cfg.static_chests = {
	{"fbb", -1144.5,-2004.32,13.19},
	{"bahamas", -1386.29,-627.55,30.82},
	{"galaxy", 393.50396728516,279.20755004883,94.991020202637},
	{"mc", -1150.13,4940.65,222.27},
	{"vermelhos", -1512.0625,330.84390258789,85.567016601562},
	{"azuis", 889.55,-273.34,66.34},
	{"cartel", 132.87,-3113.45,5.9},
	{"civil", 118.46,-729.06,242.16},
	{"pmilitar", 478.20,-985.76,24.91},
	{"roxos", 198.0,-2201.83,6.99},
	{"hospital", 302.61,-594.50,48.22},
	{"mafia", 1403.763671875,1144.6330566406,114.33362579346},
	{"luna", 1.09,529.67,170.62},
	{"thomas", -809.89,172.91,76.75},
	{"playboy", -1524.07,121.97,50.06},
	{"vinhedo", -1870.34,2059.23,135.44},
	{"palhacin", -3233.84,815.05,14.09},
	{"mcn", 986.92,-93.0,74.85},
	--bau favelas
	{"coruja", 352.72,3542.82,37.33},
	{"diabo", 2070.98,3439.49,47.85},
	{"boi", 234.47,6828.36,22.39},
	{"lobo", 557.98,3017.31,43.82},
	{"macaco", -118.72,2986.21,39.67},
	{"raposa", 2030.03,3930.08,37.16},
	{"rato", 1458.79,6590.85,15.3},
	{"urso", 1451.74,4534.31,57.03},
	{"cavalo", 1084.07,3587.11,37.75},
	{"fla", -2618.78,1693.53,146.34},
	{"flac",-1986.24,-498.16,20.74},
}
 
return cfg