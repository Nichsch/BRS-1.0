local cfg = {}

local surgery_male = { model = "mp_m_freemode_01" }
local surgery_female = { model = "mp_f_freemode_01" }

-----------------------------------------------------------------
local pm_male1 = { model = "mp_m_freemode_01" }
local pm_male2 = { model = "mp_m_freemode_01" }
local pm_fem1 = { model = "mp_f_freemode_01" }
local pm_fem2 = { model = "mp_f_freemode_01" }

local pf1_male = { model = "mp_m_freemode_01" }
local pf2_male = { model = "mp_m_freemode_01" }
local pf3_male = { model = "mp_m_freemode_01" }
local pf4_male = { model = "mp_m_freemode_01" }

local pf1_fem = { model = "mp_f_freemode_01" }
local pf2_fem = { model = "mp_f_freemode_01" }
local pf3_fem = { model = "mp_f_freemode_01" }
local pf1_male = { model = "mp_m_freemode_01" }
local pf2_male = { model = "mp_m_freemode_01" }

pf1_fem [3] = {53,1}
pf1_fem [4] = {27,1}
pf1_fem [5] = {0,0}
pf1_fem [6] = {9,1}
pf1_fem [7] = {95,1}
pf1_fem [8] = {152,1}
pf1_fem [9] = {0,2}
pf1_fem [10] = {0,2}
pf1_fem [11] = {262,1}
pf1_fem ["p0"] = {-1,0}
pf1_fem ["p6"] = {-1,0}

pf1_male [3] = {22,1}
pf1_male [4] = {87,1}
pf1_male [5] = {0,0}
pf1_male [6] = {24,2}
pf1_male [7] = {4,1}
pf1_male [8] = {130,1}
pf1_male [9] = {16,1}
pf1_male [10] = {0,2}
pf1_male [11] = {221,1}
pf1_male ["p0"] = {-1,0}
pf1_male ["p6"] = {5,0}

pf2_fem [3] = {49,1}
pf2_fem [4] = {90,1}
pf2_fem [5] = {0,0}
pf2_fem [6] = {25,1}
pf2_fem [7] = {95,1}
pf2_fem [8] = {160,1}
pf2_fem [9] = {18,1}
pf2_fem [10] = {0,2}
pf2_fem [11] = {231,1}
pf2_fem ["p0"] = {-1,0}
pf2_fem ["p6"] = {-1,0}

pf2_male [3] = {22,1}
pf2_male [4] = {33,1}
pf2_male [5] = {0,0}
pf2_male [6] = {24,2}
pf2_male [7] = {0,1}
pf2_male [8] = {130,1}
pf2_male [9] = {4,1}
pf2_male [10] = {0,2}
pf2_male [11] = {139,1}
pf2_male ["p0"] = {-1,0}
pf2_male ["p6"] = {5,0}

pf3_fem [3] = {51,1}
pf3_fem [4] = {32,1}
pf3_fem [5] = {0,0}
pf3_fem [6] = {25,1}
pf3_fem [7] = {95,1}
pf3_fem [8] = {160,1}
pf3_fem [9] = {6,1}
pf3_fem [10] = {0,2}
pf3_fem [11] = {43,1}
pf3_fem ["p0"] = {-1,0}
pf3_fem ["p6"] = {-1,0}
------------------------------------------------------POLICIA--- PMESP---------------------------------------------------

pm_male1[3] = {21,0}
pm_male1[4] = {31,0}
pm_male1[5] = {0,0}
pm_male1[6] = {24,0}
pm_male1[7] = {1,0}
pm_male1[8] = {129,0}
pm_male1[9] = {7,0} 
pm_male1[10] = {0,0}
pm_male1[11] = {93,0}
pm_male1["p0"] = {10,0}
pm_male1["p6"] = {-1,0}

pm_male2[1] = {52,2}
pm_male2[3] = {20,0}
pm_male2[4] = {31,0}
pm_male2[5] = {0,0}
pm_male2[6] = {24,0}
pm_male2[7] = {1,0}
pm_male2[8] = {129,0}
pm_male2[9] = {7,0}
pm_male2[10] = {0,0}
pm_male2[11] = {98,0}
pm_male2["p0"] = {48,0}
pm_male2["p6"] = {-1,0}

