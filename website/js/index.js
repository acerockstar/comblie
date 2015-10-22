
window.comblie = window.comblie || {};

comblie.index = function () {
  // hide overlay when user clicks outside of it
  $(document).click(function (event) {
    if ($(event.target).closest('#overlay').size() !== 0 && $('#overlay').is(':visible')) {
      $('#overlay').hide();
      $('#access-modal').hide();
      $('#network-modal').hide();
      $('#press-modal').hide();
    }
  });

  $('a#get-access').on('click', $.proxy(this._getEarlyAccessLaunchClick, this));
  $('.access-modal #submit').on('click', $.proxy(this._getEarlyAccessSubmitClick, this));
  $('.form-contact #submit').on('click',$.proxy(this._getEarlyAccessSubmitClick, this));

  $('a#recommend').on('click', $.proxy(this._recommendNetworkLaunchClick, this));
  $('.network-modal #submit').on('click', $.proxy(this._recommendNetworkSubmitClick, this));

  $('.press-section #download').on('click', $.proxy(this._downloadClick, this));

  this._emailModal = $('#modal-email').val('');
  this._emailMain = $('#email1').val('');
  this._emailContact = $('#email2').val('');
  this._overlay = $('#overlay').hide();

  // smooth scroll
  $('a[href^="#"]').on('click', function (event) {
    event.preventDefault();
    var headerHeight = $('.header-section').height(),
        target = $( $(this).attr('href') );
    if (target.size() > 0) {
      $('html, body').animate({
        scrollTop: target.offset().top - headerHeight
      }, 600);
    }
  });
};

comblie.index.prototype = {
  _emailModal: $(),
  _emailMain: $(),
  _emailContact: $(),
  _overlay: $(),

  _commitEmail: function (email) {
    var emailInternal = comblie.formatKeyIn(email);
    
    comblie.firebase.child('early_access_index').child(emailInternal).once('value', function (snapshot) {
      if (snapshot.exists()) {
        window.location.href = 'pages/early-access.html?user=' + snapshot.val();
      }
      else {
        var referrer = comblie.getParameterByName('referrer'),
            query    = comblie.firebase.child('early_access').orderByPriority().limitToLast(1),
            newUser  = comblie.firebase.child('early_access').push({ email: email }, function (error) {
              if (error) {
                alert('We ran into a problem. Please try again.');
              }
              else {
                // index the new user's id
                comblie.firebase.child('early_access_index').child(emailInternal).set(newUser.key());

                // if referred, update referrer's priority
                if (referrer) {
                  comblie.firebase.child('early_access').child(referrer).once('value', function (snapshot) {
                    if (snapshot.exists()) {
                      var priority = snapshot.getPriority(), newPriority;
                      if (priority < 50) {
                        newPriority = priority - 10;
                      }
                      else if (priority < 1000) {
                        newPriority = priority - 100;
                      }
                      else {
                        newPriority = priority - 200;
                      }
                      if (newPriority < 1) {
                        newPriority = 1;
                      }
                      comblie.firebase.child('early_access').child(referrer).setPriority(newPriority);
                    }
                  });
                }
                
                // set the enqueued user's priority (represents position in queue)
                query.on('child_added', function (snapshot) {
                  query.off('child_added');
                  newUser.setPriority(snapshot.getPriority() + 1, function (error) {
                    if (error) {
                      alert('We ran into a problem. Please try again.');
                    }
                    else {
                      window.location.href = 'pages/early-access.html?user=' + newUser.key();
                    }
                  });
                });
              }
            });
      }
    });
  },

  _commitNetwork: function (network) {
    comblie.firebase.child('recommended_networks').child(network).once('value', function (snapshot) {
      comblie.firebase.child('recommended_networks').child(network).set((snapshot.val() || 0) + 1);
    });
  },

  _isValidEmail: function (email) {
    var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    return regex.test(email);
  },

  _showOverlay: function (id) {
    this._overlay.show();
    $('#' + id).show();
  },

  _hideOverlay: function (id) {
    this._overlay.hide();
    $('#' + id).hide();
  },

  _getEarlyAccessLaunchClick: function (event) {
    event.preventDefault();
    this._showOverlay('access-modal');
  },

  _getEarlyAccessSubmitClick: function (event) {
    event.preventDefault();

    var email, button = $(event.target).closest('button');

    if (this._overlay.is(':visible') || button.hasClass('comblie-modal')) {
      email = this._emailModal.val();
    }
    else if (button.hasClass('comblie-main')) {
      email = this._emailMain.val();
    }
    else {
      email = this._emailContact.val();
    }

    if (this._isValidEmail(email)) {
      this._commitEmail(email);
      this._hideOverlay('access-modal');
    }

    this._emailModal.val('');
    this._emailMain.val('');
    this._emailContact.val('');
  },

  _recommendNetworkLaunchClick: function (event) {
    event.preventDefault();
    this._showOverlay('network-modal');
  },

  _recommendNetworkSubmitClick: function (event) {
    event.preventDefault();
    var network = $('#modal-network').val();
    if (network.length > 0) {
      this._commitNetwork(network);
      $('#modal-network').val('');
      this._hideOverlay('network-modal');
    }
  },

  _downloadClick: function (event) {
    event.preventDefault();
    this._showOverlay('press-modal');
  }
};
