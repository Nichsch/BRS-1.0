const { lua } = require('./lua');
const { sql, pluck, insert, getDatatable, setDatatable, createAppointment, after } = require('./mysql');
const Warning = require('./Warning');
const config = require('./config');

const custom = {};

custom.minhaFuncao = (user_id) => {
  // Faça o que quiser aqui
}

module.exports = custom;