pm_fem1[3] = {20,0}
pm_fem1[4] = {30,0}
pm_fem1[5] = {0,0}
pm_fem1[6] = {24,0}
pm_fem1[7] = {1,0}
pm_fem1[8] = {159,0}
pm_fem1[9] = {7,0}
pm_fem1[10] = {0,0}
pm_fem1[11] = {33,0}
pm_fem1["p0"] = {10,0}
pm_fem1["p6"] = {-1,0}

pm_fem2[4] = {30,0}
pm_fem2[3] = {23,0}
pm_fem2[5] = {0,0}
pm_fem2[6] = {24,0} 
pm_fem2[7] = {1,0}
pm_fem2[8] = {159,0}
pm_fem2[9] = {7,0}
pm_fem2[10] = {0,0}
pm_fem2[11] = {31,0} 
pm_fem2["p0"] = {10,0}
pm_fem2["p6"] = {-1,0}

------------------------------------------------------POLICIA--- FEDERAL ---------------------------------------------------
-- pf1 Agente Masculino1
pf1_male[1] = {0,0} -- mascara / texture
pf1_male[3] = {1,0} -- upper body gloves / texture
pf1_male[4] = {59,9} -- leg / texture
pf1_male[6] = {24,0} -- shoes
pf1_male[7] = {1,0} --  Gravatas / texture
pf1_male[8] = {129,0} -- undershit - camiseta / texture
pf1_male[9] = {4,3} -- colete / texture
pf1_male[10] = {0,0} -- tops - jaqueta / texture
pf1_male[11] = {51,0} -- tops - jaqueta / texture
pf1_male["p0"] = {28,1} -- acessorio / texture
--pf1_male["p1"] = {17,9} -- oculos / texture

-- PF Invistigador Masculino1
pf2_male[1] = {0,0} -- mascara / texture
pf2_male[3] = {1,0} -- upper body gloves / texture
pf2_male[4] = {59,9} -- leg / texture
pf2_male[6] = {24,0} -- shoes
pf2_male[7] = {1,0} --  Gravatas / texture
pf2_male[8] = {21,0} -- undershit - camiseta / texture
pf2_male[9] = {0,0} -- colete / texture
pf2_male[10] = {0,0} -- tops - jaqueta / texture
pf2_male[11] = {35,0} -- tops - jaqueta / texture
pf2_male["p0"] = {28,1} -- acessorio / texture
--pf2_male["p1"] = {17,9} -- oculos / texture

-- PF Delegado Masculino1
pf3_male[1] = {0,0} -- mascara / texture
pf3_male[3] = {1,0} -- upper body gloves / texture
pf3_male[4] = {59,9} -- leg / texture
pf3_male[6] = {24,0} -- shoes
pf3_male[7] = {1,0} --  Gravatas / texture
pf4_male[8] = {60,0} -- undershit - camiseta / texture
pf3_male[9] = {0,0} -- colete / texture
pf3_male[10] = {0,0} -- tops - jaqueta / texture
pf3_male[11] = {36,0} -- tops - jaqueta / texture
pf3_male["p0"] = {8,0} -- acessorio / texture
pf3_male["p1"] = {8,5} -- oculos / texture    
       
-- PF Masculino1
pf4_male[1] = {126,9} -- mascara / texture
pf4_male[3] = {0,0} -- upper body gloves / texture
pf4_male[4] = {25,0} -- leg / texture
pf4_male[6] = {27,0} -- shoes
pf4_male[7] = {0,0} --  Gravatas / texture
pf4_male[8] = {23,1} -- undershit - camiseta / texture
pf4_male[9] = {0,0} -- colete / texture
pf4_male[10] = {23,1} -- tops - jaqueta / texture
pf4_male[11] = {35,1} -- tops - jaqueta / texture
pf4_male["p0"] = {59,1} -- acessorio / texture
pf4_male["p1"] = {17,9} -- oculos / texture

--  POLICIA RODOVIARIA FEDERAL

for i=0,19 do
	surgery_female[i] = { 0,0 }
	surgery_male[i] = { 0,0 }
end

