
$(function() {
  $('#footer').hover(function(){
    $('#footer').css('background','rgba(0,0,0,0.3)');
    $('#footer .heart').css('color','#ee8279');
    $('#footer .authors').slideDown();
  });

  $('.date-picker').datepicker({format: 'yyyy-mm-dd'});

  $('.inbox-block textarea').focus(function(){
   $(this).animate({height: 90, width: 420});
  });

});
