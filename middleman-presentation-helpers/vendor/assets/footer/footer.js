check = function() {
  if ($('.mp-start-slide .present').length > 0) {
    $('.mp-copyright-notice').hide();
    $('.slide-number').hide();
  } else {
    $('.mp-copyright-notice').show();
    $('.slide-number').show();
  }
}

$(document).ready( function () {
  check() 
} );

Reveal.addEventListener( 'slidechanged', function( event ) {
  check();
} );
