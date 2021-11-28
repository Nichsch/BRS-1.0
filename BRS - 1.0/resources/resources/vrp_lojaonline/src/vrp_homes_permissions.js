const db = require('./mysql');
const api = require('./api');
const config = require('./config');

var last = {};

function hasChanges(a={}, b={}) {
  for (let k in a) if (a[k] != b[k]) return true;
  for (let k in b) if (b[k] != a[k]) return true;
  return false;
}

function add(home, user_id) {
  last[home] = user_id;
  return api.addMetadata('homes', {home:user_id});
}

function remove(home) {
  delete last[home];
  return api.removeMetadata('homes', {home:null});
}

async function coroutine() {
  const homes = {};

  const rows = await db.sql('SELECT user_id,home FROM vrp_homes_permissions WHERE owner=1', [], true);
  for (let {user_id,home} of rows)
    homes[home] = user_id;

  if (hasChanges(homes, last))
    await api.setMetadata('homes', last = homes);
}

db.onConnect(() => {
  db.queryTables().then(() => {
    const prefix = config.snowflake.database_prefix||'vrp';
    if (db.tables().includes(prefix+'_homes_permissions')) {
      setInterval(coroutine, 10000);
      console.log('Monitorando casas disponíveis em '+prefix+'_homes_permissions...');
    }
  }).catch(err => console.error(err.message))
});

module.exports = { add,remove,coroutine };