const { lua } = require('./lua');
const api = require ('./api');
const { sql, pluck, insert, getDatatable, setDatatable, createAppointment, after } = require('./mysql');
const { snowflake, hasPlugin } = require('./config');
const Warning = require('./Warning');
const { firstAvailableNumber } = require('./utils');
const config = require('./config');
const homesMonitor = require('./vrp_homes_permissions');
require('./vrp_user_ids_monitor');

const vrp = {};

function now() {
  return parseInt(Date.now()/1000);
}

vrp.addTemporaryPriority = async (days, id, level) => {
  await after(days, `vrp.removePriority("${id}")`);
  await vrp.addPriority(id, level);
}

vrp.addPriority = async (id, level) => {
  if (hasPlugin('@trustcity'))
    return sql(`REPLACE INTO ${config.snowflake.priority || 'vrp_priority'} VALUES (?)`, [id]);

  const field = hasPlugin('@warriors') ? 'license' : 'steam';
  const prefix = hasPlugin('@warriors') ? 'license:%' : 'steam:%';

  const [hex] = await sql("SELECT identifier FROM vrp_user_ids WHERE user_id=? AND identifier LIKE ?", [id, prefix], true);
  if (hex) {
    if (hasPlugin('@crypto')) {
      const [row] = await sql("SELECT priority FROM vrp_priority WHERE steam=?", [hex.identifier], true);
      if (row) {
        return sql('UPDATE vrp_priority SET priority=? WHERE steam=?', [row.priority + level, hex.identifier]);
      }
    }
    const table = config.snowflake.priority || 'vrp_priority';
    return sql(`REPLACE INTO ${table} (${field},priority) VALUES (?,?)`, [hex.identifier, level]);
  } else {
    api.addWebhookBatch('```diff\n- Não foi possível encontrar a '+field+' de '+id+'```');
  }
}

vrp.removePriority = async (id) => {
  if (hasPlugin('@trustcity'))
    return sql(`DELETE FROM vrp_priority WHERE id=?`, [id]);

  const field = hasPlugin('@warriors') ? 'license' : 'steam';
  const prefix = hasPlugin('@warriors') ? 'license:%' : 'steam:%';

  const [hex] = await sql("SELECT identifier FROM vrp_user_ids WHERE user_id=? AND identifier LIKE ?", [id, prefix]);
  if (hex) {
    const table = config.snowflake.priority || 'vrp_priority';
    return sql(`DELETE FROM ${table} WHERE ${field}=?`, [hex.identifier]);
  } else {
    api.addWebhookBatch('```diff\nNão foi possível encontrar '+field+' de '+id+'```');
  }
}

vrp.addBank = vrp.bank = async (id, value) => {
  if (await vrp.isOnline(id)) {
    if (hasPlugin('@skycity'))
      return lua(`vRP.darDinheiro(${id}, ${value})`);
    else if (hasPlugin('@azteca', 'vrp-old')) return lua(`vRP.giveBankMoney({${id}, ${value}})`);
    
    return lua(`vRP.giveBankMoney(${id}, ${value})`)
  } else {
    return sql('UPDATE vrp_user_moneys SET bank=bank+? WHERE user_id=?', [value, id]);
  }
}
vrp.addWallet = vrp.money = async (id, value) => {
  if (await vrp.isOnline(id)) {
    if (hasPlugin('@azteca', 'vrp-old')) return lua(`vRP.giveMoney({${id}, ${value}})`);
    return lua(`vRP.giveMoney(${id}, ${value})`);
  } else {
    return sql('UPDATE vrp_user_moneys SET wallet=wallet+? WHERE user_id=?', [value, id]);
  }
}
vrp.addCoin = async (id, value) => {
  if (await vrp.isOnline(id)) {
    return lua(`vRP.giveBankCoin(${id}, ${value})`);
  } else {
    return sql('UPDATE vrp_user_moneys SET coins=coins+? WHERE user_id=?', [value, id]);
  }
}