cfg.cloakroom_types = {
  ["Policia"] = {
    _config = { permissions = {"perm.policia" } },
      ["1. (M) Farda 1"] = pm_male1,
      ["2. (M) Farda 2"] = pm_male2,
      ["3. (M) Farda 3"] = pm_male3,
      ["4. (F) Farda 1"] = pm_fem1,
      ["5. (F) Farda 2"] = pm_fem2,
    },
    ["Policia Civil"] = { 
    _config = { permissions = {"perm.civil" } },
    ["Operacional"] = {
    [1] = {17,12,1},
    [2] = {27,0,0},
    [3] = {17,0,1},
    [4] = {31,3,1},
    [5] = {0,0,2},
    [6] = {24,0,1},
    [7] = {1,0,1},
    [8] = {15,0,1},
    [9] = {16,2,1},
    [10] = {0,0,2},
    [11] = {220,9,1},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
    },
    ["ptr"] = {
    [1] = {17,0,1},
    [2] = {21,0,0},
    [3] = {37,0,1},
    [4] = {31,0,1},
    [5] = {0,0,2},
    [6] = {24,0,1},
    [7] = {125,0,1},
    [8] = {122,0,1},
    [9] = {4,1,1},
    [10] = {0,0,2},
    [11] = {26,0,1},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
    },
  },

  --[[["BOPE"] = { 
  _config = { permissions = {"perm.policia" } },
  ["BOPE 1 Masculino"] = {
		[1] = {35,0,2},
		[3] = {17,0,0},
		[4] = {33,0,2},
		[5] = {0,0,0},
		[6] = {25,0,0},
		[7] = {1,0,0},
		[8] = {15,0,0},
		[9] = {16,0,0},
		[10] = {0,0,0},
		[11] = {49,0,0},
		["p0"] = {39,0,0},
		["p1"] = {25,4,0},
		["p6"] = {-1,0},
	},
	["BOPE 2 Masculino"] = {
		[3] = {17,0,0},
		[4] = {33,0,2},
		[5] = {0,0,0},
		[6] = {25,0,0},
		[7] = {1,0,0},
		[8] = {15,0,0},
		[9] = {16,0,0},
		[10] = {0,0,0},
		[11] = {49,0,0},
		["p0"] = {28,1,0},
		["p6"] = {-1,0},
	},
	["BOPE 1 Feminino"] = {
		[1] = {35,0,2},
		[3] = {18,0,0},
		[4] = {61,9,2},
		[5] = {0,0,0},
		[6] = {25,0,0},
		[8] = {3,0,0},
		[9] = {18,0,0},
		[10] = {0,0,0},
		[11] = {42,0,0},
		["p0"] = {38,0,0},
		["p1"] = {27,4,0},
		["p6"] = {-1,0},
	},
	["BOPE 2 Feminino"] = {
		[3] = {18,0,0},
		[4] = {61,9,2},
		[5] = {0,0,0},
		[6] = {25,0,0},
		[7] = {1,0,0},
		[8] = {3,0,0},
		[9] = {18,0,0},
		[10] = {0,0,0},
		[11] = {42,0,0},
		["p0"] = {28,1,0},
		["p6"] = {-1,0},
    },
  },     ]]

  ["Policia Rodoviaria Federal"] = { 
    _config = { permissions = {"perm.prf" } },
    ["Operacional"] = {
    [1] = {0,0,2},
    [2] = {15,0,0},
    [3] = {26,0,1},
    [4] = {86,5,1},
    [5] = {0,0,2},
    [6] = {25,0,1},
    [7] = {1,0,1},
    [8] = {25,0,1},
    [9] = {7,0,1},
    [10] = {-1,0,2},
    [11] = {220,5,1},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
    },
    ["ptr"] = {
    [1] = {0,0,2},
    [2] = {15,0,0},
    [3] = {26,0,1},
    [4] = {47,0,1},
    [5] = {0,0,1},
    [6] = {25,0,1},
    [7] = {1,0,1},
    [8] = {15,0,1},
    [9] = {7,1,1},
    [10] = {-1,0,2},
    [11] = {26,0,1},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
  },
    ["1.(PC-F) Farda 3"] = pf1_fem,
    ["2.(PC-F) Farda 4"] = pf2_fem,
    ["3.(PC-F) Farda 4"] = pf3_fem,
},
  
["C.E.T"] = { 
  _config = { permissions = {"perm.cet" } },
      ["Super e Diretor"] = {
      [1] = {0,0,2},
      [3] = {48,0,1},
      [4] = {25,0,1},
      [6] = {25,0,1},
      [7] = {0,0,2},
      [8] = {58,0,1},
      [9] = {0,0,2},
      [11] = {26,0,2},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
    },
    ["Guarda de Transito"] = {
      [1] = {0,0,2},
      [3] = {19,0,2},
      [4] = {31,0,2},
      [6] = {25,0,2},
      [7] = {0,0,2},
      [8] = {59,1,2},
      [9] = {0,0,2},
      [11] = {93,0,2},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
    },
	["Guarda Feminina"] = {
		[1] = {0,0,2},
		[3] = {44,0,2},
		[4] = {54,2,2},
		[6] = {25,0,2},
		[7] = {0,0,2},
		[8] = {36,0,2},
		[9] = {0,0,2},
		[11] = {141,2,2},
		["p0"] = {-1,0},
		["p6"] = {-1,0},
	},
    ["Guarda"] = {
      [1] = {0,0,2},
      [3] = {19,0,2},
      [4] = {31,0,2},
      [6] = {25,0,2},
      [7] = {0,0,2},
      [8] = {59,1,2},
      [9] = {0,0,2},
      [11] = {273,1,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
    },
  },
 
["HOSPITAL"] = {
    _config = { permissions = {"perm.unizk" } },
    ["Socorrista (M) "] = {
      [3] = {74,0,1},
      [4] = {20,0,1},
      [6] = {20,3,1},
      [7] = {126,0,1},
      [8] = {15,0,2},
      [9] = {0,1,2},
      [11] = {250,1,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
  },
    ["Socorrista (F) "] = {
      [3] = {85,0,1},
      [4] = {23,0,1},
      [6] = {10,1,1},
      [7] = {0,0,0},
      [8] = {3,0,2},
      [9] = {0,1,2},
      [11] = {258,1,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
  },
    ["Psicólogo (M) "] = {
      [3] = {80,0,1},
      [4] = {20,0,1},
      [6] = {20,3,1},
      [7] = {126,0,1},
      [8] = {10,0,1},
      [9] = {0,1,2},
      [11] = {142,0,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
  },
    ["Psicólogo (F) "] = {
      [3] = {94,0,1},
      [4] = {23,0,1},
      [6] = {10,1,1},
      [7] = {96,0,1},
      [8] = {38,0,1},
      [9] = {0,1,2},
      [11] = {139,0,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
  },
    ["Enfermeiro (M) "] = {
      [3] = {92,0,1},
      [4] = {20,0,1},
      [6] = {20,3,1},
      [7] = {126,0,1},
      [8] = {15,0,2},
      [9] = {0,1,2},
      [11] = {26,0,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
  },
    ["Enfermeiro (F) "] = {
      [3] = {85,0,1},
      [4] = {23,0,1},
      [6] = {10,1,1},
      [7] = {0,0,0},
      [8] = {3,0,1},
      [9] = {0,1,2},
      [11] = {27,5,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
  },
    ["Médica (F) "] = {
      [1] = {0,0,1},
      [3] = {88,0,1},
      [4] = {23,0,1},
      [6] = {10,1,1},
      [7] = {96,0,1},
      [8] = {39,12,1},
      [9] = {0,1,2},
      [11] = {57,7,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
  },
    ["Médico (M) "] = {
      [4] = {20,0,1},
      [6] = {20,3,1},
      [7] = {126,0,1},
      [8] = {96,15,1},
      [9] = {0,1,2},
      [11] = {29,7,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
  },
  ["Direção (F) "] = {
    [3] = {86,0,1},
    [4] = {52,2,1},
    [6] = {81,8,1},
    [7] = {96,0,1},
    [8] = {40,2,1},
    [9] = {0,1,2},
    [11] = {57,0,1},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
    },
  },

["Medico Cirurgião"] = {
    _config = { permissions = {"perm.unizk" } },
    ["Cirurgia (M) "] = {
      [1] = {0,0,2},
      [3] = {93,0,1},
      [4] = {20,0,1},
      [6] = {7,0,1},
      [7] = {0,0,1},
      [8] = {25,4,1},
      [9] = {0,1,2},
      [11] = {192,0,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
  },
    ["Cirurgia (F) "] = {
      [1] = {0,0,2},
      [3] = {100,0,1},
      [4] = {23,0,1},
      [6] = {2,4,1},
      [7] = {96,0,1},
      [8] = {78,0,1},
      [9] = {0,1,2},
      [11] = {194,0,1},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
    },
  },

  ["LSCustom"] = {
    _config = { permissions = {"perm.mecanico" } },
    ["Farda (M) "] = {
      [1] = {0,0,2},
      [3] = {23,0,1},
      [4] = {89,20,2},
      [6] = {26,3,1},
      [7] = {0,0,2},
      [8] = {89,20,1},
      [9] = {0,1,2},
      [11] = {237,8,2},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
    },

    ["Farda (F) "] = {
      [1] = {0,0,2},
      [2] = {45,0,0},
      [3] = {32,0,2},
      [4] = {92,20,2},
      [5] = {43,0,2},
      [6] = {3,4,2},
      [7] = {0,0,1},
      [8] = {159,0,2},
      [9] = {0,0,2},
      [10] = {0,0,2},
      [11] = {16,0,2},
      ["p0"] = {-1,0},
      ["p6"] = {5,0},
      },
 },

  ["Bennys"] = {
    _config = { permissions = {"perm.mecanico" } },
    ["Farda (M) "] = {
      [1] = {0,0,2},
      [3] = {19,0,1},
      [4] = {33,0,2},
      [6] = {25,0,1},
      [7] = {0,0,2},
      [8] = {90,0,1},
      [9] = {0,1,2},
      [11] = {241,2,2},
      ["p0"] = {-1,0},
      ["p6"] = {-1,0},
    },

    ["Farda (F) "] = {
     [1] = {0,0,2},
      [3] = {31,0,1},
      [4] = {32,0,1},
      [6] = {25,0,1},
      [7] = {0,0,1},
      [8] = {2,0,1},
      [9] = {0,0,2},
      [11] = {281,1,2},
      ["p0"] = {-1,0},
      ["p6"] = {5,0},
    },
 },

["Yakuza"] = {
  _config = { permissions = {"perm.yakuza" } },

  ["Masculino Yakuza"] = {
    [1] = {0,0,2},
    [3] = {45,0,0},
    [4] = {10,0,1},
    [6] = {10,0,1},
    [8] = {31,0,1},
    [9] = {0,0,2},
    [11] = {108,5,1},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
  },

  ["Feminina Yakuza"] = {
  [1] = {0,0,2},
  [3] = {68,0,1},
  [4] = {15,0,1},
  [6] = {0,0,1},
  [8] = {0,0,0},
  [9] = {0,1,2},
  [11] = {212,4,1},
  ["p0"] = {-1,0},
  ["p6"] = {-1,0},
  },

},

["Cirurgia"] = {

  ["Feminino"] = {
    [1] = {0,0,2},
    [3] = {15,0,2},
    [4] = {15,3,1},
    [6] = {35,0,2},
    [8] = {3,0,2},
    [9] = {0,1,2},
    [11] = {15,3,1},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
  },

  ["Masculino"] = {
  [1] = {0,0,2},
  [3] = {15,0,2},
  [4] = {61,0,2},
  [6] = {34,0,2},
  [8] = {15,0,2},
  [9] = {0,1,2},
  [11] = {252,0,2},
  ["p0"] = {-1,0},
  ["p6"] = {-1,0},
  },
},

["Luta"] = {

  ["Feminino"] = {
    [1] = {0,0,2},
    [3] = {15,0,2},
    [4] = {10,15,1},
    [6] = {35,0,2},
    [8] = {3,0,2},
    [9] = {0,1,2},
    [10] = {32,0,1},
    [11] = {11,10,1},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
  },

  ["Masculino"] = {
  [1] = {0,0,2},
  [3] = {15,0,2},
  [4] = {42,4,2},
  [6] = {34,0,2},
  [8] = {15,0,2},
  [9] = {0,1,2},
  [10] = {59,0,1},
  [11] = {252,0,2},
  ["p0"] = {-1,0},
  ["p6"] = {-1,0},
  },
},

["IRA"] = {
  _config = { permissions = {"perm.bratva" } },

  ["Masculina IRA"] = {
    [1] = {0,0,2},
    [3] = {31,0,0},
    [4] = {86,13,2},
    [6] = {25,0,2},
    [8] = {15,0,2},
    [9] = {11,1,2},
    [11] = {220,13,2},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
  },
},

["Advocacia"] = {
  _config = { permissions = {"perm.advogado" } },

  ["Advogado "] = {
  [1] = {0,0,2},
  [3] = {12,0,2},
  [4] = {10,0,2},
  [6] = {20,7,2},
  [7] = {25,15,2},
  [8] = {33,0,2},
  [9] = {0,0,2},
  [11] = {29,0,2},
  ["p0"] = {-1,0},
  ["p6"] = {-1,0},
  },

  ["Advogada "] = {
  [1] = {0,0,2},
  [3] = {1,0,2},
  [4] = {6,0,2},
  [6] = {0,0,2},
  [7] = {13,0,2},
  [8] = {38,0,2},
  [9] = {0,0,2},
  [11] = {58,0,2},
  ["p0"] = {-1,0},
  ["p6"] = {-1,0},
  },
},

["Moto Clube"] = {
  _config = { permissions = {"perm.motoclube" } },
  ["Farda (Feminina)"] = {
  [1] = {0,0,0},
  [3] = {25,0,2},
  [4] = {78,0,2},
  [6] = {25,0,2},
  [7] = {0,0,0},
  [8] = {14,0,2},
  [9] = {0,0,0},
  [11] = {158,2,2},
  ["p0"] = {-1,1},
  ["p6"] = {-1,0},
  },
  ["Farda (Masculina)"] = {
    [1] = {0,0,2},
    [3] = {21,0,2},
    [4] = {31,0,2},
    [6] = {25,0,2},
    [7] = {0,0,2},
    [8] = {2,2,2},
    [9] = {0,0,2},
    [11] = {162,0,2},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
  },
},

  ["Salva vidas"] = {
    _config = { permissions = {"perm.svidas" } },
    ["Farda (Masculina)"] = {
      [1] = {0,0,2},
      [3] = {5,0,2},
      [4] = {18,3,2},
      [6] = {5,0,2},
      [7] = {0,0,0},
      [8] = {15,0,2},
      [9] = {0,1,2},
      [11] = {237,7,2},
      ["p0"] = {76,5},
      ["p6"] = {-1,0},
    },
  },

  ["DriftKing"] = {
    _config = { permissions = {"perm.driftking" } },
    ["DK Mecânico"] = {
    [1] = {0,0,2},
    [3] = {41,0,2},
    [4] = {5,5,2},
    [6] = {54,0,2},
    [7] = {72,0,2},
    [8] = {15,0,2},
    [9] = {0,0,2},
    [11] = {22,0,2},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0}, 
  },
    ["DK Mecânica"] = {
    [1] = {0,0,2},
    [3] = {29,0,2},
    [4] = {107,4,2},
    [6] = {25,0,2},
    [7] = {88,2,2},
    [8] = {22,0,2},
    [9] = {0,0,2},
    [11] = {117,0,2},
    ["p0"] = {-1,0},
    ["p6"] = {-1,0},
      },
    },
}

cfg.cloakrooms = {
  {"Tequila-la", -566.16271972656,279.96322631836,82.975242614746},
  {"DriftKing", 1171.3449707031,2637.5979003906,37.84440612793},
  {"C.E.T", -1573.1912841797,-585.70831298828,105.79508972168},
  {"Policia", 458.86499023438,-992.59185791016,30.689596176147},	
  --{"BOPE", 458.86499023438,-992.59185791016,30.689596176147},	
  {"Policia Federal", 450.00155639648,-993.14709472656,30.68931388855},
  {"Yakuza", -887.10528564453,-1440.1391601563,7.5253958702087},
  {"IRA", 1394.6911621094,1157.1981201172,114.33354949951},
  {"HOSPITAL", 314.01095581055,-602.916015625,43.29275894165},
  {"Moto Clube", 992.49749755859,-135.36936950684,74.061347961426},
  {"Bennys", -206.60548400879,-1331.3698730469,34.89448928833},
  {"LSCustom", -347.16253662109,-133.57427978516,39.009620666504},
  {"Cirurgia", 306.35739135742,-569.41302490234,43.281620025635},
  {"Medico Cirurgião", 303.09362792969,-578.4912109375,43.301914215088},
  {"Luta",-565.89880371094,288.27642822266,91.797821044922},
  {"Los Santos Custom", -347.10174560547,-133.53363037109,39.009624481201},
  {"Advocacia", -132.63858032227,-632.93597412109,168.82051086426},
  {"Salva vidas", -1491.6424560547,-1015.8276977539,6.2976584434509},
  {"Sexo", 322.03253173828,-590.36541748047,43.283985137939},
  {"Policia Rodoviaria Federal", -449.09,6015.53,31.72}, 
  {"Policia Civil", 120.81,-725.23,242.16},
}

return cfg