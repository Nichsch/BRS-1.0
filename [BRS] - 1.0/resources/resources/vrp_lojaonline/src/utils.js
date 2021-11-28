module.exports.formatDate = (date) => {
  if (!date) date = new Date();
  const d = date.getDate().toString().padStart(2, '0');
  const m = (date.getMonth()+1).toString().padStart(2, '0');
  const y = date.getFullYear();

  const hr = date.getHours().toString().padStart(2, '0');
  const min = date.getMinutes().toString().padStart(2, '0');
  const secs = date.getSeconds().toString().padStart(2, '0');

  return `${d}/${m}/${y} ${hr}:${min}:${secs}`;
}

/**
 * @param {number} days
 * @returns {Date}
 */
module.exports.after = (days) => {
  return new Date(Date.now()+(86400000*days));
}

/**
 * @param {number[]} array
 * @returns {number}
 */
module.exports.firstAvailableNumber = (array) => {
  let number = 1;
  while (array.includes(number)) number+= 1;
  return number;
}

/**
 * @param {Error} error
 */
module.exports.printError = (error) => {
  console.error(error.name);
  console.error(error.message);
  console.error(Array.isArray(error.stack) ? error.stack.map(JSON.stringify).join('\n') : error);
}