
window.comblie = window.comblie || {};

comblie.earlyAccess = function () {
  var userId = comblie.getParameterByName('user');
  if (!userId) {
    window.location.href = '../index.html';
    return;
  }

  // referral links
  $('div.share').find('a').each(function (index, anchor) {
    var anchor = $(anchor),
        newHref = anchor.attr('href') + '?referrer=' + userId;
    anchor.attr('href', newHref);
  });

  // queue position
  comblie.firebase.child('early_access').child(userId).once('value', function (snapshot) {
    if (snapshot.exists()) {
      var position = snapshot.getPriority(), message;
      if (position > 2) {
        message = (position - 1) + ' people ahead of you';
      }
      else if (position == 2) {
        message = '1 person ahead of you';
      }
      else {
        message = '0 people ahead of you';
      }
      $('h2.people').text(message);
      
      $('strong#saved-email').text(snapshot.child('email').val());
    }
    else {
      window.location.href = '../index.html';
    }
  });
};

comblie.earlyAccess.prototype = {

};
