
// MARK: Exports

var exports = module.exports = {};

// MARK: External Dependencies

var rsvp = require('rsvp');

// MARK: Internal Dependencies

var enums = require('../enums');

// MARK: API

var fb = require('fbgraph');
fb.setVersion('2.4');
fb.setAppSecret('17dd50cad942a13c475f4892086dd7cb');
// app-id = 1631910157061175

// MARK: Feed

exports.feedInitial = function (signature) {
  var promise = new rsvp.Promise(function (resolve, reject) {
    fb.get(
      '/me/',
      { access_token: signature.access_token },
      function (error, response) {
        if (error) {
          resolve(null);
        }
        else {
          resolve(response);
        }
      }
    );
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
