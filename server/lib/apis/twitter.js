
var exports = module.exports = {};
var rsvp = require('rsvp');

var twitter = require('twitter');
 
exports.feed = function (signature) {
  return new rsvp.Promise(function (resolve, reject) {
    var oauth = {
      consumer_key: 'vYYpivIgsxaXdn87lyZQHyA4G',
      consumer_secret: 'HD7y34pji4yuTa7Fsfmb8QQtDNLwa6rF7jGmwLSmGWdrSvo1jI',
      access_token_key: signature.access_token,
      access_token_secret: signature.access_token_secret
    };

    var api = new twitter(oauth);
    
    api.get('statuses/home_timeline', function (error, tweets, response) {
      if (error) {
        console.log('error-feed-twitter', error);
        reject({});
      }
      else {
        resolve(tweets);
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
