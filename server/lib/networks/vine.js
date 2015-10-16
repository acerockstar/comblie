
// MARK: Exports

var exports = module.exports = {};

// MARK: External Dependencies

var rsvp = require('rsvp');

// MARK: Internal Dependencies

var enums = require('../enums');

// MARK: API

var Vineapple = require('vineapple');

// MARK: Feed

exports.feedInitial = function (signature) {
  var promise = new rsvp.Promise(function (resolve, reject) {
    var vine = new Vineapple({
      key: signature.access_token,
      id: signature.id
    });

    vine.user(signature.id, function (error, posts) {
      if (error) {
        resolve(null);
      }
      else {
        vine.likes(signature.id, function (error, likes) {
          if (error) {
            resolve({
              posts: posts
            });
          }
          else {
            resolve({
              posts: posts,
              likes: likes
            });
          }
        });
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
