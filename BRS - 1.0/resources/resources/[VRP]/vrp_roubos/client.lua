local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_roubos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1 , ['x'] = 24.49, ['y'] = -1344.99, ['z'] = 29.49, ['h'] = 265.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3 },
	{ ['id'] = 2 , ['x'] = 24.50 , ['y'] = -1347.34 , ['z'] = 29.49 , ['h'] = 267.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 3 , ['x'] = 2554.90 , ['y'] = 380.94 , ['z'] = 108.62 , ['h'] = 349.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 4 , ['x'] = 2557.23 , ['y'] = 380.83 , ['z'] = 108.62 , ['h'] = 354.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 5 , ['x'] = 1165.07 , ['y'] = -324.50 , ['z'] = 69.20 , ['h'] = 127.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 6 , ['x'] = 1164.67 , ['y'] = -322.76 , ['z'] = 69.20 , ['h'] = 94.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 7 , ['x'] = -706.10 , ['y'] = -915.43 , ['z'] = 19.21 , ['h'] = 116.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 8 , ['x'] = -706.16 , ['y'] = -913.65 , ['z'] = 19.21 , ['h'] = 85.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 9 , ['x'] = -47.96 , ['y'] = -1759.34 , ['z'] = 29.42 , ['h'] = 74.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 10 , ['x'] = -46.80 , ['y'] = -1757.94 , ['z'] = 29.42 , h = 45.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 11 , ['x'] = 372.58 , ['y'] = 326.39 , ['z'] = 103.56 , ['h'] = 252.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 12 , ['x'] = 373.10 , ['y'] = 328.64 , ['z'] = 103.56 , ['h'] = 255.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 13 , ['x'] = -3242.24 , ['y'] = 1000.01 , ['z'] = 12.83 , ['h'] = 352.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 14 , ['x'] = -3244.56 , ['y'] = 1000.20 , ['z'] = 12.83 , ['h'] = 354.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 15 , ['x'] = 1727.88 , ['y'] = 6415.21 , ['z'] = 35.03 , ['h'] = 239.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 16 , ['x'] = 1728.90 , ['y'] = 6417.25 , ['z'] = 35.03 , ['h'] = 240.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 17 , ['x'] = 549.03 , ['y'] = 2671.36 , ['z'] = 42.15 , ['h'] = 93.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 18 , ['x'] = 549.33 , ['y'] = 2669.04 , ['z'] = 42.15 , ['h'] = 93.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 19 , ['x'] = 1958.96 , ['y'] = 3742.01 , ['z'] = 32.34 , ['h'] = 298.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 20 , ['x'] = 1960.12 , ['y'] = 3740.01 , ['z'] = 32.34 , ['h'] = 295.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 21 , ['x'] = 2678.07 , ['y'] = 3279.42 , ['z'] = 55.24 , ['h'] = 327.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 22 , ['x'] = 2676.03 , ['y'] = 3280.56 , ['z'] = 55.24 , ['h'] = 327.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 23 , ['x'] = 1696.57 , ['y'] = 4923.95 , ['z'] = 42.06 , ['h'] = 353.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 24 , ['x'] = 1698.06 , ['y'] = 4922.96 , ['z'] = 42.06 , ['h'] = 323.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 25 , ['x'] = -1818.89 , ['y'] = 792.94 , ['z'] = 138.08 , ['h'] = 161.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 26 , ['x'] = -1820.12 , ['y'] = 794.16 , ['z'] = 138.08 , ['h'] = 129.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 27 , ['x'] = 1392.87 , ['y'] = 3606.39 , ['z'] = 34.98 , ['h'] = 195.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 28 , ['x'] = -2966.44 , ['y'] = 390.89 , ['z'] = 15.04 , ['h'] = 84.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 29 , ['x'] = -3038.95 , ['y'] = 584.55 , ['z'] = 7.90 , ['h'] = 16.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 30 , ['x'] = -3041.19 , ['y'] = 583.84 , ['z'] = 7.90 , ['h'] = 14.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 31 , ['x'] = 1134.25 , ['y'] = -982.47 , ['z'] = 46.41 , ['h'] = 273.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 32 , ['x'] = 1165.93 , ['y'] = 2710.77 , ['z'] = 38.15 , ['h'] = 177.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 33 , ['x'] = -1486.29 , ['y'] = -378.02 , ['z'] = 40.16 , ['h'] = 132.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 34 , ['x'] = -1221.99 , ['y'] = -908.29 , ['z'] = 12.32 , ['h'] = 28.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 35 , ['x'] = 73.97 , ['y'] = -1392.13 , ['z'] = 29.37 , ['h'] = 267.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 36 , ['x'] = 74.86 , ['y'] = -1387.70 , ['z'] = 29.37 , ['h'] = 182.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 37 , ['x'] = 78.02 , ['y'] = -1387.69 , ['z'] = 29.37 , ['h'] = 177.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 38 , ['x'] = 426.96 , ['y'] = -806.99 , ['z'] = 29.49 , ['h'] = 91.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 39 , ['x'] = 426.08 , ['y'] = -811.44 , ['z'] = 29.49 , ['h'] = 358.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 40 , ['x'] = 422.91 , ['y'] = -811.44 , ['z'] = 29.49 , ['h'] = 358.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 41 , ['x'] = -816.56 , ['y'] = -1073.25 , ['z'] = 11.32 , ['h'] = 122.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 42 , ['x'] = -818.14 , ['y'] = -1070.52 , ['z'] = 11.32 , ['h'] = 122.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 43 , ['x'] = -822.41 , ['y'] = -1071.94 , ['z'] = 11.32 , ['h'] = 206.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 44 , ['x'] = -1195.24 , ['y'] = -768.03 , ['z'] = 17.31 , ['h'] = 215.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 45 , ['x'] = -1193.86 , ['y'] = -767.00 , ['z'] = 17.31 , ['h'] = 215.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 46 , ['x'] = -1192.44 , ['y'] = -765.93 , ['z'] = 17.31 , ['h'] = 215.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 47 , ['x'] = 5.21 , ['y'] = 6510.88 , ['z'] = 31.87 , ['h'] = 41.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 48 , ['x'] = 1.34 , ['y'] = 6508.52 , ['z'] = 31.87 , ['h'] = 309.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 49 , ['x'] = -0.80 , ['y'] = 6510.80 , ['z'] = 31.87 , ['h'] = 309.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 50 , ['x'] = 1695.38 , ['y'] = 4822.23 , ['z'] = 42.06 , ['h'] = 92.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 51 , ['x'] = 1695.10 , ['y'] = 4817.71 , ['z'] = 42.06 , ['h'] = 4.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 52 , ['x'] = 1691.98 , ['y'] = 4817.31 , ['z'] = 42.06 , ['h'] = 4.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 53 , ['x'] = 127.50 , ['y'] = -222.58 , ['z'] = 54.55 , ['h'] = 70.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 54 , ['x'] = 126.93 , ['y'] = -224.18 , ['z'] = 54.55 , ['h'] = 70.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 55 , ['x'] = 126.30 , ['y'] = -225.88 , ['z'] = 54.55 , ['h'] = 70.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 56 , ['x'] = 613.14 , ['y'] = 2760.96 , ['z'] = 42.08 , ['h'] = 273.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 57 , ['x'] = 612.99 , ['y'] = 2762.69 , ['z'] = 42.08 , ['h'] = 273.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 58 , ['x'] = 612.85 , ['y'] = 2764.46 , ['z'] = 42.08 , ['h'] = 273.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 59 , ['x'] = 1197.42 , ['y'] = 2711.63 , ['z'] = 38.22 , ['h'] = 175.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 60 , ['x'] = 1201.88 , ['y'] = 2710.74 , ['z'] = 38.22 , ['h'] = 85.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 61 , ['x'] = 1201.87 , ['y'] = 2707.60 , ['z'] = 38.22 , ['h'] = 85.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 62 , ['x'] = -3168.76 , ['y'] = 1044.80 , ['z'] = 20.86 , ['h'] = 65.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 63 , ['x'] = -3169.46 , ['y'] = 1043.22 , ['z'] = 20.86 , ['h'] = 65.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 64 , ['x'] = -3170.17 , ['y'] = 1041.60 , ['z'] = 20.86 , ['h'] = 65.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 65 , ['x'] = -1101.80 , ['y'] = 2712.10 , ['z'] = 19.10 , ['h'] = 216.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 66 , ['x'] = -1097.90 , ['y'] = 2714.40 , ['z'] = 19.10 , ['h'] = 125.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 67 , ['x'] = -1095.82 , ['y'] = 2712.08 , ['z'] = 19.10 , ['h'] = 125.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 68 , ['x'] = -821.91 , ['y'] = -183.32 , ['z'] = 37.56 , ['h'] = 213.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 69 , ['x'] = 134.39 , ['y'] = -1707.83 , ['z'] = 29.29 , ['h'] = 136.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 70 , ['x'] = -1284.26 , ['y'] = -1115.05 , ['z'] = 6.99 , ['h'] = 89.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 71 , ['x'] = 1930.56 , ['y'] = 3727.93 , ['z'] = 32.84 , ['h'] = 205.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 72 , ['x'] = 1211.52 , ['y'] = -470.31 , ['z'] = 66.20 , ['h'] = 72.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 73 , ['x'] = -30.42 , ['y'] = -151.77 , ['z'] = 57.07 , ['h'] = 336.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
	{ ['id'] = 74 , ['x'] = -277.76 , ['y'] = 6230.73 , ['z'] = 31.69 , ['h'] = 38.0, ['tempo'] = 45, ['anim1'] = "oddjobs@shop_robbery@rob_till", ['anim2'] = "loop", ['minPolicia'] = 3  },
-- CAIXA ELETRONICO (ALTERADO NUMERO DE PM DE [5] PARA [2])
	{ ['id'] = 75, ['x'] = 119.10, ['y'] = -883.70, ['z'] = 31.12, ['h'] = 71.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2 },
	{ ['id'] = 76, ['x'] = -1315.80, ['y'] = -834.76, ['z'] = 16.96, ['h'] = 305.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 77, ['x'] = 285.44, ['y'] = 143.38, ['z'] = 104.17, ['h'] = 159.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 78, ['x'] = 1138.23, ['y'] = -468.89, ['z'] = 66.73, ['h'] = 74.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 79, ['x'] = 1077.70, ['y'] = -776.54, ['z'] = 58.24, ['h'] = 182.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 80, ['x'] = -710.03, ['y'] = -818.90, ['z'] = 23.72, ['h'] = 0.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 81, ['x'] = -821.63, ['y'] = -1081.89, ['z'] = 11.13, ['h'] = 31.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 82, ['x'] = -1409.75, ['y'] = -100.44, ['z'] = 52.38, ['h'] = 107.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 83, ['x'] = -846.29, ['y'] = -341.28, ['z'] = 38.68, ['h'] = 116.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 84, ['x'] = -2072.36, ['y'] = -317.29, ['z'] = 13.31, ['h'] = 260.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 85, ['x'] = -526.64, ['y'] = -1222.97, ['z'] = 18.45, ['h'] = 153.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 86, ['x'] = -254.41, ['y'] = -692.46, ['z'] = 33.60, ['h'] = 159.0, ['tempo'] = 45, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
-- LOJINHA  (ALTERADO NUMERO DE PM DE [5] PARA [2])
	{ ['id'] = 87, ['x'] = -1220.75, ['y'] = -916.04, ['z'] = 11.32, ['h'] = 127.99, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 88, ['x'] = -3047.69921875, ['y'] = 585.67077636719, ['z'] = 7.9089298248291, ['h'] = 117.58, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
	{ ['id'] = 89, ['x'] = 378.24850463867, ['y'] = 333.4250793457, ['z'] = 103.56638336182, ['h'] = 28.99, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  },
	{ ['id'] = 90, ['x'] = -43.327404022217, ['y'] = -1748.3146972656, ['z'] = 29.420991897583, ['h'] = 39.09, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
	{ ['id'] = 91, ['x'] = 28.279426574707, ['y'] = -1339.1300048828, ['z'] = 29.497022628784, ['h'] = 358.87, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
	{ ['id'] = 92, ['x'] = 1126.8338623047, ['y'] = -980.15625, ['z'] = 45.415824890137, ['h'] = 12.50, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
	{ ['id'] = 93, ['x'] = 1159.4827880859, ['y'] = -314.01480102539, ['z'] = 69.205154418945, ['h'] = 66.21, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
	{ ['id'] = 94, ['x'] = 2549.2097167969, ['y'] = 384.82141113281, ['z'] = 108.62294769287, ['h'] = 89.48, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
	{ ['id'] = 95, ['x'] = 2672.8342285156, ['y'] = 3286.6599121094, ['z'] = 55.241134643555, ['h'] = 58.87, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
	{ ['id'] = 96, ['x'] = 1959.2348632813, ['y'] = 3748.9306640625, ['z'] = 32.343742370605, ['h'] = 26.04, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
	{ ['id'] = 97, ['x'] = 546.44409179688, ['y'] = 2662.7770996094, ['z'] = 42.156494140625, ['h'] = 190.19, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
	{ ['id'] = 98, ['x'] = 1707.6885986328, ['y'] = 4920.4155273438, ['z'] = 42.063636779785, ['h'] = 316.21, ['tempo'] = 240, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2   },
-- LOJA DE ARMAS

	{ ['id'] = 106, ['x'] = -437.40, ['y'] = 5988.66, ['z'] = 31.71, ['h'] = 222.36, ['tempo'] = 240, ['anim1'] = "WORLD_HUMAN_WELDING", ['anim2'] = nil, ['minPolicia'] = 2   },
	{ ['id'] = 99, ['x'] = 827.38, ['y'] = -2152.21, ['z'] = 29.61, ['h'] = 267.67, ['tempo'] = 240, ['anim1'] = "WORLD_HUMAN_WELDING", ['anim2'] = nil, ['minPolicia'] = 2   },
-- JOALHERIA  (ALTERADO NUMERO DE PM DE [5] PARA [4])
	{ ['id'] = 100, ['x'] = -625.73, ['y'] = -237.79, ['z'] = 38.05, ['h'] = 224.77, ['tempo'] = 10, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 3  },
	{ ['id'] = 101, ['x'] = -626.72, ['y'] = -238.52, ['z'] = 38.05, ['h'] = 218.37, ['tempo'] = 10, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 3  },
	{ ['id'] = 102, ['x'] = -628.13, ['y'] = -233.92, ['z'] = 38.05, ['h'] = 217.47, ['tempo'] = 10, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 3  },
	{ ['id'] = 103, ['x'] = -626.93, ['y'] = -233.05, ['z'] = 38.05, ['h'] = 213.90, ['tempo'] = 10, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 3  },
	{ ['id'] = 104, ['x'] = -625.74, ['y'] = -234.66, ['z'] = 38.05, ['h'] = 29.31, ['tempo'] = 10, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 3  },
	{ ['id'] = 105, ['x'] = -626.77, ['y'] = -235.41, ['z'] = 38.05, ['h'] = 32.36, ['tempo'] = 10, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 3  },
-- BANCO  (ALTERADO NUMERO DE PM DE [5] PARA [5])
	{ ['id'] = 107, ['x'] = -103.46, ['y'] = 6477.95, ['z'] = 31.62, ['h'] = 327.40, ['tempo'] = 720, ['anim1'] = "WORLD_HUMAN_WELDING", ['anim2'] = nil, ['minPolicia'] = 5  },

-- Cluckin Bells
--	 { ['id'] = 108, ['x'] = -516.78, ['y'] = -698.60, ['z'] = 33.16, ['h'] = 10.42, ['tempo'] = 400, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 4  },
-- Niobio
	{ ['id'] = 109, ['x'] = 3559.63, ['y'] = 3672.22, ['z'] = 28.12, ['h'] = 0.93, ['tempo'] = 800, ['anim1'] = "anim@heists@ornate_bank@grab_cash_heels", ['anim2'] = "grab", ['minPolicia'] = 2  }, -- 3559.63,3672.22,28.12

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTEIRO DO ROUBOf
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local nichsch = 1000
		for _,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.2 and not andamento then
				nichsch = 5
				drawTxt("PRESSIONE ~b~[F]~w~ PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,251) and not IsPedInAnyVehicle(ped) then
					func.checkRobbery(v.id,v.x,v.y,v.z,v.h,v.tempo,v.anim1,v.anim2,v.minPolicia)
				end
			end
		end
		Citizen.Wait(nichsch)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Roubo:iniciando")
AddEventHandler("Roubo:iniciando",function(head,x,y,z,tempo)
	segundos = tempo
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local nichsch = 1000
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				nichsch = 5
				andamento = false
				ClearPedTasks(PlayerPedId())
			end 
		end
		Citizen.Wait(nichsch)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOQUEAR TECLAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if andamento then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,21,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,246,true)
			DisableControlAction(0,303,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,104,true)
			DisableControlAction(0,168,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

Citizen.CreateThread(function()
	if true then
		for k, v in ipairs(locais) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)

			SetBlipSprite(blip, 277)
			SetBlipScale(blip, 0.3)
			SetBlipColour(blip, 1)
			SetBlipDisplay(blip, 4)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Local Roubavel")
			EndTextCommandSetBlipName(blip)
		end
	end
end)

