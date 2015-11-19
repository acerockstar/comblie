
var comblie = require('./lib/comblie');

var express = require('express');
var bodyParser = require('body-parser');
var firebase = require('firebase');

var app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.set('port', (process.env.PORT || 5000));

var firebaseRef = new firebase('https://comblie.firebaseio.com/');

// MARK: Initial Load

var getInitial = function (req, res, type) {
  var sigs = comblie.parseSignatures(req);
  comblie.initialLoad(type, sigs, function (result) {
    res.status(result.meta.code).json(result);
  });
};

app.post('/feed', function (req, res) {
  getInitial(req, res, comblie.enums.data.feed);
});

app.post('/messages', function (req, res) {
  getInitial(req, res, comblie.enums.data.message);
});

app.post('/notifications', function (req, res) {
  getInitial(req, res, comblie.enums.data.notification);
});

// MARK: Scroll

// TODO

// MARK: Profile

// TODO

// MARK: Real-Time Updates

// TODO

// MARK: Start

app.listen(app.get('port'), function() {
  console.log('server is running on port', app.get('port'));
});
