
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
  $('p.comblie-referral-link').text('http://www.comblie.com?referrer=' + userId);

  // ...'s
  comblie.firebase.child('early_access').child(userId).once('value', function (snapshot) {
    if (snapshot.exists()) {
      // email
      $('strong#saved-email').text(snapshot.child('email').val());
    
      // num people in front
      var userPosition = snapshot.getPriority(), aheadMessage;
      if (userPosition > 2) {
        aheadMessage = (userPosition - 1) + ' people ahead of you';
      }
      else if (userPosition == 2) {
        aheadMessage = '1 person ahead of you';
      }
      else {
        aheadMessage = '0 people ahead of you';
      }
      $('div.people > h1').text(aheadMessage);
      
      // num people behind
      comblie.firebase.child('early_access').orderByPriority().limitToLast(1).on('child_added', function (snapshot) {
        var numPeopleBehind = snapshot.getPriority() - userPosition, behindMessage;
        if (numPeopleBehind !== 1) {
          behindMessage = (numPeopleBehind) + ' people behind you';
        }
        else {
          behindMessage = '1 person behind you';
        }
        $('div.people > h4').text(behindMessage);
      });
    }
    else {
      window.location.href = '../index.html';
    }
  });
};

comblie.earlyAccess.prototype = {

};