vrp.addGroup = vrp.group = async (id, group) => {
  if (hasPlugin('@raiocity'))
    return insert('vrp_permissions', { user_id:id, permiss:group });
  if (await vrp.isOnline(id)) {
    if (hasPlugin('@skycity'))
      return lua(`vRP.adicionarGrupo(${id}, "${group}")`);
    else if (hasPlugin('@azteca', 'vrp-old'))
      return lua(`vRP.addUserGroup({${id}, "${group}"})`);
    return lua(`vRP.addUserGroup(${id}, "${group}")`);
  } else {
    const dvalue = await getDatatable(id);
    if (dvalue) {
      if (Array.isArray(dvalue.groups)) dvalue.groups = {};
      dvalue.groups[group] = true;
      return setDatatable(id, dvalue);
    } else {
      console.error('Não foi possível encontrar o dvalue para o jogador '+id);
    }
  }
}
vrp.removeGroup = vrp.ungroup = async (id, group) => {
  if (hasPlugin('@raiocity'))
    return sql(`DELETE FROM vrp_permissions WHERE user_id=? AND permiss=?`, [id,group]);
  if (await vrp.isOnline(id)) {
    if (hasPlugin('@azteca', 'vrp-old')) return lua(`vRP.removeUserGroup({${id}, "${group}"})`);
    return lua(`vRP.removeUserGroup(${id}, "${group}")`)
  } else {
    const dvalue = await getDatatable(id);
    if (dvalue) {
      if (Array.isArray(dvalue.groups)) dvalue.groups = {};
      delete dvalue.groups[group];
      return setDatatable(id, dvalue);
    } else {
      console.error('Não foi possível encontrar o dvalue para o jogador '+id);
    }
  }
}
vrp.addTemporaryGroup = async (days, id, group) => {
  await after(days, `vrp.removeGroup("${id}", "${group}")`);
  return vrp.addGroup(id, group);
}
/**
 * 
 * @returns {Promise<string>}
 */
vrp.getName = async (id) => {
  if (hasPlugin('@asgardcity')) {
    const [row] = await sql('SELECT * FROM vrp_users WHERE id=?', [id]);
    if (row) {
      return row.name + ' '+ row.name2;
    } else return undefined;
  }
  const table = hasPlugin('name_in_vrp_users') ? 'vrp_users' : 'vrp_user_identities';
  const field = hasPlugin('name_in_vrp_users') ? 'id' : 'user_id';
  const [row] = await sql(`SELECT * FROM ${table} WHERE ${field}=?`, [id]);
  if (row) {
    if (row.name !== undefined && row.firstname !== undefined) {
      return row.name+' '+row.firstname;
    } else if (row.nome && row.sobrenome) {
      return row.nome+' '+row.sobrenome;
    } else return null;
  }
  return undefined;
}
vrp.getId = (source) => {
  if (hasPlugin('@azteca', 'vrp-old')) return lua(`vRP.getUserId({${source}})`);
  else return lua(`vRP.getUserId(${source})`);
}
vrp.getSource = (id) => {
  if (hasPlugin('@azteca', 'vrp-old')) return lua(`vRP.getUserSource({${id}})`);
  return lua(`vRP.getUserSource(${id})`);
}
vrp.isOnline = (id) => {
  if (hasPlugin('@azteca', 'vrp-old')) return lua(`vRP.getUserSource({${id}}) ~= nil`);
  return lua(`vRP.getUserSource(${id}) ~= nil`);
}
vrp.hasPermission = (id, permission) => lua(`vRP.hasPermission(${id}, "${permission}")`);

//
//  VEÍCULOS
//

const comandorj_plate = (letters=3, numbers=5) => {
  let builder = '';
  const a = 'QWERTYUIOPASDFGHJKLZXCVBNM'.split('');
  const b = [0,1,2,3,4,5,6,7,8,9];
  while (letters > 0 || numbers > 0) {
    if (Math.random() <= 0.5 && letters > 0) {
      builder+= a[Math.floor(a.length * Math.random())];
      letters-=1;
    } else if (numbers > 0) {
      builder+= b[Math.floor(b.length * Math.random())];
      numbers-=1;
    }
  }
  return builder;
}

