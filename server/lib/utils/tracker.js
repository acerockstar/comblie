
var enums = require('../enums');

module.exports = function () {
  this.statuses = {};
};

module.exports.prototype.started = function (network) {
  this.statuses[network] = true;  // true if started, false if finished;
  return true;
};

module.exports.prototype.finished = function (network) {
  this.statuses[network] = false;

  for (var network in enums.Network) {
    if (enums.Network.hasOwnProperty(network)) {
      if (this.statuses[network] === true) {
        return false;
      }
    }
  }

  return true;
};
