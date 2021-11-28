exports.lua = (lua_code) => {
  return new Promise(resolve => {
    emit('fivemstore-lua', lua_code, resolve);
  });
}