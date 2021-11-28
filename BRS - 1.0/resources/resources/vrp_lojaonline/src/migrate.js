const mysql = require('mysql');
const config = require('../config.json');
const list = require('../scheduled.json');

const connection = mysql.createConnection(config.mysql);

const sql = (sql,values=[]) => new Promise((resolve,reject) => {
  connection.query(sql, values, (error,res) => error? reject(error) : resolve(res));
});

connection.connect(async err => {
  if (err) {
    console.error('Não foi possível se conectar no banco de dados!');
    console.error(err);
  } else if (list.length === 0) {
    console.error('Lista de agendamentos vazia');
  } else {
    await sql(`CREATE TABLE IF NOT EXISTS fstore_appointments (id BIGINT NOT NULL AUTO_INCREMENT, command VARCHAR(255), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, expires_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (id))`);
    const values = [];
    list.forEach(({ eval, date }) => values.push([eval, new Date(date)]));
    
    let index = 1;
    const template = 'INSERT INTO fstore_appointments (command,expires_at) VALUES (?,?)';
    for (let v of values) {
      await sql(template, v);
      console.log(`Migrando........ ${index}/${values.length}`);
      index+=1;
    }
  }
  process.exit(0);
});