const vrp = require('./vrp');
const esx = require('./esx');

const isVRP = GetResourceState('vrp') != 'missing';
const isESX = GetResourceState('es_extended') != 'missing';

exports.isVRP = isVRP;
exports.isESX = isESX;

exports.vrp = vrp;
exports.esx = esx;

exports.isOnline = (player) => {
  if (isVRP) return vrp.isOnline(player);
  else return esx.isOnline(player);
}
exports.getSource = (player) => {
  if (isVRP) return vrp.getSource(player);
  else return esx.getSource(player);
}
exports.getName = (player) => {
  if (isVRP) return vrp.getName(player);
  else return esx.getName(player);
}
exports.getId = (player) => {
  if (isVRP) return vrp.getId(player);
  else return undefined;
}
exports.getSteamHex = (source) => {
  if (isVRP) return undefined;
  else return esx.getSteamHex(source);
}
exports.hasPermission = (player, permission) => {
  if (isVRP) return vrp.hasPermission(player, permission);
  else return undefined;
}