const axios = require('axios').default;
const { formatDate } = require('./utils');

const { token, webhook:webhook_url } = require('./config');

const hasWebhook = webhook_url.toLowerCase().includes("discordapp.com/api/webhooks");

const endpoint = axios.create({
  baseURL: `https://five-m.store/api/v2`,
  headers: {
    Authorization: token
  }
});

const api = {};
const batch = [];

/**
 * @returns {Promise<StatusResponse>}
 */
api.status = async () => {
  const { data } = await endpoint.get('/status');
  return data;
}

/**
 * @returns {Promise<FetchResponse>}
 */
api.fetch = async () => {
  const { data } = await endpoint.get('/fetch');
  return data;
}

/**
 * @param {number} players 
 * @param {Array} sales
 * @returns {Promise<CallbackResponse>}
 */
api.callback = async (players, sales) => {
  const { data } = await endpoint.post('/callback', { players, sales });
  return data;
}

api.setMetadata = (key, value) => {
  return endpoint.put('/setmetadata', { key, value }).catch(_ => {
    console.error('Falha ao modificar a metadata: '+key);
    console.error('Este erro pode ser grave, é recomendado que se reinicie o script.');
  });
}

api.addMetadata = (key, value) => {
  return endpoint.patch('/addmetadata', { key, value }).catch(_ => {
    console.error(`Falha ao adicionar ${JSON.stringify(value)} da loja (Metadata error)`);
  });
}

api.removeMetadata = (key, value) => {
  return endpoint.patch('/removemetadata', { key, value }).catch(_ => {
    console.error(`Falha ao remover ${JSON.stringify(value)} da loja (Metadata error)`);
  });
}

api.addWebhookBatch = (content) => {
  if (hasWebhook && batch.join('\n').length >= 1750) {
    api.sendWebhookBatch();
    batch.push('Continuação...');
  }
  batch.push(content);
}

api.sendWebhook = (content, color) => {
  if (!hasWebhook) {
    const formatted = content.replace(/(```[a-z]+\n|```)/g, '');
    console.log(formatted);
    return Promise.resolve();
  }
  else return endpoint.post(webhook_url, {
    embeds: [
      {
        title: formatDate(),
        description: content,
        color: color
      }
    ]
  }).catch(err => {
    if (err.response) {
      const status = err.response.status;
      console.error('Falha ao enviar webhook para o discord (Erro '+err.response.status+')');
      if (status === 429)
        console.error('O erro 429 é comum quando ocorre muitas entregas simultaneas');
      else
        console.error('Este erro é desconhecido pela nossa equipe, por favor envie para nós =]');
    } else console.error('Erro ao enviar webhook para o discord, não foi obtido uma resposta do servidor...');
  });
}

api.sendWebhookBatch = () => {
  const text = batch.join('\n');
  batch.splice(0, batch.length);
  return api.sendWebhook(text, 0xF1F1F1);
}

module.exports = api;