vrp.addCars = vrp.addVehicles = async (id, spawns, fields={}) => {
  let lastWarning = null;
  for (let spawn of spawns) {
    const warning = await vrp.addVehicle(id, spawn, fields);
    if (warning instanceof Warning) lastWarning = warning;
  }
  return lastWarning;
}

vrp.addCar = vrp.addVehicle = async (id, spawn, fields={}) => {
  if (hasPlugin('vrp_admin')) {
    ExecuteCommand(`addcar ${id} ${spawn}`);
    return;
  }
  const field = hasPlugin('@comandorj') ? 'model' : 'vehicle';

  const [row] = await sql(`SELECT * FROM ${snowflake.vehicles} WHERE user_id=? AND ${field}=?`, [id, spawn], true);
  if (row) return new Warning('Este jogador já possui esse veículo');
  else {
    const data = { user_id:id };
    data[field] = spawn;
    if (hasPlugin('@centralroleplay')) {
      const [old] = await sql(`SELECT vtype FROM fstore_helper WHERE spawn=?`, [spawn], true);
      data['veh_type'] = old ? old.vtype : 'car';

      const [udata] = await sql(`SELECT registration FROM vrp_user_identities WHERE user_id=?`, [id], true);
      data['vehicle_plate'] = 'P '+udata.registration;
    }
    if (hasPlugin('@crypto') || hasPlugin('ipva')) data['ipva'] = now();
    if (hasPlugin('@americandream')) data['can_sell'] = 0;
    if (hasPlugin('@comandorj', 'vehicle-trunk')) data['trunk'] = '[]';
    if (hasPlugin('@comandorj')) {
      const plates = await pluck(`SELECT plate FROM ${snowflake.vehicles}`, 'plate');
      let plate = comandorj_plate();
      while (plates.includes(plate)) plate = comandorj_plate();
      data['plate'] = plate;
    }
    for (let [k,v] in Object.entries(fields)) data[k]=v;
    await insert(snowflake.vehicles, data);
  }
}
vrp.removeCar = vrp.removeVehicle = (id, spawn) => {
  const field = hasPlugin('@comandorj') ? 'model' : 'vehicle';
  return sql(`DELETE FROM ${snowflake.vehicles} WHERE user_id=? AND ${field}=?`, [id, spawn]);
}
vrp.removeScheduledCars = async (id) => {
  return sql(`UPDATE fstore_appointments SET expires_at=? WHERE \`command\` LIKE 'vrp.removeVehicle("${id}"%`, [new Date()]);
}
vrp.removeAllCars = (id) => {
  return sql(`DELETE FROM ${snowflake.vehicles} WHERE user_id=?`, [id]);
}
vrp.addTemporaryCar = vrp.addTemporaryVehicle = async (days, id, spawn, fields={}) => {
  await after(days, `vrp.removeVehicle("${id}", "${spawn}")`);
  return vrp.addVehicle(id, spawn, fields);
}
vrp.changeCar = async (id, from, to) => {
  const field = hasPlugin('@comandorj') ? 'model' : 'vehicle';
  const command = `vrp.removeVehicle("${id}"%`;
  await sql(`UDPATE fstore_appointments SET command=REPLACE(command, '${from}', '${to}') WHERE command LIKE ?`, [command]);
  await sql(`UPDATE ${snowflake.vehicles} SET ${field}=? WHERE ${field}=?`, [to,from]);
  return sql(`DELETE FROM vrp_srv_data WHERE dkey=?`, [`custom:u${id}veh_${from}`]);
}

//
//  CASAS
//

