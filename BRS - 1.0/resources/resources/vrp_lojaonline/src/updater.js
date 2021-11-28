const child = require('child_process');
const utils = require('./utils');
const config = require('./config');

const folder = GetResourcePath(GetCurrentResourceName());
const path = folder+'/src/real_updater.js';

const checkNode = () => new Promise(resolve => {
  child.exec('node --version', (error, out) => {
    resolve(!error);
  });
});

const update = async () => {
  const hasNode = await checkNode();
  if (hasNode) {
    child.exec('node '+path, (error, out, err) => {
      if (error) {
        console.error('Falha ao atualizar...');
        utils.printError(error);
      } else {
        if (out) console.log(out);
        if (err) console.log(err);
      }
    });
  } else {
    console.error('Não foi encontrado NodeJS em sua máquina, e por isso o fstore não será atualizado');
    console.error('Providencie uma versão do NodeJS através do link https://nodejs.org/en/download');
    console.error('(É possível também que o terminal não tenha sido reiniciado após a instalação)');
  }
};

if (!config.hasPlugin('dev')) update();

module.exports.update = update;