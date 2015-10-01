
// MARK: Exports

var exports = module.exports = {};

// MARK: External Dependencies

var crypto = require('crypto');
var request = require('request');

// MARK: Internal Dependencies

var enums = require('../enums');

// MARK: Social Network Info

var client = {
  id: '59b083ff487a4bc1b139b04d74352827',
  secret: 'af774a49592f4e288f46ae202ab2c456'
};

var root = 'https://api.instagram.com/v1';

// MARK: https://instagram.com/developer/secure-api-requests/

var generateUrl = function (endpoint, parameters) {
  var url = '';
  var sig = '';

  for (var key in parameters) {
    if (parameters.hasOwnProperty(key)) {
      url += '&' + key + '=' + parameters[key];
      sig += '|' + key + '=' + parameters[key];
    }
  }

  url = root + endpoint + '?' + url.substring(1);  // replace leading & with ?
  sig = crypto
          .createHmac('sha256', client.secret)
          .update(endpoint + sig)
          .digest('hex');

  return url + '&sig=' + sig;
};

// MARK: Initial Load

exports.initialLoad = function (type, signature, callback) {
  switch (type) {
    case enums.DataType.Feed:
      initialLoadFeed(signature, callback);
      break;
    default:
      return callback('bad type', null, enums.Network.Instagram);
      break;
  }
};

var initialLoadFeed = function (signature, callback) {
  var endpoint = '/users/self/feed';
  var parameters = {
    'access_token': signature.access_token
  };
  var url = generateUrl(endpoint, parameters);

  request(url, function (error, response, body) {
    if (error) {
      return callback(error, null, enums.Network.Instagram);
    }
    else {
      var data = parseResponseBody(body);
      return callback(null,  data, enums.Network.Instagram);
    }
  });
}

var parseResponseBody = function (body) {
  // TODO: parse response body from Instagram into Comblie data model
  return body;
};
