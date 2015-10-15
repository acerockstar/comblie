
// MARK: Exports

var exports = module.exports = {};

// MARK: External Dependencies

var rsvp = require('rsvp');

// MARK: Internal Dependencies

var enums = require('../enums');

// MARK: API

var ig = require('instagram-node-lib');
ig.set('client_id', '59b083ff487a4bc1b139b04d74352827');
ig.set('client_secret', 'af774a49592f4e288f46ae202ab2c456');
ig.set('maxSockets', 10);

// MARK: Feed

exports.feedInitial = function (signature) {
  var promise = new rsvp.Promise(function (resolve, reject) {
    ig.users.self({
      access_token: signature.access_token,
      complete: function (data, pagination) {
        resolve({
          data: data,
          pagination: pagination
        });
      },
      error: function (errorMessage, errorObject, caller) {
        resolve(null);
      }
    });
  });

  return promise;
};

exports.feedScroll = function (signature, url) {
  var promise = new rsvp.Promise(function (resolve, reject) {
    // TODO
    resolve({});
  });

  return promise;
};

// MARK: Messages

exports.notifications = function (signature) {
  var promise = new rsvp.Promise(function (resolve, reject) {
    // TODO
    resolve({});
  });

  return promise;
};

// MARK: Notifications

exports.notifications = function (signature) {
  var promise = new rsvp.Promise(function (resolve, reject) {
    // TODO
    resolve({});
  });

  return promise;
};

// MARK: Profile

exports.profile = function (signature, userId) {
  var promise = new rsvp.Promise(function (resolve, reject) {
    // TODO
    resolve({});
  });

  return promise;
};
