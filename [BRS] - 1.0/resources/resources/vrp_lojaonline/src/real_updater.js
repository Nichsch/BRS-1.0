const unzipper = require('unzipper');
const axios = require('axios').default;
const fs = require('fs');

const repository = 'https://github.com/JesterIruka/fstore-vrp/archive/master.zip';
const folder = __dirname+'/../';

// Arquivo que você não quer atualizar
const excluded = [
  '/config.json',
  '/nui/index.css',
  '/nui/index.html',
  '/Instalar.bat'
];

// Arquivos que só serão criados automaticamente
const onlyCreate = [
  '/src/custom.js'
];

async function update() {
  const response = await axios.get(repository, {responseType: 'arraybuffer'});
  const zip = await unzipper.Open.buffer(response.data);
  for (let file of zip.files) {
    if (file.path.endsWith('/')) continue;
    let path = file.path.replace('fstore-vrp-master', '');
    if (onlyCreate.includes(path) && fs.existsSync(folder+path)) continue;
    if (path.length && !excluded.includes(path)) {
      const buffer = await file.buffer();
      fs.writeFileSync(folder+path, buffer);
    }
  }
}

update().then(() => console.log('Script atualizado com sucesso')).catch(console.error);