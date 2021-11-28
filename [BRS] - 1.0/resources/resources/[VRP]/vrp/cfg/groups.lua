local cfg = {}
cfg.groups = {
	["admin"] = { _config = { gtype = "staff" }, "admin.permissao", "mqcu.permissao", "ticket.permissao", "player.spec", "player.blips", "player.noclip", "player.secret", "player.wall" },
	["moderador"] = { _config = { gtype = "staff" }, "moderador.permissao", "mqcu.permissao", "ticket.permissao", "player.spec", "player.blips", "player.noclip", "player.secret", "player.wall" },
	["ajudante"] = { _config = { gtype = "staff" }, "ajudante.permissao", "mqcu.permissao", "ticket.permissao", "player.spec", "player.blips", "player.noclip", "player.secret", "player.wall" },
-- EXP
	["admin [EXP]"] = { _config = { gtype = "staff" }, "admin.exp", "mqcu.permissao", "ticket.permissao", "player.spec", "player.blips", "player.noclip", "player.secret", "player.wall" },
	["moderador [EXP]"] = { _config = { gtype = "staff" }, "moderador.exp", "mqcu.permissao", "ticket.permissao", "player.spec", "player.blips", "player.noclip", "player.secret", "player.wall" },
	["ajudante [EXP]"] = { _config = { gtype = "staff" }, "ajudante.exp", "mqcu.permissao", "ticket.permissao", "player.spec", "player.blips", "player.noclip", "player.secret", "player.wall" },

	["user"] = { "perm.user"},
	["luna"] = { "perm.luna" },
	["thomas"] = { "perm.thomas" },
	["palhacin"] = { "perm.palhacin" },
	["lucas"] = { "perm.lucas" },
	["vinhedo"] = { "perm.vinhedo" },
	["iate"] = { "perm.iate" },
	["fla"] = { "perm.fla" },
	["flac"] = { "perm.flac" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
------------------------------------------------------------------------------------------------------------------------------------------------
	["Comandante [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Coronel [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Tenente Coronel [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Major [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Capitão [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Tenente [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Sargento [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Cabo [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Soldado [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Recruta [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia",  "perm.doors", "perm.policia.civil, perm.user"},
	["Força Tatica [POLICIA]"]  = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
	["Piloto [POLICIA]"] = { _config = { title = "Policia", gtype = "org" }, "perm.policia", "perm.doors", "perm.policia.civil, perm.user"},
-- PTR
	["Comandante [PTR]"] = { _config={ gtype = "org" }, "pagamento.comandante.policia", "perm.policia", "perm.doors", "perm.policia.civil", "perm.roubos", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Coronel [PTR]"] = { _config={ gtype = "org" },"pagamento.coronel.policia", "perm.policia", "perm.policia.civil", "perm.doors", "perm.roubos", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Tenente Coronel [PTR]"] = { _config={ gtype = "org"},"pagamento.tencoronel.policia", "perm.policia", "perm.policia.civil" , "perm.doors", "perm.roubos", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Major [PTR]"] = { _config={ gtype = "org" },"pagamento.major.policia", "perm.policia", "perm.policia.civil", "perm.roubos", "perm.doors", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Capitão [PTR]"] = { _config={ gtype = "org" },"pagamento.capitao.policia", "perm.policia", "perm.policia.civil", "perm.roubos", "perm.doors", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Tenente [PTR]"] = { _config={ gtype = "org" },"pagamento.tenente.policia", "perm.policia", "perm.policia.civil", "perm.roubos", "perm.doors", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Sargento [PTR]"] = { _config={ gtype = "org" },"pagamento.sargento.policia", "perm.policia", "perm.policia.civil", "perm.roubos", "perm.doors", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Cabo [PTR]"] = { _config={ gtype = "org" },"pagamento.cabo.policia", "perm.policia", "perm.policia.civil", "perm.roubos", "perm.doors", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Soldado [PTR]"] = { _config={ gtype = "org" },"pagamento.soldado.policia", "perm.policia", "perm.policia.civil", "perm.roubos", "perm.doors", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Recruta [PTR]"] = { _config={ gtype = "org" },"pagamento.recruta.policia", "perm.policia", "perm.policia.civil", "perm.roubos", "perm.doors", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Piloto [PTR]"] = { _config={ gtype = "org" },"pagamento.piloto.policia", "perm.policia", "perm.policia.civil", "perm.roubos", "perm.doors", "perm.policia.ptr", "perm.inventario", "perm.user"},
	["Força Tattica [PTR]"] = { _config={ gtype = "org" },"pagamento.recruta.policia", "perm.policia", "perm.policia.civil", "perm.roubos", "perm.doors", "perm.policia.ptr", "perm.inventario", "perm.user"},
	------------------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA RODOVIARIA FEDERAL TALKEY
------------------------------------------------------------------------------------------------------------------------------------------------
    ["Comandante [PRF]"] = { _config = { title = "Policia Rodoviaria Federal", gtype = "org" }, "perm.prf", "perm.doors", "perm.policia.rf, perm.user"},
	["Agente Especial [PRF]"] = { _config = { title = "Policia Rodoviaria Federal", gtype = "org" }, "perm.prf", "perm.doors", "perm.policia.rf, perm.user"},
	["Agente Especial 1 classe [PRF]"] = { _config = { title = "Policia Rodoviaria Federal", gtype = "org" }, "perm.prf", "perm.doors", "perm.policia.rf, perm.user"},
	["Agente Especial 2 classe[PRF]"] = { _config = { title = "Policia Rodoviaria Federal", gtype = "org" }, "perm.prf", "perm.doors", "perm.policia.rf, perm.user"},
	["Agente Especial 3 classe [PRF]"] = { _config = { title = "Policia Rodoviaria Federal", gtype = "org" }, "perm.prf", "perm.doors", "perm.policia.rf, perm.user"},
-- PTR
    ["Comandante [PRFPTR]"] = { _config={ gtype = "org" }, "pagamento.comandante.prf", "perm.prf", "perm.doors", "perm.prf", "perm.roubos", "perm.prf.ptr", "perm.inventario", "perm.user"},
	["Agente Especial [PRFPTR]"] = { _config={ gtype = "org" },"pagamento.agentees.prf", "perm.prf", "perm.policia.rf", "perm.doors", "perm.roubos", "perm.prf.ptr", "perm.inventario", "perm.user"},
	["Agente Especial 1 classe [PRFPTR]"] = { _config={ gtype = "org"},"pagamento.agentees1.prf", "perm.prf", "perm.policia.rf" , "perm.doors", "perm.roubos", "perm.prf.ptr", "perm.inventario", "perm.user"},
	["Agente Especial 2 classe [PRFPTR]"] = { _config={ gtype = "org" },"pagamento.agentees2.prf", "perm.prf", "perm.policia.rf", "perm.roubos", "perm.doors", "perm.prf.ptr", "perm.inventario", "perm.user"},
	["Agente Especial 3 classe [PRFPTR]"] = { _config={ gtype = "org" },"pagamento.agenteses3.prf", "perm.prf", "perm.policia.rf", "perm.roubos", "perm.doors", "perm.prf.ptr", "perm.inventario", "perm.user"},
------------------------------------------------------------------------------------------------------------------------------------------------
-- CIVIL
------------------------------------------------------------------------------------------------------------------------------------------------
	["Comandante [CIVIL]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.doors", "perm.policia.civil", "perm.user"},
	["Delegado [CIVIL]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.doors", "perm.policia.civil", "perm.user"},
	["Corregedor [CIVIL]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.doors", "perm.policia.civil", "perm.user"},
	["Investigador [CIVIL]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.doors", "perm.policia.civil", "perm.user"},
	["Operador [CIVIL]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.doors", "perm.policia.civil", "perm.user"},
	["Agente [CIVIL]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.doors", "perm.policia.civil", "perm.user"},
	["Escrivão [CIVIL]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.doors", "perm.policia.civil", "perm.user"},
	["Piloto [CIVIL]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.doors", "perm.policia.civil", "perm.user"},
-- PTR
	["Comandante [CPTR]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.policia.civil", "perm.doors", "perm.roubos", "pagamento.comandante.pcivil", "perm.civil.ptr", "perm.inventario", "perm.user" },
	["Delegado [CPTR]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.policia.civil", "perm.doors", "perm.roubos", "pagamento.delegado.pcivil", "perm.civil.ptr", "perm.inventario", "perm.user" },
	["Corregedor [CPTR]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.policia.civil", "perm.doors", "perm.roubos", "pagamento.corrigidor.pcivil", "perm.civil.ptr", "perm.inventario", "perm.user" },
	["Investigador [CPTR]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.policia.civil", "perm.doors", "perm.roubos", "pagamento.investigador.pcivil", "perm.civil.ptr", "perm.inventario", "perm.user" },
	["Operador [CPTR]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.policia.civil", "perm.doors", "perm.roubos", "pagamento.operador.pcivil", "perm.civil.ptr", "perm.inventario", "perm.user" },
	["Agente [CPTR]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.policia.civil", "perm.doors", "perm.roubos", "pagamento.agente.pcivil", "perm.civil.ptr", "perm.inventario", "perm.user" },
	["Escrivão [CPTR]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.policia.civil", "perm.doors", "perm.roubos", "pagamento.escrivao.pcivil", "perm.civil.ptr", "perm.inventario", "perm.user" },
	["Piloto [CPTR]"] = { _config = { title = "Policia CIVIL", gtype = "org" }, "perm.civil", "perm.policia.civil", "perm.doors", "perm.roubos", "pagamento.piloto.pcivil", "perm.civil.ptr", "perm.inventario", "perm.user" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- UNIZK
------------------------------------------------------------------------------------------------------------------------------------------------
	["Diretor [HOSPITAL]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "perm.user"},
	["Sub-diretor [HOSPITAL]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "perm.user"},
	["Gestão [HOSPITAL]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "perm.user"},
	["Medico [HOSPITAL]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "perm.user"},
	["Enfermeiro [HOSPITAL]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "perm.user"},
	["Medico Militar [HOSPITAL]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "perm.doors", "perm.user"},
	["Psicologo [HOSPITAL"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "perm.user"},
	["Socorrista [HOSPITAL]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "perm.user"},
	["Farmaceutico [HOSPITAL]"] = {_config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "perm.user"},
-- Expediente
	["Diretor [EXP]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "pagamento.diretor.unizk", "perm.unizk.ptr, perm.user"},
	["Sub-diretor [EXP]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "pagamento.subdiretor.unizk", "perm.unizk.ptr, perm.user"},
	["Gestão [EXP]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "pagamento.gestao.unizk", "perm.unizk.ptr, perm.user"},
	["Medico [EXP]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "pagamento.medico.unizk", "perm.unizk.ptr"},
	["Enfermeiro [EXP]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "pagamento.enfermeiro.unizk", "perm.unizk.ptr", "perm.user"},
	["Medico Militar [EXP]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "pagamento.medicom.unizk", "perm.doors", "perm.unizk.ptr", "perm.user"},
	["Psicologo [EXP]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "pagamento.psicologo.unizk", "perm.unizk.ptr", "perm.user"},
	["Socorrista [EXP]"] = { _config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "pagamento.socorrista.unizk", "perm.unizk.ptr", "perm.user"},
	["Farmaceutico [EXP]"] = {_config = { title = "HOSPITAL", gtype = "org" }, "perm.unizk", "pagamento.farmaco.unizk", "perm.unizk.ptr", "perm.user"},
------------------------------------------------------------------------------------------------------------------------------------------------
-- C.E.T
------------------------------------------------------------------------------------------------------------------------------------------------
	["Diretor [CET]"] = { _config = { title = "CET", gtype = "org" }, "perm.cet", "pagamento.cet.diretor", "perm.user"}, 
	["Superintendente [CET]"] = { _config = { title = "CET", gtype = "org" }, "perm.cet", "pagamento.cet.superintendente", "perm.user"},
	["Guarda [CET]"] = { _config = { title = "CET", gtype = "org" }, "perm.cet", "pagamento.cet.guarda", "perm.user"},
	["Guarda de Transito [CET]"] = { _config = { title = "CET", gtype = "org" }, "perm.cet", "pagamento.cet.guardatransito", "perm.user"},
------------------------------------------------------------------------------------------------------------------------------------------------
-- JUDICIARIO
------------------------------------------------------------------------------------------------------------------------------------------------
	["Ministro"] = { _config = { title = "Ministro", gtype = "org" }, "perm.ministro", "pagamento.ministro", "perm.user" },
	["Juiz"] = { _config = { title = "Juiz", gtype = "org" }, "perm.juiz", "pagamento.juiz", "perm.user" },
	["Promotor"] = { _config = { title = "Promotor", gtype = "org" }, "perm.promotor" , "pagamento.promotor", "perm.user" },
	["Advogados"] = { _config = { title = "Advogados", gtype = "org" }, "perm.advogado", "pagamento.advogado", "perm.user" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- NZK NEWS
------------------------------------------------------------------------------------------------------------------------------------------------
	["Diretor [NEWS]"] = { _config = { title = "News", gtype = "org" }, "perm.news","pagamento.diretor.news", "perm.user" },
	["Sub-Diretor [NEWS]"] = { _config = { title = "News", gtype = "org" }, "perm.news","pagamento.vice.news", "perm.user" },
	["Reporter [NEWS]"] = { _config = { title = "News", gtype = "org" }, "perm.news" ,"pagamento.reporter.news", "perm.user" },
	["Camera [NEWS]"] = { _config = { title = "News", gtype = "org" }, "perm.news" ,"pagamento.camera.news", "perm.user" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- STREET RACE
------------------------------------------------------------------------------------------------------------------------------------------------
--[[ 	["Lider [CARTEL]"] = { _config = { title = "CARTEL", gtype = "org" }, "perm.driftking",  "perm.tuningdk", "perm.dkmc", "perm.user", "ilegal.permissao" },
	["Sub-Lider [CARTEL]"] = { _config = { title = "CARTEL", gtype = "org" }, "perm.driftking",  "perm.tuningdk", "perm.dkmc", "perm.user", "ilegal.permissao" },
	["Membro [CARTEL]"] = { _config = { title = "CARTEL", gtype = "org" }, "perm.driftking" , "perm.tuningdk", "perm.dkmc", "perm.user", "ilegal.permissao" },
	["Tecnico [CARTEL]"] = { _config = { title = "CARTEL", gtype = "org" }, "perm.tuningdk", "perm.tecnicodk", "perm.dkmc", "perm.user", "ilegal.permissao" }, ]]
------------------------------------------------------------------------------------------------------------------------------------------------
-- ROSAS
------------------------------------------------------------------------------------------------------------------------------------------------
	["Lider [ROSAS]"] = { _config = { title = "ROSAS", gtype = "org" }, "perm.ballas", "perm.trafico", "pagamento.ballas.lider", "perm.user", "ilegal.permissao" },
	["Sub-Lider [ROSAS]"] = { _config = { title = "ROSAS", gtype = "org" }, "perm.ballas", "perm.trafico", "pagamento.ballas.membro", "perm.user", "ilegal.permissao" },
	["Membro [ROSAS]"] = { _config = { title = "ROSAS", gtype = "org" }, "perm.ballas", "perm.trafico", "pagamento.ballas.membro", "perm.user", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- VERMELHOS
------------------------------------------------------------------------------------------------------------------------------------------------
	["Lider [VERMELHOS]"] = { _config = { title = "Vermelhos", gtype = "org" }, "perm.vagos", "perm.trafico", "perm.user", "ilegal.permissao" },
	["Sub-Lider [VERMELHOS]"] = { _config = { title = "Vermelhos", gtype = "org" }, "perm.vagos", "perm.trafico", "perm.user", "ilegal.permissao" },
	["Membro [VERMELHOS]"] = { _config = { title = "Vermelhos", gtype = "org" }, "perm.vagos", "perm.trafico", "perm.user", "ilegal.permissao" }, 
------------------------------------------------------------------------------------------------------------------------------------------------
-- MAFIA
------------------------------------------------------------------------------------------------------------------------------------------------
	["Lider [MAFIA]"] = { _config = { title = "Mafia", gtype = "org" }, "perm.bratva", "perm.produzir.armas", "perm.user", "ilegal.permissao" },
	["Sub-Lider [MAFIA]"] = { _config = { title = "Mafia", gtype = "org" }, "perm.bratva", "perm.produzir.armas", "perm.user", "ilegal.permissao" }, 
	["Membro [MAFIA]"] = { _config = { title = "Mafia", gtype = "org" }, "perm.bratva", "perm.produzir.armas", "perm.user", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- MotoClub
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [MOTOCLUB]"] = { _config = { title = "MOTOCLUB", gtype = "org" }, "perm.mcn", "perm.produzir.armas", "perm.user", "ilegal.permissao" },
["Sub-Lider [MOTOCLUB]"] = { _config = { title = "MOTOCLUB", gtype = "org" }, "perm.mcn", "perm.produzir.armas", "perm.user", "ilegal.permissao" }, 
["Membro [MOTOCLUB]"] = { _config = { title = "MOTOCLUB", gtype = "org" }, "perm.mcn",  "perm.produzir.armas", "perm.user", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- MILICIA
------------------------------------------------------------------------------------------------------------------------------------------------
	["Lider [MILICIA]"] = { _config = { title = "MILICIA", gtype = "org" }, "perm.yakuza", "perm.produzir.armas", "perm.user", "ilegal.permissao" },
	["Sub-Lider [MILICIA]"] = { _config = { title = "MILICIA", gtype = "org" }, "perm.yakuza", "perm.produzir.armas", "perm.user", "ilegal.permissao" }, 
	["Membro [MILICIA]"] = { _config = { title = "MILICIA", gtype = "org" }, "perm.yakuza",  "perm.produzir.armas", "perm.user", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- ROXOS
------------------------------------------------------------------------------------------------------------------------------------------------
	["Lider [ROXOS]"] = { _config = { title = "ROXOS", gtype = "org" }, "perm.trafico", "perm.brancos", "perm.user", "ilegal.permissao" },
	["Sub-Lider [ROXOS]"] = { _config = { title = "ROXOS", gtype = "org" }, "perm.trafico", "perm.brancos", "perm.user", "ilegal.permissao" }, 
	["Membro [ROXOS]"] = { _config = { title = "ROXOS", gtype = "org" }, "perm.trafico", "perm.brancos", "perm.user", "ilegal.permissao" },  -- "perm.trafico", "ilegal.permissao"""
------------------------------------------------------------------------------------------------------------------------------------------------
-- MOTOCLUBE
------------------------------------------------------------------------------------------------------------------------------------------------
--[[ 	["Lider [FBB]"] = { _config = { title = "FBB", gtype = "org" }, "perm.motoclube", "perm.dkmc", "perm.user", "ilegal.permissao" },
	["Sub-Lider [FBB]"] = { _config = { title = "FBB", gtype = "org" }, "perm.motoclube", "perm.dkmc", "perm.user", "ilegal.permissao" },
	["Membro [FBB]"] = { _config = { title = "FBB", gtype = "org" }, "perm.motoclube", "perm.dkmc", "perm.user", "ilegal.permissao" }, ]]
------------------------------------------------------------------------------------------------------------------------------------------------
-- IAA
------------------------------------------------------------------------------------------------------------------------------------------------
	["Diretor [IAA]"] = { _config = { title = "IAA", gtype = "org" }, "perm.iaa","pagamento.iaa", "perm.user", "ilegal.permissao" },
	["Agente [IAA]"] = { _config = { title = "IAA", gtype = "org" }, "perm.iaa","pagamento.agente.iaa", "perm.user", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- BAHAMAS MAMAS
------------------------------------------------------------------------------------------------------------------------------------------------
	["Lider [BAHAMAS]"] = { _config = { title = "BAHAMAS", gtype = "org" }, "perm.tequilala",  "perm.lavagem", "perm.user", "perm.bar", "ilegal.permissao" },
	["Sub-Lider [BAHAMAS]"] = { _config = { title = "BAHAMAS", gtype = "org" }, "perm.tequilala",  "perm.lavagem", "perm.user", "perm.bar", "ilegal.permissao" },
	["Membro [BAHAMAS]"] = { _config = { title = "BAHAMAS", gtype = "org" }, "perm.tequilala", "perm.lavagem", "perm.user", "perm.bar", "ilegal.permissao" }, 
	------------------------------------------------------------------------------------------------------------------------------------------------
-- GALAXY
------------------------------------------------------------------------------------------------------------------------------------------------
	["Lider [GALAXY]"] = { _config = { title = "GALAXY", gtype = "org" }, "perm.vanilla", "perm.lavagem", "perm.user", "perm.bar", "ilegal.permissao" },
	["Sub-Lider [GALAXY]"] = { _config = { title = "GALAXY", gtype = "org" }, "perm.vanilla", "perm.lavagem", "perm.user", "perm.bar", "ilegal.permissao" },
	["Membro [GALAXY]"] = { _config = { title = "GALAXY", gtype = "org" }, "perm.vanilla", "perm.lavagem", "perm.user", "perm.bar", "ilegal.permissao" }, 
------------------------------------------------------------------------------------------------------------------------------------------------
-- MECANICO
------------------------------------------------------------------------------------------------------------------------------------------------
	["Lider [MECANICO]"] = { _config = { title = "Mecanico", gtype = "org" }, "perm.mecanico", "perm.user" },
	["Sub-Lider [MECANICO]"] = { _config = { title = "Mecanico", gtype = "org" }, "perm.mecanico", "perm.user" },
	["Membro [MECANICO]"] = { _config = { title = "Mecanico", gtype = "org" }, "perm.mecanico", "perm.user" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- FAVELA MACACO
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [MACACO]"] = { _config = { title = "Macaco", gtype = "org" }, "perm.macaco", "perm.user","perm.trafico", "ilegal.permissao" },
["Membro [MACACO]"] = { _config = { title = "Macaco", gtype = "org" }, "perm.macaco", "perm.user","perm.trafico", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- FAVELA CORUJA
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [CORUJA]"] = { _config = { title = "Coruja", gtype = "org" }, "perm.coruja", "perm.user","perm.trafico", "ilegal.permissao" },
["Membro [CORUJA]"] = { _config = { title = "Coruja", gtype = "org" }, "perm.coruja", "perm.user","perm.trafico", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- FAVELA LOBO
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [LOBO]"] = { _config = { title = "Lobo", gtype = "org" }, "perm.lobo", "perm.user","perm.trafico", "ilegal.permissao" },
["Membro [LOBO]"] = { _config = { title = "Lobo", gtype = "org" }, "perm.lobo", "perm.user","perm.trafico", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- FAVELA RAPOSA
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [RAPOSA]"] = { _config = { title = "Raposa", gtype = "org" }, "perm.raposa", "perm.user","perm.trafico", "ilegal.permissao" },
["Membro [RAPOSA]"] = { _config = { title = "Raposa", gtype = "org" }, "perm.raposa", "perm.user","perm.trafico", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- FAVELA BOI
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [BOI]"] = { _config = { title = "Boi", gtype = "org" }, "perm.boi", "perm.user","perm.trafico", "ilegal.permissao" },
["Membro [BOI]"] = { _config = { title = "Boi", gtype = "org" }, "perm.boi", "perm.user","perm.trafico", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- FAVELA RATO
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [RATO]"] = { _config = { title = "Rato", gtype = "org" }, "perm.rato", "perm.user","perm.trafico", "ilegal.permissao" },
["Membro [RATO]"] = { _config = { title = "Rato", gtype = "org" }, "perm.rato", "perm.user","perm.trafico", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- FAVELA URSO
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [URSO]"] = { _config = { title = "Urso", gtype = "org" }, "perm.urso", "perm.user","perm.trafico", "ilegal.permissao" },
["Membro [URSO]"] = { _config = { title = "Urso", gtype = "org" }, "perm.urso", "perm.user","perm.trafico", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- FAVELA CAVALO
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [CAVALO]"] = { _config = { title = "Cavalo", gtype = "org" }, "perm.cavalo", "perm.user","perm.trafico", "ilegal.permissao" },
["Membro [CAVALO]"] = { _config = { title = "Cavalo", gtype = "org" }, "perm.cavalo", "perm.user","perm.trafico", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- FAVELA DIABO
------------------------------------------------------------------------------------------------------------------------------------------------
["Lider [DIABO]"] = { _config = { title = "Diabo", gtype = "org" }, "perm.diabo", "perm.user","perm.trafico", "ilegal.permissao" },
["Membro [DIABO]"] = { _config = { title = "Diabo", gtype = "org" }, "perm.diabo", "perm.user","perm.trafico", "ilegal.permissao" },
------------------------------------------------------------------------------------------------------------------------------------------------

-- LSCUSTOM
------------------------------------------------------------------------------------------------------------------------------------------------	
	["Lider [LS CUSTOM]"] = { _config = { title = "LS Custom", gtype = "org" }, "perm.mecanico","perm.user" },
	["Sub-Lider [LS CUSTOM]"] = { _config = { title = "LS Custom", gtype = "org" }, "perm.mecanico", "perm.user" },
	["Membro [LS CUSTOM]"] = { _config = { title = "LS Custom", gtype = "org" }, "perm.mecanico", "perm.user" },
-- EXPEDIENTE
	["Lider [PMEC]"] = { _config = { title = "Mecanico", gtype = "org" }, "perm.mecanico", "pagamento.mecanico.lider", "perm.mec.ptr", "perm.user" },
	["Sub-Lider [PMEC]"] = { _config = { title = "Mecanico", gtype = "org" }, "perm.mecanico", "pagamento.mecanico.lider", "perm.mec.ptr", "perm.user" },
	["Membro [PMEC]"] = { _config = { title = "Mecanico", gtype = "org" }, "perm.mecanico", "pagamento.mecanico.membro", "perm.mec.ptr", "perm.user" },
	["Lider [LSEXP]"] = { _config = { title = "LS Custom", gtype = "org" }, "perm.mecanico","perm.mecanico", "pagamento.mecanico.membro", "perm.mec.ptr", "perm.user" },
	["Sub-Lider [LSEXP]"] = { _config = { title = "LS Custom", gtype = "org" }, "perm.mecanico", "perm.mecanico", "pagamento.mecanico.membro", "perm.mec.ptr", "perm.user" },
	["Membro [LSEXP]"] = { _config = { title = "LS Custom", gtype = "org" }, "perm.mecanico", "perm.mecanico", "pagamento.mecanico.membro", "perm.mec.ptr", "perm.user" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- EMPREGOS LEGAIS
------------------------------------------------------------------------------------------------------------------------------------------------
	["Minerador"] = { _config = { title = "Minerador", gtype = "job" }, "perm.minerador", "perm.user" },
	["Lenhador"] = { _config = { title = "Lenhador", gtype = "job" }, "perm.lenhador", "perm.user" },
	["Uber"] = { _config = { title = "Uber", gtype = "job" },"pagamento.uber", "perm.uber", "perm.user" },
	["Lixeiro"] = { _config = { title = "Lixeiro", gtype = "job" }, "perm.lixeiro", "perm.user" },
	["Motorista"] = { _config = { title = "Motorista", gtype = "job" }, "perm.motorista", "perm.user"},
	["Pescador"] = { _config = { title = "Pescador", gtype = "job" }, "perm.pescador", "perm.user" },
	["Entregador"] = { _config = { title = "Entregador", gtype = "job" }, "perm.entregador", "perm.user" },
	["Salva Vidas"] = { _config = { title = "Salva Vidas", gtype = "job" }, "perm.svidas", "perm.user" },
	["Corretor"] = { _config = { title = "Corretor de Imoveis", gtype = "job" }, "perm.corretor", "pagamento.corretor", "perm.user" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- EMPREGOS ILEGAIS
------------------------------------------------------------------------------------------------------------------------------------------------
	["Vendedor de Maconha"] = { _config = { title = "Vendedor de Maconha", gtype = "job" }, "perm.vendermaconha", "perm.user", "ilegal.permissao"},
	["Vendedor de Cocaina"] = { _config = { title = "Vendedor de Cocaina", gtype = "job" }, "perm.vendercocaina", "perm.user", "ilegal.permissao"},
	["Vendedor de MD"] = { _config = { title = "Vendendor de MD", gtype = "job" }, "perm.vendermd", "perm.user", "ilegal.permissao" },
	["Traficante de Orgãos"] = { _config = { title = "Traficante de Orgãos", gtype = "job" }, "perm.orgaos", "perm.user", "ilegal.permissao"},
	["Traficante de Tartaruga"] = { _config = { title = "Traficante de Tartaruga", gtype = "job" }, "perm.tartaruga", "perm.user", "ilegal.permissao"},
------------------------------------------------------------------------------------------------------------------------------------------------
-- VIPs
------------------------------------------------------------------------------------------------------------------------------------------------	
    ["Prata"] = { _config = { gtype = "vip" }, "perm.vip", "perm.prata","pagamento.prata", "perm.inventario", "perm.user"},
	["Ouro"] = { _config = { gtype = "vip" }, "perm.vip", "perm.ouro","pagamento.ouro", "perm.inventario", "perm.user" },
	["Diamante"] = { _config = { gtype = "vip" }, "perm.vip", "perm.diamante","pagamento.diamante", "perm.inventario", "perm.user", "perm.cor" },
	["Platina"] = { _config = { gtype = "vip" }, "perm.vip", "perm.platina","pagamento.platina", "perm.inventario", "perm.user", "perm.cor" },
	["Esmeralda"] = { _config = { gtype = "vip" }, "perm.vip", "perm.esmeralda","pagamento.esmeralda", "perm.inventario", "perm.user", "perm.cor" },
------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
------------------------------------------------------------------------------------------------------------------------------------------------
	["NSalario"] = { _config = { gtype = "NSalario" },  "-pagamento.prata", "-pagamento.ouro", "-pagamento.diamante", "-pagamento.platina", "-pagamento.esmeralda", "-pagamento.comandante.policia", "-pagamento.coronel.policia", "-pagamento.tencoronel.policia", "-pagamento.major.policia", "-pagamento.capitao.policia", "-pagamento.tenente.policia", "-pagamento.sargento.policia", "-pagamento.cabo.policia", "-pagamento.soldado.policia", "-pagamento.recruta.policia", "-pagamento.piloto.policia", "-pagamento.comandante.civil", "-pagamento.delegado.civil", "-pagamento.corrigidor.civil", "-pagamento.investigador.civil", "-pagamento.operador.civil", "-pagamento.agente.civil", "-pagamento.escrivao.civil", "-pagamento.piloto.civil", "-pagamento.diretor.unizk", "-pagamento.subdiretor.unizk", "-pagamento.gestao.unizk", "-pagamento.medico.unizk", "-pagamento.medicom.unizk", "-pagamento.enfermeiro.unizk", "-pagamento.psicologo.unizk", "-pagamento.socorrista.unizk", "-pagamento.ministro", "-pagamento.promotor", "-pagamento.advogado", "-pagamento.diretor.news", "-pagamento.vice.news", "-pagamento.reporter.news", "-pagamento.camera.news", "-pagamento.mecanico.lider", "-pagamento.uber", "-pagamento.lixeiro", "-pagamento.motorista", "-pagamento.pescador", "-pagamento.entregador", "-pagamento.cet.diretor", "-pagamento.cet.superintendente", "-pagamento.cet.guarda", "-pagamento.cet.guardatransito" },
	["CNH"] = { _config = { gtype = "CNH" }, },
	["Porte de Arma"] = { _config = { gtype = "Porte de Arma" }},
	["Desempregado"] = { _config = { title = "Desempregado", gtype = "job" }, },
}

cfg.users = { [1] = { "admin" }, [2] = { "admin" }}

cfg.selectors = {
	["Empregos Legais"] = { _config = {x = -1081.88, y = -247.95, z = 37.76}, "Minerador", "Uber", "Lixeiro", "Motorista", "Pescador", "Entregador", "Lenhador", "Salva Vidas", "Desempegado", },
	["Empregos Ilegais"] = { _config = {x = 707.03, y = -966.56, z = 30.41}, "Traficante de Orgãos", "Traficante de Tartaruga", "Desempregado" }
}

 
return cfg