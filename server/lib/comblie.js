
var exports = module.exports = {};

// MARK: Enums

var enums = exports.enums = require('./enums');

// MARK: Networks

var networks = {};
for (var network in enums.Network) {
  if (enums.Network.hasOwnProperty(network)) {
    networks[network] = require('./networks/' + network.toLowerCase());
  }
}

// MARK: Utils

var tracker    = require('./utils/tracker');
var aggregator = require('./utils/aggregator');

// MARK: Helpers

exports.parseSignaturesFromRequest = function (request) {
  var meta = request.body.meta || {};
  var signatures = {};

  signatures[enums.Network.Facebook]  = meta.facebook   || null;
  signatures[enums.Network.Twitter]   = meta.twitter    || null;
  signatures[enums.Network.Instagram] = meta.instagram  || null;
  signatures[enums.Network.Vine]      = meta.vine       || null;
  signatures[enums.Network.Tumblr]    = meta.tumblr     || null;

  return signatures;
};

// MARK: Initial Load

exports.initialLoad = function (type, signatures, callback) {
  var t = new tracker();
  var a = new aggregator(type);

  var initialLoadDone = function (error, data, network) {
    if (error) {
      a.addError(network, error);
    }
    else {
      a.addData(network, data);
    }
    if (t.finished(network)) {
      return callback(null, a.getData());
    }
  };

  for (var network in networks) {
    if (networks.hasOwnProperty(network)) {
      signatures[network] && t.started(network) &&
        networks[network].initialLoad(type, signatures[network], initialLoadDone);
    }
  }
}
