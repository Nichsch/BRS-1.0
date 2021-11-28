function tvRP.getNearestVehicles(radius)
	local r = {}
	local px,py,pz = tvRP.getPosition()

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local x,y,z = table.unpack(GetEntityCoords(veh,true))
		local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end

function tvRP.checkOffSetAndHoodOpen(vehicle,sentOpenHood)
	
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 3.0, 0.5))
	local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -3.0, 0.5))
	local coordA = GetEntityCoords(GetPlayerPed(-1))
	
	if (GetDistanceBetweenCoords(coordA.x,coordA.y,coordA.z,x,y,z) < 1.5) or (GetDistanceBetweenCoords(coordA.x,coordA.y,coordA.z,x2,y2,z2) < 1.5) then
		if sentOpenHood then
			SetVehicleDoorOpen(vehicle,4,0,0)
		end
		return true,VehToNet(vehicle)
	else
		return false,-1
	end
end

function tvRP.getNearestVehicle(radius)
	local veh
	local vehs = tvRP.getNearestVehicles(radius)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh 
end

function tvRP.ejectVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		local veh = GetVehiclePedIsIn(ped,false)
		TaskLeaveVehicle(ped,veh,4160)
	end
end

function tvRP.isInVehicle()
	return IsPedSittingInAnyVehicle(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELHASH
-----------------------------------------------------------------------------------------------------------------------------------------
local vehList = {
   --[[ { hash = 836213613, name = "18performante", price = 1000000, banido = false },
	{ hash = 723779872, name = "toyotasupra", price = 1000000, banido = false },
	{ hash = 991407206, name = "r1250", price = 400000, banido = false },
	{ hash = 2047166283, name = "bmws", price = 1000000, banido = false },
	{ hash = -157095615, name = "bmwm3f80", price = 1000000, banido = false },
	{ hash = 2034235290, name = "mazdarx7", price = 1000000, banido = false },
	{ hash = -301519603, name = "ram2500", price = 1000000, banido = false },
	{ hash = 1503141430, name = "divo", price = 1000000, banido = false },
	{ hash = -1606187161, name = "nightblade", price = 380000, banido = false },
	{ hash = -1311154784, name = "cheetah", price = 390000, banido = false },
	{ hash = 873639469, name = "sentinel2", price = 380000, banido = false },
	{ hash = 301427732, name = "hexer", price = 240000, banido = false },
	{ hash = -405626514, name = "shotaro", price = 1000000, banido = false },
	{ hash = -49115651, name = "vamos", price = 180000, banido = false },
	{ hash = -1150515393, name = "c8", price = 1600000, banido = false },
	{ hash = 86520421, name = "bf400", price = 150000, banido = false },
	{ hash = -305727417, name = "brickade", price = 1000000, banido = false },
    { hash = -419705714, name = "tritonhpe", price = 1200000, banido = false },
	{ hash = -2107990196, name = "guardian", price = 400000, banido = false },
	{ hash = -1382835569, name = "cayenne", price = 1000000, banido = false },
	{ hash = -1296077726, name = "pturismo", price = 1000000, banido = false },
	{ hash = 466040693, name = "370z", price = 1000000, banido = false },
	{ hash = 1221510024, name = "nissantitan17", price = 1000000, banido = false },
	{ hash = 338562499, name = "vacca", price = 0, banido = false },
	{ hash = 341441189, name = "fz07", price = 1000000, banido = false },
	{ hash = -1667727259, name = "nh2r", price = 1000000, banido = false },
	{ hash = 433374210, name = "aqv", price = 1000000, banido = false },
	{ hash = -506359117, name = "x6m", price = 1000000, banido = false },
	{ hash = -42051018, name = "veneno", price = 1000000, banido = false },
	{ hash = -32005528, name = "boss302", price = 1000000, banido = false },
	{ hash = 1820118107, name = "huraperfospy", price = 600000, banido = false },
	{ hash = -1481236684, name = "aperta", price = 1000000, banido = false },
	{ hash = -486920242, name = "dm1200", price = 1000000, banido = false },
	{ hash = 196747873, name = "elegy", price = 200000, banido = false },
	{ hash = -618617997, name = "wolfsbane", price = 100000, banido = false },
	{ hash = -239841468, name = "diablous", price = 300000, banido = false },
	{ hash = -570033273, nome = "zombieb", price = 100000, banido = false },
	{ hash = 390201602, name = "cliffhanger", price = 140000, banido = false },
	{ hash = 2006142190, name = "daemon", price = 190000, banido = false },
	{ hash = 1265391242, name = "hakuchou ", price = 200000, banido = false },
	{ hash = 80636076, name = "dominator", price = 1000000, banido = false },
	{ hash = 884422927, name = "habanero", price = 80000, banido = false },
	{ hash = -1685021548, name = "ellie", price = 400000, banido = false },
	{ hash = -1267543371, name = "sabregt", price = 400000, banido = false },
	{ hash = -2096690334, name = "impaler", price = 200000, banido = false },
	{ hash = -295689028, name = "sultanrs", price = 500000, banido = false },
	{ hash = -121446169, name = "kamacho", price = 1000000, banido = false },
	{ hash = -1590337689, name = "blazer5", price = 300000, banido = false },
	{ hash = -1845487887, name = "volatus", price = 400000, banido = false },
	{ hash = -570033273, name = "ts1", price = 3700000, banido = false },
	{ hash = -784906648, name = "fct", price = 4000000, banido = false },
	{ hash = 744705981, name = "frogger", price = 400000, banido = false },
	{ hash = 1352136073, name = "sc1", price = 400000, banido = false },
	{ hash = 524855022, name = "gt3rs", price = 1000000, banido = false },
	{ hash = 1075432268, name = "swift2", price = 0, banido = false },
	{ hash = 196747873, name = "elegy", price = 0, banido = false },
	{ hash = -48031959, name = "blazer2", price = 0, banido = false },
	{ hash = -440768424, name = "blazer4", price = 300000, banido = false },
	{ hash = 1753414259, name = "enduro", price = 0, banido = false },
	{ hash = 6774487, name = "chimera", price = 120000, banido = false },
	{ hash = 1672195559, name = "akuma", price = 300000, banido = false },
	{ hash = -1453280962, name = "sanchez2", price = 100000, banido = false },
	{ hash = -1670998136, name = "double", price = 80000, banido = false },
	{ hash = -1842748181, name = "faggio", price = 20000, banido = false },
	{ hash = 11251904, name = "carbonrs", price = 200000, banido = false },
	{ hash = -1372848492, name = "kuruma", price = 400000, banido = false },
	{ hash = 1491277511, name = "sanctus", price = 400000, banido = false },
	{ hash = -140902153, name = "vader", price = 120000, banido = false },
	{ hash = 1886268224, name = "specter", price = 1800000, banido = false },
	{ hash = 2053223216, name = "benson", price = 3000000, banido = false },
	{ hash = 1737122785, name = "apollo", price = 3500000, banido = false },
	{ hash = -1050465301, name = "mule2", price = 1500000, banido = false },
	{ hash = -1479664699, name = "brawler", price = 150000, banido = false },
	{ hash = -2064372143, na me = "mesa3", price = 350000, banido = false },
	{ hash = -1237253773, name = "dubsta3", price = 250000, banido = false },
	{ hash = 1507916787, name = "picador", price = 150000, banido = false },
	{ hash = -1532697517, name = "riata", price = 750000, banido = false },
	{ hash = -1168952148, name = "toros", price = 350000, banido = false },
	{ hash = -432008408, name = "xls2", price = 1500000, banido = false },
	{ hash = 2136773105, name = "rocoto", price = 150000, banido = false },
	{ hash = -808457413, name = "patriot", price = 350000, banido = false },
	{ hash = 1177543287, name = "dubsta", price = 20000, banido = false },
	{ hash = -1137532101, name = "fq2", price = 200000, banido = false },
	{ hash = -599568815, name = "sadler", price = 300000, banido = false },
	{ hash = 699456151, name = "surfer", price = 200000, banido = false },
	{ hash = -344943009, name = "blista", price = 50000, banido = false },
	{ hash = 1549126457, name = "brioso", price = 37000, banido = false },
	{ hash = -1130810103, name = "dilettante", price = 65000, banido = false },
	{ hash = 841808271, name = "rhapsody", price = 45000, banido = false },
	{ hash = -1450650718, name = "prairie", price = 70000, banido = false },
	{ hash = -591610296, name = "f620", price = 200000, banido = false },
	{ hash = 873639469, name = "sentinel2", price = 150000, banido = false },
	{ hash = -1193103848, name = "zion2", price = 250000, banido = false },
	{ hash = -624529134, name = "jackal", price = 70000, banido = false },
	{ hash = 330661258, name = "cogcabrio", price = 150000, banido = false },
	{ hash = 142944341, name = "baller2", price = 300000, banido = false },
	{ hash = -1809822327, name = "asea", price = 50000, banido = false },
	{ hash = -1255452397, name = "schafter2", price = 200000, banido = false },
	{ hash = 1909141499, name = "fugitive", price = 350000, banido = false },
	{ hash = -1894894188, name = "surge", price = 150000, banido = false },
	{ hash = 893081117, name = "burrito4", price = 300000, banido = false },
	{ hash = 1102544804, name = "verlierer2", price = 120000, banido = false },
	{ hash = 1034187331, name = "nero", price = 1000000, banido = false },
	{ hash = 1093792632, name = "nero2", price = 1000000, banido = false },
	{ hash = 272929391, name = "tempesta", price = 300000, banido = false },
	{ hash = 234062309, name = "reaper", price = 200000, banido = false },
	{ hash = -1403128555, name = "zentorno", price = 800000, banido = false },
	{ hash = 917809321, name = "xa21", price = 250000, banido = false },
	{ hash = -998177792, name = "visione", price = 500000, banido = false },
	{ hash = 1392481335, name = "cyclone", price = 800000, banido = false },
	{ hash = -2120700196, name = "entity2", price = 500000, banido = false },
	{ hash = 1426219628, name = "fmj", price = 350000, banido = false },
	{ hash = 2123327359, name = "prototipo", price = 380000, banido = false },
	{ hash = 1663218586, name = "t20", price = 300000, banido = false },
	{ hash = -1150599089, name = "primo", price = 100000, banido = false },
    { hash = 321186144, name = "stafford", price = 350000, banido = false },
    { hash = 1123216662, name = "superd", price = 280000, banido = false },
    { hash = -988501280, name = "cheburek", price = 60000, banido = false },
    { hash = 2049897956, name = "rapidgt3", price = 90000, banido = false },
    { hash = 1830407356, name = "peyote", price = 75000, banido = false },
    { hash = -685276541, name = "emperor", price = 70000, banido = false },
	{ hash = 1939284556, name = "vagner", price = 900000, banido = false },
	{ hash = -1259134696, name = "flashgt", price = 700000, banido = false },
	{ hash = 2072687711, name = "carbonizzare", price = 1200000, banido = false },
	{ hash = -1757836725, name = "seven70", price = 350000, banido = false },
	{ hash = 544021352, name = "khamelion", price = 400000, banido = false },
	{ hash = -142942670, name = "massacro", price = 280000, banido = false },
	{ hash = -1297672541, name = "jester", price = 250000, banido = false },
	{ hash = 719660200, name = "ruston", price = 100000, banido = false },
	{ hash = 867799010, name = "pariah", price = 380000, banido = false },
	{ hash = -986944621, name = "dominator3", price = 170000, banido = false },
	{ hash = 989381445, name = "sandking2", price = 320000, banido = false },
	{ hash = -376434238, name = "tyrant", price = 600000, banido = false },
	{ hash = -714386060, name = "zx10r", price = 1000000, banido = false },
	{ hash = -431692672, name = "panto", price = 20000, banido = false },
	{ hash = 1075432268, name = "swift2", price = 100000, banido = false },
	{ hash = -1045541610, name = "comet2", price = 720000, banido = false },
	{ hash = 408825843, name = "outlaw", price = 200000, banido = false },
	{ hash = 634118882, name = "baller4", price = 200000, banido = false },
	{ hash = 1203490606, name = "xls", price = 200000, banido = false },
	{ hash = -789894171, name = "cavalcade2", price = 200000, banido = false },
	{ hash = -1775728740, name = "granger", price = 250000, banido = false },
	{ hash = 486987393, name = "huntley", price = 250000, banido = false },
	{ hash = -1543762099, name = "gresley", price = 150000, banido = false },
	{ hash = -2128233223, name = "blazer", price = 50000, banido = false },
	{ hash = 1126868326, name = "bfinjection", price = 250000, banido = false },
	{ hash = -394074634, name = "dubsta2", price = 200000, banido = false },
	{ hash = 740289177, name = "vagrant", price = 200000, banido = false }, 
	{ hash = 1475773103, name = "rumpo3", price = 500000, banido = false },
	{ hash = 101905590, name = "trophytruck", price = 300000, banido = false },
	{ hash = 872704284, name = "sultan2", price = 350000, banido = false },
	{ hash = -566387422, name = "elegy2", price = 200000, banido = false },
	{ hash = 1032823388, name = "ninef", price = 500000, banido = false },
	{ hash = 633712403, name = "banshee2", price = 500000, banido = false },
	{ hash = -214906006, name = "jester3", price = 500000, banido = false },
	{ hash = -507495760, name = "schlagen", price = 350000 , banido = false },
	{ hash = -1622444098, name = "voltic", price = 300000, banido = false },
	{ hash = -1529242755, name = "raiden", price = 500000, banido = false },
	{ hash = 1031562256, name = "tezeract", price = 800000, banido = false },
	{ hash = -1848994066 , name = "neon", price = 1500000, banido = false },
	{ hash = -1291952903, name = "entityxf", price = 1000000, banido = false },
	{ hash = 1104234922, name = "sentinel3", price = 100000, banido = false },
	{ hash = -1134706562 , name = "taipan", price = 800000, banido = false },
	{ hash = 408192225, name = "turismor", price = 390000, banido = false },
	{ hash = -331467772 , name = "italigto", price = 700000, banido = false },
	{ hash = 980885719, name = "rmodgt63", price = 1000000, banido = false },
	{ hash = 1987142870, name = "osiris", price = 400000, banido = false },
	{ hash = 960812448, name = "furia", price = 1000000, banido = false },
	{ hash = -1728685474, name = "coquette4", price = 1000000, banido = false },
	{ hash = -834353991, name = "komoda", price = 1000000, banido = false },
	{ hash = 598074270, name = "14charger", price = 1, banido = false },
	{ hash = 1082035569, name = "novakpolice", price = 1, banido = false },
	{ hash = -1205689942, name = "riot", price = 1, banido = false },
	{ hash = -1659712911, name = "bfbrs", price = 1, banido = false },
	{ hash = 1171719218, name = "carapolice", price = 1, banido = false },
	{ hash = -1132721664, name = "imorgon", price = 1000000, banido = false },
	{ hash = -1349095620, name = "caracara2", price = 1000000, banido = false },
	{ hash = -1745203402, name = "gburrito", price = 140000, banido = false },
	{ hash = -433961724, name = "senna", price = 1000000, banido = false },
	{ hash = 1118611807, name = "asbo", price = 100000, banido = false },
	{ hash = 1978088379, name = "lancerevolutionx", price = 1000000, banido = false },
	{ hash = 409049982, name = "kanjo", price = 150000, banido = false },
	{ hash = 1025737310, name = "rt70", price = 1000000, banido = false },
	{ hash = -1756021720, name = "everon", price = 100000, banido = false },
	{ hash = -740742391, name = "mercedesa45", price = 1000000, banido = false },
	{ hash = -2098954619, name = "club", price = 40000, banido = false },
	{ hash = -1444047101, name = "bugatti", price = 1000000, banido = false },
	{ hash = -1328869613, name = "amggtsprior", price = 1000000, banido = false },
	{ hash = 796659374, name = "sr510", price = 0, banido = false },
	{ hash = -311022263, name = "seashark3", price = 0, banido = false },
	{ hash = -616331036, name = "seashark2", price = 0, banido = false }, 
	{ hash = -726956308, name = "bnsgtr99", price = 20000, banido = false }, -- 524855022
	{ hash = 524855022, name = "gt3rs", price = 9999999, banido = false }, -- -1382835569
	{ hash = -1382835569, name = "cayenne", price = 1000000, banido = false },
	{ hash = 1676738519, name = "audirs6", price = 1000000, banido = false }, 
	{ hash = -192929549, name = "audirs7", price = 1000000, banido = false }, -- 1822496721
	{ hash = 1822496721, name = "fatboy", price = 1000000, banido = false }, 
	{ hash = 653510754, name = "hondafk8", price = 1000000, banido = false },-- 653510754
	{ hash = -854631421, name = "206", price = 50000, banido = false }, -- 854631421
	{ hash = -497997000, name = "mk3", price = 80000, banido = false },
	{ hash = -134949878, name = "rs62", price = 1000000, banido = false },
	{ hash = 1241978166, name = "macan", price = 1000000, banido = false },
	{ hash = -2006731729, name = "q820", price = 1000000, banido = false }, -- -1432034260 ]]
	{ hash = 836213613, name = "18performante", price = 1200000, banido = false },
	{ hash = 723779872, name = "toyotasupra", price = 1000000, banido = false },
	{ hash = 991407206, name = "r1250", price = 1500000, banido = false },
	{ hash = 2047166283, name = "bmws", price = 1200000, banido = false },
	{ hash = -157095615, name = "bmwm3f80", price = 2500000, banido = false },
	{ hash = 2034235290, name = "mazdarx7", price = 2800000, banido = false },
	{ hash = -301519603, name = "ram2500", price = 1800000, banido = false },
	{ hash = 1503141430, name = "divo", price = 900000, banido = false },
	{ hash = -1606187161, name = "nightblade", price = 380000, banido = false },
	{ hash = -1311154784, name = "cheetah", price = 2000000, banido = false },
	{ hash = 873639469, name = "sentinel2", price = 380000, banido = false },
	{ hash = 301427732, name = "hexer", price = 240000, banido = false },
	{ hash = -405626514, name = "shotaro", price = 200000, banido = false },
	{ hash = -49115651, name = "vamos", price = 180000, banido = false },
	{ hash = -1150515393, name = "c8", price = 1600000, banido = false },
	{ hash = 86520421, name = "bf400", price = 0, banido = false },
	{ hash = -305727417, name = "brickade", price = 1000000, banido = false },
    { hash = -419705714, name = "tritonhpe", price = 900000, banido = false },
	{ hash = -2107990196, name = "guardian", price = 400000, banido = false },
	{ hash = -1382835569, name = "cayenne", price = 1000000, banido = false },
	{ hash = -1296077726, name = "pturismo", price = 800000, banido = false },
	{ hash = 466040693, name = "370z", price = 600000, banido = false },
	{ hash = 1221510024, name = "nissantitan17", price = 1000000, banido = false },
	{ hash = 338562499, name = "vacca", price = 0, banido = false },
	{ hash = 341441189, name = "fz07", price = 650000, banido = false },
	{ hash = -1667727259, name = "nh2r", price = 2000000, banido = false },
	{ hash = 433374210, name = "aqv", price = 800000, banido = false },
	{ hash = -506359117, name = "x6m", price = 1300000, banido = false },
	{ hash = -42051018, name = "veneno", price = 8000000, banido = false },
	{ hash = -32005528, name = "boss302", price = 350000, banido = false },
	{ hash = 1820118107, name = "huraperfospy", price = 600000, banido = false },
	{ hash = -1481236684, name = "aperta", price = 5000000, banido = false },
	{ hash = -486920242, name = "dm1200", price = 800000, banido = false },
	{ hash = 196747873, name = "elegy", price = 1000000, banido = false },
	{ hash = -618617997, name = "wolfsbane", price = 100000, banido = false },
	{ hash = -239841468, name = "diablous", price = 300000, banido = false },
	{ hash = -570033273, nome = "zombieb", price = 100000, banido = false },
	{ hash = 390201602, name = "cliffhanger", price = 140000, banido = false },
	{ hash = 2006142190, name = "daemon", price = 190000, banido = false },
	{ hash = 1265391242, name = "hakuchou ", price = 1000000, banido = false },
	{ hash = 80636076, name = "dominator", price = 1500000, banido = false },
	{ hash = 884422927, name = "habanero", price = 80000, banido = false },
	{ hash = -1685021548, name = "ellie", price = 400000, banido = false },
	{ hash = -1267543371, name = "sabregt", price = 400000, banido = false },
	{ hash = -2096690334, name = "impaler", price = 200000, banido = false },
	{ hash = -295689028, name = "sultanrs", price = 500000, banido = false },
	{ hash = -121446169, name = "kamacho", price = 1000000, banido = false },
	{ hash = -1590337689, name = "blazer5", price = 300000, banido = false },
	{ hash = -1845487887, name = "volatus", price = 400000, banido = false },
	{ hash = -570033273, name = "ts1", price = 3700000, banido = false },
	{ hash = -784906648, name = "fct", price = 4000000, banido = false },
	{ hash = 744705981, name = "frogger", price = 400000, banido = false },
	{ hash = 1352136073, name = "sc1", price = 400000, banido = false },
	{ hash = 524855022, name = "gt3rs", price = 700000, banido = false },
	{ hash = 1075432268, name = "swift2", price = 0, banido = false },
	{ hash = 196747873, name = "elegy", price = 0, banido = false },
	{ hash = -48031959, name = "blazer2", price = 0, banido = false },
	{ hash = -440768424, name = "blazer4", price = 300000, banido = false },
	{ hash = 1753414259, name = "enduro", price = 0, banido = false },
	{ hash = 6774487, name = "chimera", price = 200000, banido = false },
	{ hash = 1672195559, name = "akuma", price = 300000, banido = false },
	{ hash = -1453280962, name = "sanchez2", price = 100000, banido = false },
	{ hash = -1670998136, name = "double", price = 800000, banido = false },
	{ hash = -1842748181, name = "faggio", price = 20000, banido = false },
	{ hash = 11251904, name = "carbonrs", price = 200000, banido = false },
	{ hash = -1372848492, name = "kuruma", price = 700000, banido = false },
	{ hash = 1491277511, name = "sanctus", price = 400000, banido = false },
	{ hash = -140902153, name = "vader", price = 300000, banido = false },
	{ hash = 1886268224, name = "specter", price = 1800000, banido = false },
	{ hash = 2053223216, name = "benson", price = 2500000, banido = false },
	{ hash = 1737122785, name = "apollo", price = 3500000, banido = false },
	{ hash = -1050465301, name = "mule2", price = 1500000, banido = false },
	{ hash = -1479664699, name = "brawler", price = 500000, banido = false },
	{ hash = -2064372143, name = "mesa3", price = 550000, banido = false },
	{ hash = -1237253773, name = "dubsta3", price = 600000, banido = false },
	{ hash = 1507916787, name = "picador", price = 150000, banido = false },
	{ hash = -1532697517, name = "riata", price = 750000, banido = false },
	{ hash = -1168952148, name = "toros", price = 600000, banido = false },
	{ hash = -432008408, name = "xls2", price = 1500000, banido = false },
	{ hash = 2136773105, name = "rocoto", price = 400000, banido = false },
	{ hash = -808457413, name = "patriot", price = 900000, banido = false },
	{ hash = 1177543287, name = "dubsta", price = 350000, banido = false },
	{ hash = -1137532101, name = "fq2", price = 200000, banido = false },
	{ hash = -599568815, name = "sadler", price = 300000, banido = false },
	{ hash = 699456151, name = "surfer", price = 200000, banido = false },
	{ hash = -344943009, name = "blista", price = 65000, banido = false },
	{ hash = 1549126457, name = "brioso", price = 37000, banido = false },
	{ hash = -1130810103, name = "dilettante", price = 65000, banido = false },
	{ hash = 841808271, name = "rhapsody", price = 45000, banido = false },
	{ hash = -1450650718, name = "prairie", price = 70000, banido = false },
	{ hash = -591610296, name = "f620", price = 200000, banido = false },
	{ hash = 873639469, name = "sentinel2", price = 150000, banido = false },
	{ hash = -1193103848, name = "zion2", price = 250000, banido = false },
	{ hash = -624529134, name = "jackal", price = 70000, banido = false },
	{ hash = 330661258, name = "cogcabrio", price = 150000, banido = false },
	{ hash = 142944341, name = "baller2", price = 300000, banido = false },
	{ hash = -1809822327, name = "asea", price = 50000, banido = false },
	{ hash = -1255452397, name = "schafter2", price = 200000, banido = false },
	{ hash = 1909141499, name = "fugitive", price = 350000, banido = false },
	{ hash = -1894894188, name = "surge", price = 400000, banido = false },
	{ hash = 893081117, name = "burrito4", price = 300000, banido = false },
	{ hash = 1102544804, name = "verlierer2", price = 1200000, banido = false },
	{ hash = 1034187331, name = "nero", price = 1500000, banido = false },
	{ hash = 1093792632, name = "nero2", price = 1800000, banido = false },
	{ hash = 272929391, name = "tempesta", price = 1300000, banido = false },
	{ hash = 234062309, name = "reaper", price = 2000000, banido = false },
	{ hash = -1403128555, name = "zentorno", price = 8000000, banido = false },
	{ hash = 917809321, name = "xa21", price = 1500000, banido = false },
	{ hash = -998177792, name = "visione", price = 2000000, banido = false },
	{ hash = 1392481335, name = "cyclone", price = 2000000, banido = false },
	{ hash = -2120700196, name = "entity2", price = 1200000, banido = false },
	{ hash = 1426219628, name = "fmj", price = 1500000, banido = false },
	{ hash = 2123327359, name = "prototipo", price = 2800000, banido = false },
	{ hash = 1663218586, name = "t20", price = 3000000, banido = false },
	{ hash = -1150599089, name = "primo", price = 100000, banido = false },
    { hash = 321186144, name = "stafford", price = 350000, banido = false },
    { hash = 1123216662, name = "superd", price = 280000, banido = false },
    { hash = -988501280, name = "cheburek", price = 60000, banido = false },
    { hash = 2049897956, name = "rapidgt3", price = 400000, banido = false },
    { hash = 1830407356, name = "peyote", price = 75000, banido = false },
    { hash = -685276541, name = "emperor", price = 70000, banido = false },
	{ hash = 1939284556, name = "vagner", price = 2000000, banido = false },
	{ hash = -1259134696, name = "flashgt", price = 700000, banido = false },
	{ hash = 2072687711, name = "carbonizzare", price = 2600000, banido = false },
	{ hash = -1757836725, name = "seven70", price = 2000000, banido = false },
	{ hash = 544021352, name = "khamelion", price = 1000000, banido = false },
	{ hash = -142942670, name = "massacro", price = 2800000, banido = false },
	{ hash = -1297672541, name = "jester", price = 2500000, banido = false },
	{ hash = 719660200, name = "ruston", price = 1000000, banido = false },
	{ hash = 867799010, name = "pariah", price = 3800000, banido = false },
	{ hash = -986944621, name = "dominator3", price = 1700000, banido = false },
	{ hash = 989381445, name = "sandking2", price = 1200000, banido = false },
	{ hash = -376434238, name = "tyrant", price = 600000, banido = false },
	{ hash = -714386060, name = "zx10r", price = 500000, banido = false },
	{ hash = -431692672, name = "panto", price = 20000, banido = false },
	{ hash = 1075432268, name = "swift2", price = 100000, banido = false },
	{ hash = -1045541610, name = "comet2", price = 720000, banido = false },
	{ hash = 408825843, name = "outlaw", price = 1000000, banido = false },
	{ hash = 634118882, name = "baller4", price = 500000, banido = false },
	{ hash = 1203490606, name = "xls", price = 300000, banido = false },
	{ hash = -789894171, name = "cavalcade2", price = 500000, banido = false },
	{ hash = -1775728740, name = "granger", price = 400000, banido = false },
	{ hash = 486987393, name = "huntley", price = 350000, banido = false },
	{ hash = -1543762099, name = "gresley", price = 350000, banido = false },
	{ hash = -2128233223, name = "blazer", price = 100000, banido = false },
	{ hash = 1126868326, name = "bfinjection", price = 250000, banido = false },
	{ hash = -394074634, name = "dubsta2", price = 450000, banido = false },
	{ hash = 740289177, name = "vagrant", price = 300000, banido = false }, 
	{ hash = 1475773103, name = "rumpo3", price = 800000, banido = false },
	{ hash = 101905590, name = "trophytruck", price = 500000, banido = false },
	{ hash = 872704284, name = "sultan2", price = 500000, banido = false },
	{ hash = -566387422, name = "elegy2", price = 500000, banido = false },
	{ hash = 1032823388, name = "ninef", price = 500000, banido = false },
	{ hash = 633712403, name = "banshee2", price = 500000, banido = false },
	{ hash = -214906006, name = "jester3", price = 500000, banido = false },
	{ hash = -507495760, name = "schlagen", price = 700000 , banido = false },
	{ hash = -1622444098, name = "voltic", price = 500000, banido = false },
	{ hash = -1529242755, name = "raiden", price = 500000, banido = false },
	{ hash = 1031562256, name = "tezeract", price = 800000, banido = false },
	{ hash = -1848994066 , name = "neon", price = 1500000, banido = false },
	{ hash = -1291952903, name = "entityxf", price = 1000000, banido = false },
	{ hash = 1104234922, name = "sentinel3", price = 100000, banido = false },
	{ hash = -1134706562 , name = "taipan", price = 800000, banido = false },
	{ hash = 408192225, name = "turismor", price = 1200000, banido = false },
	{ hash = -331467772 , name = "italigto", price = 1600000, banido = false },
	{ hash = 980885719, name = "rmodgt63", price = 1000000, banido = false },
	{ hash = 1987142870, name = "osiris", price = 1000000, banido = false },
	{ hash = 960812448, name = "furia", price = 1000000, banido = false },
	{ hash = -1728685474, name = "coquette4", price = 1000000, banido = false },
	{ hash = -834353991, name = "komoda", price = 1000000, banido = false },
	{ hash = 598074270, name = "14charger", price = 100000, banido = false },
	{ hash = 1082035569, name = "novakpolice", price = 100000, banido = false },
	{ hash = -1205689942, name = "riot", price = 1, banido = false },
	{ hash = -1659712911, name = "bfbrs", price = 1, banido = false },
	{ hash = 1171719218, name = "carapolice", price = 1, banido = false },
	{ hash = -1132721664, name = "imorgon", price = 1000000, banido = false },
	{ hash = -1349095620, name = "caracara2", price = 1000000, banido = false },
	{ hash = -1745203402, name = "gburrito", price = 400000, banido = false },
	{ hash = -433961724, name = "senna", price = 1000000, banido = false },
	{ hash = 1118611807, name = "asbo", price = 100000, banido = false },
	{ hash = 1978088379, name = "lancerevolutionx", price = 1000000, banido = false },
	{ hash = 409049982, name = "kanjo", price = 150000, banido = false },
	{ hash = 1025737310, name = "rt70", price = 9999999, banido = false },
	{ hash = -1756021720, name = "everon", price = 100000, banido = false },
	{ hash = -740742391, name = "mercedesa45", price = 1000000, banido = false },
	{ hash = -2098954619, name = "club", price = 100000, banido = false }, -- 
	{ hash = -1444047101, name = "bugatti", price = 1000000, banido = false },
	{ hash = -1328869613, name = "amggtsprior", price = 9999999, banido = false },
	{ hash = 796659374, name = "sr510", price = 0, banido = false },
	{ hash = -311022263, name = "seashark3", price = 0, banido = false },
	{ hash = -616331036, name = "seashark2", price = 0, banido = false }, 
	{ hash = -726956308, name = "bnsgtr99", price = 999999, banido = false }, -- 524855022
	{ hash = 524855022, name = "gt3rs", price = 9999999, banido = false }, -- -1382835569
	{ hash = -1382835569, name = "cayenne", price = 9999999, banido = false },
	{ hash = 1676738519, name = "audirs6", price = 9999999, banido = false }, 
	{ hash = -192929549, name = "audirs7", price = 9999999, banido = false }, -- 1822496721
	{ hash = 1822496721, name = "fatboy", price = 20000, banido = false }, 
	{ hash = 653510754, name = "hondafk8", price = 20000, banido = false },-- 653510754
	{ hash = -854631421, name = "206", price = 20000, banido = false }, -- 854631421
	{ hash = -497997000, name = "mk3", price = 20000, banido = false },
	{ hash = -134949878, name = "rs62", price = 20000, banido = false },
	{ hash = 1241978166, name = "macan", price = 20000, banido = false },
	{ hash = -2006731729, name = "q820", price = 20000, banido = false },
	{ hash = -1432034260, name = "mgt", price = 1000000, banido = false },
	{ hash = 710198397, name = "supervolito", price = 20000, banido = false }, 
	{ hash = -1698677681, name = "rmodlp750", price = 1000000, banido = false },
	{ hash = -4816535, name = "nissanskyliner34", price = 1000000, banido = false },
	{ hash = 1128102088, name = "pistas", price = 1000000, banido = false },
	{ hash = -1404319008, name = "bmwm8", price = 1000000, banido = false },
	{ hash = -143695728, name = "r820", price = 1000000, banido = false },
	{ hash = 670022011, name = "nissangtrnismo", price = 1000000, banido = false },
	{ hash = -1173768715, name = "nissangtrnismo", price = 1000000, banido = false },
	{ hash = -420911112, name = "patriot2", price = 900000, banido = false }, 
	{ hash = 1601422646, name = "dodgechargersrt", price = 1800000, banido = false },
	{ hash = -1670780519, name = "z4alchemist", price = 1000000, banido = false },
	{ hash = -1189015600, name = "sandking", price = 300000, banido = false },
	{ hash = -1573350092, name = "fordmustang", price = 300000, banido = false },
	{ hash = 669333619, name = "mig", price = 1000000, banido = false },
	{ hash = -2015218799, name = "nissan370z", price = 1000000, banido = false },
	{ hash = -444094198, name = "sbc9", price = 1000000, banido = false },
	{ hash = 644003931, name = "amggtsprior", price = 1000000, banido = false },
	{ hash = -494102404, name = "trossa", price = 1000000, banido = false },
	{ hash = 410729828, name = "f100", price = 1000000, banido = false },
	{ hash = -1543097373, name = "f80", price = 1000000, banido = false },
	{ hash = 1694479740, name = "pts21", price = 1000000, banido = false },
	{ hash = 1197361861, name = "tr22", price = 1000000, banido = false },
}

function tvRP.ModelName(radius)
	local veh = tvRP.getNearestVehicle(radius)
	if IsEntityAVehicle(veh) then
		local lock = GetVehicleDoorLockStatus(veh) >= 2
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		for k,v in pairs(vehList) do
			if v.hash == GetEntityModel(veh) then
				if v.name then
					return GetVehicleNumberPlateText(veh),v.name,VehToNet(veh),parseInt(v.price),v.banido,lock,GetDisplayNameFromVehicleModel(v.name),GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
				end
			end
		end
	end
end

function tvRP.ModelName2()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		for k,v in pairs(vehList) do
			if v.hash == GetEntityModel(veh) then
				if v.name then
					return GetVehicleNumberPlateText(veh),v.name,parseInt(v.price),v.banido,VehToNet(veh),veh
				end
			end
		end
	end
end
