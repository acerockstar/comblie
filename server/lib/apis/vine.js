
var exports = module.exports = {};
var rsvp = require('rsvp');

var vine = require('vineapple');

exports.feed = function (signature) {
  var promise = new rsvp.Promise(function (resolve, reject) {
    var api = new vine({
      key: signature.access_token,
      id: signature.id
    });

    var promises = {
      posts: api.user(signature.id),
      likes: api.likes(signature.id)
    };

    rsvp.hash(promises)
      .then(function (results) {
        resolve(results);
      })
      .catch(function (error) {
        console.log('error-feed-vine', error);
        resolve({});
      });
  });

  return promise;
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