vrp.addHome = vrp.addHouse = async (id, home) => {
  const [row] = await sql("SELECT number FROM vrp_user_homes WHERE user_id=? AND home=?", [id,home], true)
  if (row) return new Warning("Este jogador já possui esta casa");

  let numbers = await pluck("SELECT number FROM vrp_user_homes WHERE home=?", 'number', [home]);
  const number = firstAvailableNumber(numbers);

  const data = { user_id: id, home, number };
  if (hasPlugin('@americandream')) data['can_sell'] = 0;
  if (hasPlugin('home-tax')) data['tax'] = now();

  return insert('vrp_user_homes', data, true);
}
vrp.removeHome = vrp.removeHouse = async (id, house) => {
  return sql("DELETE FROM vrp_user_homes WHERE user_id=? AND home=?", [id, house]);
}
vrp.addTemporaryHouse = vrp.addTemporaryHome = async (days, id, house) => {
  await after(days, `vrp.removeHouse("${id}", "${house}")`);
  return vrp.addHome(id, house);
}

vrp.addHomePermission = vrp.addHousePermission = async (id, prefix) => {
  if (prefix.length > 2) {
    const [row] = await sql(`SELECT user_id,home FROM vrp_homes_permissions WHERE home=? AND owner=1`, [prefix], true);
    if (row) {
      if (row.user_id == id) return new Warning('O jogador já possui a casa (Renovando...)');
      return new Warning(`A casa ${prefix} já está ocupada por um jogador diferente`);
    }
    const data = { user_id: id, home: prefix, owner: 1, garage: 1, tax: now() };
    if (hasPlugin('home-no-tax')) delete data['tax'];
    await insert('vrp_homes_permissions', data);
    await homesMonitor.add(prefix, id);
    return prefix;
  }
  /* CASAS ALEATÓRIAS COM PRIMEIRA DISPONIBILIDADE (LEGADO) */
  let occupied = await pluck(`SELECT home FROM vrp_homes_permissions WHERE home LIKE '${prefix}%'`, 'home');
  const higher = firstAvailableNumber(occupied.map(s => parseInt(s.substring(prefix.length))));
  const home = prefix+(higher.toString().padStart(2, '0'));

  const data = { user_id: id, home, owner: 1, garage: 1 };
  if (hasPlugin('@crypto') || hasPlugin('home-tax')) data['tax'] = now();

  await insert('vrp_homes_permissions', data);
  return home;
}
vrp.removeHomePermission = vrp.removeHousePermission = async (id, prefix) => {
  if (prefix.length > 2) {
    await homesMonitor.remove(prefix);
    await sql('UPDATE vrp_srv_data SET dvalue=? WHERE dkey LIKE ?', ['{}', `%:${prefix}`]);
    return sql('DELETE FROM vrp_homes_permissions WHERE home = ?', [prefix]);
  }
  return sql('DELETE FROM vrp_homes_permissions WHERE user_id=? AND home LIKE ?', [id, prefix+'%']);
}
vrp.addTemporaryHousePermission = vrp.addTemporaryHomePermission = async (days, id, prefix) => {
  await after(days, `vrp.removeHousePermission("${id}", "${prefix}")`);
  return vrp.addHousePermission(id, prefix);
}

//
//  OUTROS
//

vrp.addInventory = vrp.addItem = async (id, item, amount) => {
  if (await vrp.isOnline(id)) {
    return lua(`vRP.giveInventoryItem(${id}, "${item}", ${amount})`);
  } else {
    const data = await getDatatable(id);
    if (data) {
      if (Array.isArray(data.inventory))
        data.inventory = {};

      if (data.inventory[item] && data.inventory[item].amount) {
        data.inventory[item] = { amount: data.inventory[item].amount + amount };
      } else data.inventory[item] = { amount };
      await setDatatable(id, data);
    }
  }
}

vrp.unban = (id) => vrp.setBanned(id, false);

vrp.ban = (id) => vrp.setBanned(id, true);

vrp.setBanned = (id, value) => sql(`UPDATE vrp_users SET banned=? WHERE id=?`, [value, id]);

vrp.setWhitelist = vrp.setWhitelisted = (id, value) => sql(`UPDATE vrp_users SET whitelist=? WHERE id=?`, [value, id]);


module.exports = vrp;