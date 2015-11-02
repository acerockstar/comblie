
var exports = module.exports = {};
var _ = require('lodash');
var rsvp = require('rsvp');
var enums = exports.enums = require('./enums');
var apis = _.mapValues(enums.network, function (network) {
  return require('./apis/' + network);
});

exports.parseSignatures = function (request) {
  var meta = request.body.meta || {};
  var signatures = {};

  signatures[enums.network.facebook]  = meta.facebook   || null;
  signatures[enums.network.twitter]   = meta.twitter    || null;
  signatures[enums.network.instagram] = meta.instagram  || null;
  signatures[enums.network.vine]      = meta.vine       || null;
  signatures[enums.network.tumblr]    = meta.tumblr     || null;

  return signatures;
};

exports.initialLoad = function (type, signatures, callback) {
  var promises = {};

  _.each(apis, function (api, network) {
    var signature = signatures[network];
    if (signature) {
      switch (type) {
        case enums.data.feed:
          promises[network] = api.feed(signature);
          break;
        default:
          break;
      }
    }
  });

  rsvp.hash(promises)
    .then(function (results) {
      callback({
        meta: {
          code: 200
        },
        response: results
      });
    })
    .catch(function (error) {
      callback({
        meta: {
          code: 400
        },
        response: error
      });
    });
};
