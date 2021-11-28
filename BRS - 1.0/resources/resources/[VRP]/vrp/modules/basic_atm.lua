local cfg = module("cfg/atms")
local atms = cfg.atms

local function play_atm_enter(player)
  vRPclient._playAnim(player,false,{{"amb@prop_human_atm@male@enter","enter"},{"amb@prop_human_atm@male@idle_a","idle_a"}},false)
end

local function play_atm_exit(player)
  vRPclient._playAnim(player,false,{{"amb@prop_human_atm@male@exit","exit"}},false)
end

local function atm_choice_deposit(player,choice)
  local user_id = vRP.getUserId(player)
    play_atm_enter(player)

    local v = vRP.prompt(player,"Quantidade a depositar:","")
    play_atm_exit(player)

    v = parseInt(v)

    if v > 0 then
      if user_id then
        if vRP.tryDeposit(user_id,v) then
          TriggerClientEvent('chatMessage', player, "^5Depositado: $"..v.."")
        else
          TriggerClientEvent('chatMessage', player, "^9Você não tem esse dinheiro no banco.")
        end
      end
    else
      TriggerClientEvent('chatMessage', player, "^9Valor invalido.")
    end
end

local function atm_choice_withdraw(player,choice)
  play_atm_enter(player)
  local v = vRP.prompt(player,"Quantidade a Sacar:","")
  play_atm_exit(player) --anim
  v = parseInt(v)
  if v > 0 then
    local user_id = vRP.getUserId(player)
    if user_id then
      if vRP.tryWithdraw(user_id,v) then
        TriggerClientEvent('chatMessage', player, "^5Você sacou $"..v)
      else
        TriggerClientEvent('chatMessage', player, "^9Você não tem esse dinheiro no banco.")
      end
    end
  else
    TriggerClientEvent('chatMessage', player, "^9Valor invalido.")
  end
end

local function atm_choice_transferir(player, choice)
  local user_id = vRP.getUserId(player)
      local nuser_id = vRP.prompt(player,"Digite o ID:", "")
      if tonumber(nuser_id) then
          local valorTransferir = vRP.prompt(player,"Digite o valor para transferir:", "")
          if parseInt(valorTransferir) and parseInt(valorTransferir) > 0 then
              local bancoN = vRP.getBankMoney(tonumber(nuser_id))
              if tonumber(user_id) == tonumber(nuser_id) then
                  TriggerClientEvent('chatMessage', player, "^2Você não pode transferir para si mesmo.")
                  play_atm_exit(player)
              else
                  if vRP.tryTransfer(user_id,parseInt(valorTransferir)) then
                      vRP.setBankMoney(tonumber(nuser_id),parseInt(bancoN+parseInt(valorTransferir)))
                      TriggerClientEvent('chatMessage', player, "^2Você transferiu ^5$ "..parseInt(valorTransferir).."^2 para o [ID: "..tonumber(nuser_id).."].")
                      vRP.log("nzk_logs/player/transferiratm.txt", "O [ID: "..tonumber(user_id).."] transferiu $ "..parseInt(valorTransferir).." para o [ID: "..tonumber(nuser_id).."]")
                      play_atm_exit(player)
                  else
                      TriggerClientEvent('chatMessage', player, "^2Você não possui essa quantia para transferir.")
                      play_atm_exit(player)
                  end
              end
          end
      end
      play_atm_enter(player)
end

local function atm_choice_pagarmultas(player, choice)
  local user_id = vRP.getUserId(player)
  local source = vRP.getUserSource(user_id)

    if user_id then
      local multasPagar = vRP.prompt(player, "Digite o valor para pagar", "")
      if multasPagar then
        if tonumber(multasPagar) ~= nil and tonumber(multasPagar) > 0 and tonumber(multasPagar) < 500001 then
          local value = vRP.getUData(parseInt(user_id),"vRP:multas")
          local multas = json.decode(value) or 0
          if multas <= 100000 then
          if tostring(multasPagar) <= tostring(multas) then
            if vRP.tryFullPayment(user_id, tonumber(multasPagar)) then
              vRP.setUData(parseInt(user_id),"vRP:multas",json.encode(parseInt(multas)-parseInt(multasPagar)))
              TriggerClientEvent('chatMessage', player, "^2Você pagou ^5$"..tonumber(multasPagar).." em multas.")
            else
              TriggerClientEvent('chatMessage', player, "^9 Você não possui dinheiro.")
            end

          else
            TriggerClientEvent('chatMessage', player, "^9Você não pode pagar um valor maior que sua divida.")
          end
          else
            TriggerClientEvent('chatMessage', player, "^2Você possui ^5["..vRP.format(multas).."/500.000]^2 de multas pendentes e nao pode pagar em um caixa eletronico, va ate a delegacia!")
          end
        else
          TriggerClientEvent('chatMessage', player, "^2Coloque o valor corretamente 1-500000.")
        end
      end
    end

end

local atm_menu = {
  name="Caixa Eletronico"
}

atm_menu["1. Depositar"] = {atm_choice_deposit}
atm_menu["2. Sacar"] = {atm_choice_withdraw}
atm_menu["3. Transferir"] = {atm_choice_transferir}
atm_menu["5. Pagar Multas"] = {atm_choice_pagarmultas}

local function atm_enter()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    atm_menu["4. Saldo"] = {function()end,"<text01>Quantidade</text01> <text02>"..vRP.getBankMoney(user_id).."</text02>"}
    vRP.openMenu(source,atm_menu) 
  end
end

local function atm_leave()
  vRP.closeMenu(source)
end

local function build_client_atms(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k,v in pairs(atms) do
      local x,y,z = table.unpack(v)
        vRP.setArea(source,"vRP:atm"..k,x,y,z,1,1.5,atm_enter,atm_leave)
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
    build_client_atms(source)
  end
end)