
local cfg = {}

cfg.services = {
  ["Policia"] = {
    blipid = 161,
    blipcolor = 0,
    alert_time = 120,
    alert_permission = "perm.policia",
    answer_notify = "^2A Policia esta a caminho."
  },
  ["Policia Civil"] = {
    blipid = 161,
    blipcolor = 0,
    alert_time = 120,
    alert_permission = "perm.civil",
    answer_notify = "^2A Policia Civil esta a caminho."
  },
  ["Hospital"] = {
    blipid = 161,
    blipcolor = 0,
    alert_time = 120,
    alert_permission = "perm.unizk",
    answer_notify = "^2o Socorro esta a caminho."
  },
  ["Mecanico"] = {
    blipid = 161,
    blipcolor = 0, 
    alert_time = 120,
    alert_permission = "perm.mecanico",
    answer_notify = "^2O Mecanico esta a caminho."
  },
  ["Uber"] = {
    blipid = 161,
    blipcolor = 0,
    alert_time = 120,
    alert_permission = "perm.uber",
    answer_notify = "^2O Uber esta a caminho."
  },
  ["Advogado"] = {
    blipid = 161,
    blipcolor = 0,
    alert_time = 120,
    alert_permission = "perm.advogado",
    answer_notify = "^2O(a) Advogado esta a caminho."
  },
  ["Cet"] = {
    blipid = 161,
    blipcolor = 0,
    alert_time = 120,
    alert_permission = "perm.cet",
    answer_notify = "^2A C.E.T esta a caminho."
  },
  ["Weazel"] = {
    blipid = 161,
    blipcolor = 0,
    alert_time = 120,
    alert_permission = "perm.news",
    answer_notify = "^2A A Weazel News esta a caminho."
  },
} 

return cfg

