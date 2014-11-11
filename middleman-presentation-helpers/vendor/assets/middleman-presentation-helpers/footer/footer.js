check = function() {
  if ($('.mp-start-slide .present').length > 0) {
    //$('.controls').hide();
    $('.mp-presentation-footer').hide();
    $('.slide-number').hide();
  } else {
    //$('.controls').show();
    $('.mp-presentation-footer').show();
    $('.slide-number').show();
  }
}

$(document).ready( function () {
  check() 
} );

Reveal.addEventListener( 'slidechanged', function( event ) {
  check();
} );
