
// MARK: Comblie

var comblie = require('./lib/comblie');

// MARK: External Dependencies

var express = require('express');
var bodyParser = require('body-parser');
var firebase = require('firebase');

// MARK: Express

var app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.set('port', (process.env.PORT || 5000));

// MARK: Firebase

var firebaseRef = new firebase('https://comblie.firebaseio.com/');

// MARK: Initial Load

var getInitial = function (req, res, type) {
  var sigs = comblie.parseSignaturesFromRequest(req);
  comblie.initialLoad(type, sigs, function (result) {
    res.status(result.meta.code).send(result);
  });
};

app.post('/feed', function (req, res) {
  getInitial(req, res, comblie.enums.DataType.Feed);
});

app.post('/messages', function (req, res) {
  getInitial(req, res, comblie.enums.DataType.Message);
});

app.post('/notifications', function (req, res) {
  getInitial(req, res, comblie.enums.DataType.Notification);
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
