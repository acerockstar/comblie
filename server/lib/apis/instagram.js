
var exports = module.exports = {};
var rsvp = require('rsvp');

var api = require('instagram-node-lib');
api.set('client_id', '59b083ff487a4bc1b139b04d74352827');
api.set('client_secret', 'af774a49592f4e288f46ae202ab2c456');
api.set('maxSockets', 10);

exports.feed = function (signature) {
  return new rsvp.Promise(function (resolve, reject) {
    api.users.self({
      access_token: signature.access_token,
      complete: function (data, pagination) {
        // TODO - restructure to Comblie model
        resolve({
          data: data,
          pagination: pagination
        });
      },
      error: function (errorMessage, errorObject, caller) {
        reject(errorMessage);
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
