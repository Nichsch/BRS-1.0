const config = require('../config.json');

/**
 * @param {string} plugin
 * @return {boolean}
 */
function hasPlugin(plugin) {
  if (arguments.length > 1) {
    for (let plugin of Object.values(arguments)) {
      if (hasPlugin(plugin)) return true;
    }
    return false;
  }
  return config.plugins.findIndex(s=>s.toLowerCase()===plugin.toLowerCase()) !== -1;
}

config.hasPlugin = hasPlugin;

module.exports = config;