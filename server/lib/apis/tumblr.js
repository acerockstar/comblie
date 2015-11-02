
var exports = module.exports = {};
var rsvp = require('rsvp');

var tumblr = require('tumblr');

exports.feed = function (signature) {
  return new rsvp.Promise(function (resolve, reject) {
    var oauth = {
      consumer_key: 'IJLNxgo0hZ4oPLa5eb86BMrgks2HOZbZ5y8iUhYtSHEWPdE50J',
      consumer_secret: 'SCo8PWk4ET5bH3RzrgVCp3HOjJ8GSA9ZP2ajk8s2eImE9Yk7id',
      token: signature.access_token,
      token_secret: signature.access_token_secret
    };

    var user = new tumblr.User(oauth);

    user.likes(function (error, response) {
      if (error) {
        console.log('error-feed-tumblr', error);
        reject({});
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
