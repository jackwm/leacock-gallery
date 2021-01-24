//= require javascripts/jquery_ujs.js
//= require javascripts/bootstrap/tooltip.js
//= require javascripts/bootstrap/popover.js
//= require javascripts/bootstrap/dropdown.js
//= require javascripts/bootstrap/carousel.js
//= require javascripts/bootstrap/modal.js
//= require javascripts/jquery.lightbox.js

$(document).ready(function(){
  $('.js-oeuvre').carousel({
    interval: 5000
  });

  $('#js-front').carousel({
    interval: 5000
    
  });

  $('.js-sold-dot').tooltip();

  $('.js-artwork-details').popover({
    delay: { show: 500, hide: 100 },
    html: true,
    placement: 'bottom',
    trigger: 'hover'
  });

  $('.product-images a').lightBox();
});
