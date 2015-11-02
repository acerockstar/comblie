
var exports = module.exports = {};
var rsvp = require('rsvp');

var api = require('fbgraph');
api.setVersion('2.5');
api.setAppSecret('17dd50cad942a13c475f4892086dd7cb');
// app-id = 1631910157061175

exports.feed = function (signature) {
  return new rsvp.Promise(function (resolve, reject) {
    api.get('/me/feed', { access_token: signature.access_token }, function (error, response) {
      if (error) {
        console.log('error-feed-facebook', error);
        resolve({});
      }
      else {
        resolve(response);
      }
    });
  });
};

exports.messages = function (signature) {
  return new rsvp.Promise(function (resolve, reject) {
    // TODO
    resolve({});
  });
};

exports.notifications = function (signature) {
  return new rsvp.Promise(function (resolve, reject) {
    // TODO
    resolve({});
  });
};

exports.profile = function (signature, userId) {
  return new rsvp.Promise(function (resolve, reject) {
    // TODO
    resolve({});
  });
};
