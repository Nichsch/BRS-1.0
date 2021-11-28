local cfg = {}

cfg.static_menu_types = {
  
  ["hospital_menu"] = {
    title = "Hospital",
    permissions = {"perm.unizk"}
  },
  ["hospital_tratamento"] = {
    title = "Hospital"
  },
  ["police_weapons"] = {
    title = "Policia",
    permissions = {"perm.policia"}
  },
  ["civil_weapons"] = {
    title = "Policia",
    permissions = {"perm.civil"}
  },
  ["prf_weapons"] = {
    title = "policia",
    permissions = {"perm.prf"}
  },
  ["cet_arsenal"] = {
    title = "C.E.T",
    permissions = {"perm.cet"}
  },
  ["sistema_criminal"] = {
    title = "Policia",
    permissions = {"perm.policia.civil"}
  },
  ["pegar_cnh"] = {
    title = "Detran"
  },
  ["lavagem_dinheiro"] = {
    title = "Lavagem"
  },
  ["lavagem_interior"] = {
    title = "Lavagem"
  },
  ["loja_pescaria"] = {
    permissions = {"perm.pescador"},
    title = "Loja Pescaria"
  },
  ["advogado_elevador"] = {
    title = "Elevador"
  },
  ["cet_entrar"] = {
    title = "C.E.T"
  },
  ["elevador_hospital"] = {
    title = "Elevador"
  },
  ["elevador_iaa"] = {
    title = "Elevador",
    permissions = {"ticket.permissao"}
  },
  ["entrada_svidas"] = {
    title = "Salva Vidas"
  },
  ["pool_vip"] = {
    title = "Piscininha amor"
  },
  ["entrada_bunker"] = {
    title = "Bunker",
    permissions = {"perm.produzir.armas"},
  }, 
  ["vender_joias"] = {
    title = "Vender Joias",
    permissions = {"perm.peaky"},
  },
  ["psicologo"] = {
    title = "Documento",
    permissions = {"perm.unizk"},
  },  
  ["judi"] = {
    title = "Aprovação",
    permissions = {"perm.juiz"},
  },  
  ["mec_equipamentos"] = {
    title = "Mecanico",
    permissions = {"perm.mecanico"},
  }, 
  ["ls_equipamentos"] = {
    title = "Mecanico",
    permissions = {"perm.mecanico"},
  }, 
  ["elevador_civil"] = {
    title = "Elevador Civil", 
  },
}

cfg.static_menus = {
  {"mec_equipamentos", -199.49468994141,-1319.8765869141,31.089418411255}, -- #S4NDROLINDO
  {"ls_equipamentos", -345.34027099609,-124.95669555664,39.009658813477}, 
  {"vender_joias", -60.12,-2518.3,7.41},
  {"garagem_civil", 146.57,-680.12,33.34},
  {"elevador_civil", 135.99,-761.76,242.16},
  {"elevador_civil", 145.73,-682.31,33.34},
  {"elevador_civil", 138.94,-762.71,45.76},
  {"terreo_civil", 138.87,-762.84,45.76},
  {"psicologo", 343.69247436523,-597.49206542969,47.322212219238},
  {"advogado_elevador", -116.95,-604.57,36.28},
  {"advogado_elevador", -141.06,-620.94,168.8},
  {"lavagem_dinheiro", 1119.5521240234,-3197.6281738281,-40.39408493042},
  {"lavagem_interior", 1994.6408691406,3046.1403808594,47.21520614624},
  {"lavagem_interior", 1138.0798339844,-3198.9067382813,-39.665725708008},
  {"elevador_iaa", -468.36260986328,1129.2000732422,325.85565185547},
  {"elevador_iaa", 2155.4624023438,2920.9140625,-61.902454376221},
  {"elevador_iaa", 2060.3681640625,2992.8735351563,-72.702026367188},
  {"entrada_bunker", -389.07,4341.94,56.1},
  {"entrada_bunker", 903.16772460938,-3182.2419433594,-97.053619384766},
  {"pegar_cnh",240.99,-1379.23,33.74},
  {"judi", -125.93632507324,-641.77349853516,168.84033203125},
  {"pool_vip",-1396.8541259766,-1008.8393554688,24.704578399658 },
  {"pool_vip",-1398.8598632813,-986.23779296875,19.380460739136 },
  {"elevador_hospital", 335.87368774414,-580.26708984375,74.070457458496},
  {"elevador_hospital", 331.25726318359,-592.80493164063,28.901123046875},
  {"elevador_hospital", 331.5146484375,-592.38250732422,43.282001495361},
  {"elevador_hospital", 335.94528198242,-580.41668701172,48.24089050293},
  {"entrada_svidas", -1482.6533203125,-1029.9847412109,6.1390199661255},
  {"entrada_svidas", -1483.7506103516,-1028.9846191406,6.2976531982422},
  {"loja_pescaria",-1845.19,-1195.98,19.18},
  {"hospital_menu", 305.92352294922,-580.36016845703,43.281620025635},
  {"hospital_tratamento",308.07919311523,-595.42401123047,43.292755126953},
  {"police_weapons",461.38354492188,-981.16851806641,30.689605712891},
  {"civil_weapons", 127.36,-729.33,242.16},
  {"prf_weapons", -450.73,6011.22,31.72},
  {"sistema_criminal", 445.98104858398,-982.87255859375,35.931087493896},
  {"sistema_criminal", 445.24133300781,-974.53314208984,26.668548583984},
  {"cet_entrar", 259.53073120117,-1357.2003173828,30.551752090454},
  {"cet_entrar", -1569.6440429688,-568.54840087891,105.20006561279},
  {"cet_arsenal", -1585.3239746094,-566.54272460938,105.20013427734}
}

return cfg