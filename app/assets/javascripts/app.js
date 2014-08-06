function rotate(object, degree) {
  object.css({
    '-webkit-transform': 'rotate(' + degree + 'deg)',
    '-moz-transform': 'rotate(' + degree + 'deg)',
    '-ms-transform': 'rotate(' + degree + 'deg)',
    '-o-transform': 'rotate(' + degree + 'deg)',
    'transform': 'rotate(' + degree + 'deg)',
    'zoom': 1
  });
}



$(function() {
  $('#footer').hover(function(){
    $('#footer').css('background','rgba(0,0,0,0.3)');
    $('#footer .heart').css('color','#ee8279');
    $('#footer .authors').slideDown();
  });

  $('.date-picker').datepicker({format: 'yyyy-mm-dd', weekStart: 1});

  $('.inbox-block textarea').focus(function(){
   $(this).animate({height: 90, width: 420});
  });

  clock_animation_start = 0 ;

  setInterval(function(){
    d = new Date();

    clock_animation_start += (1-clock_animation_start)*0.05;
    if (clock_animation_start>0.999) clock_animation_start=1;

    HourDeg = d.getHours()*360/12 + d.getMinutes()*360/12/60;
    MinuteDeg = d.getMinutes()*360/60 + d.getSeconds()*360/60/60;
    SecondDeg = d.getSeconds()*360/60 + d.getMilliseconds()*360/60/1000;

    rotate($('#hour_hand'), HourDeg*clock_animation_start - 180);
    rotate($('#minute_hand'), MinuteDeg*clock_animation_start - 180);
    rotate($('#second_hand'), SecondDeg*clock_animation_start - 180);

  }, 40);



  



});
