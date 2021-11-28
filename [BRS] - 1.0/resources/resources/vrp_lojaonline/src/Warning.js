module.exports = class Warning extends Error {

  constructor(message) {
    super(message);
    this.name = 'Warning';
  }
}