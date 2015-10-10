
window.comblie = window.comblie || {};

comblie.firebase = new Firebase('https://comblie.firebaseio.com/');

comblie.getParameterByName = function (name) {
  name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
  var regex = new RegExp('[\\?&]' + name + '=([^&#]*)'),
      results = regex.exec(location.search);
  return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
};
