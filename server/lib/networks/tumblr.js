
// MARK: Exports

var exports = module.exports = {};

// MARK: External Dependencies

var crypto = require('crypto');
var request = require('request');

// MARK: Internal Dependencies

var enums = require('../enums');

// MARK: Social Network Info

var client = {
  id: '',
  secret: ''
};

var root = 'https://...';

// MARK: Initial Load

exports.initialLoad = function (type, signature, callback) {
  // type is from enums.DataType
  // signature is an object with `access_token` and `id`

  // TODO: Fetch feed data and invoke `callback`.

  // Callback signature:
  // function (error, network, data) { }
  //   error: pass null if successful, { message: 'description' } otherwise
  //   network: from enums.Network
  //   data: the feed data (in Comblie format)

  return callback(null, {}, enums.Network.Tumblr);
};
