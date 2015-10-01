
// MARK: Comblie

var comblie = require('./lib/comblie');

// MARK: External Dependencies

var https = require('https');
var express = require('express');
var bodyParser = require('body-parser');
var crypto = require('crypto');
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
  comblie.initialLoad(
    type,
    comblie.parseSignaturesFromRequest(req),
    function (error, data) {
      if (error) {
        res.status(400).send(error);
      }
      else {
        res.status(200).send(data);
      }
    }
  );
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

// MARK: Real-Time Updates

// TODO

// MARK: Start

app.listen(app.get('port'), function() {
  console.log('server is running on port', app.get('port'));
});
