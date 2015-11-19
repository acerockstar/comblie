
var exports = module.exports = {};
var rsvp = require('rsvp');

var twitter = require('twitter');
var consumerInfo = {
  key: 'vYYpivIgsxaXdn87lyZQHyA4G',
  secret: 'HD7y34pji4yuTa7Fsfmb8QQtDNLwa6rF7jGmwLSmGWdrSvo1jI'
};
 
exports.feed = function (signature) {
  return new rsvp.Promise(function (resolve, reject) {
    var oauth = {
      consumer_key: consumerInfo.key,
      consumer_secret: consumerInfo.secret,
      access_token_key: signature.access_token,
      access_token_secret: signature.access_token_secret
    };

    var api = new twitter(oauth);
    
    api.get('statuses/home_timeline', function (error, tweets, response) {
      if (error) {
        reject(error);
      }
      else {
        // TODO - restructure to Comblie model
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
