
var exports = module.exports = {};

// MARK: External Dependencies

var rsvp = require('rsvp');

// MARK: Enums

var enums = exports.enums = require('./enums');

// MARK: Networks

var networks = {};
for (var network in enums.Network) {
  if (enums.Network.hasOwnProperty(network)) {
    networks[network] = require('./networks/' + network.toLowerCase());
  }
}

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

// MARK: Initial

exports.initialLoad = function (type, signatures, callback) {
  var promises = {};
  
  for (var network in networks) {
    if (networks.hasOwnProperty(network)) {
      if (signatures[network]) {
        switch (type) {
          case enums.DataType.Feed:
            promises[network] = networks[network].feedInitial(signatures[network]);
            break;
          default:
            break;
        }
      }
    }
  }

  rsvp.hash(promises).then(function (results) {
    callback({
      meta: {
        code: 200
      },
      response: results
    });
  }).catch(function (error) {
    callback({
      meta: {
        code: 400
      },
      response: error
    });
  });
};

// MARK: Scroll

// TODO
