/* 
do osoby, która będzie chciała ogarnąć ten kod:

  przepraszam :(

*/

headerOffset = 70;
pxPerHour = 50;

function moveNowLine() {
  startHour = startHour || 7;
  endHour = endHour || 23;

  now = new Date();
  if(now.getHours()>=startHour && now.getHours()<(endHour+1) ) {
    offset = (now.getHours()+now.getMinutes()/60+now.getSeconds()/3600-startHour)*pxPerHour+headerOffset;
    $('#nowline').css('display','block');
    $('#nowline').css('top',offset+'px');
    $('#nowlinetext').text(now.toLocaleTimeString());
  } else {
    $('#nowline').css('display','none');
  }
  
}

function setUpHoursPlans(tags) {
  console.log(tags);

  colors=[
   'hsl(30,75%,50%)',
   'hsl(50,75%,50%)',
   'hsl(70,75%,50%)',
   'hsl(90,75%,50%)',
  'hsl(110,75%,50%)',
  'hsl(130,75%,50%)',
  'hsl(150,75%,50%)',
  'hsl(170,75%,50%)',
  'hsl(190,75%,50%)',
  'hsl(210,75%,50%)',
  'hsl(230,75%,50%)',
  'hsl(250,75%,50%)',
  'hsl(270,75%,50%)',
  'hsl(290,75%,50%)']
  people=[];

  $('.hours-plan[tags*="'+tags+'"]').each(function() {
    start = new Date($(this).attr('start')); // pobierz dane
    end = new Date($(this).attr('end'));
    user = $(this).attr('user');

    if(people.indexOf(user)==-1) { //jeśli nie wstawialiśmy jeszcze użytkownika to dodaj go do array
      people.push(user);
    }
  });

  $('.hours-plan').stop(true).animate({width: 0, height:0});

  $('.hours-plan[tags*="'+tags+'"]').each(function() {
    start = new Date($(this).attr('start')); // pobierz dane
    end = new Date($(this).attr('end'));
    user = $(this).attr('user');

    if(tags==' ') { //only when everybody onboard
      if(people.indexOf(user)<colors.length)
        {$(this).css('background-color',colors[people.indexOf(user)]);}
    }

    width = 200/people.length;
    //if(width>30) {width=30;}

    //$(this).css('left', 5+(width*people.indexOf(user)));
    //$(this).css('width', width-2);
    //$(this).css('top', (start.getHours()+start.getMinutes()/60-startHour)*pxPerHour+headerOffset);
    //$(this).css('height', (end.getHours()+end.getMinutes()/60-start.getHours()-start.getMinutes()/60)*pxPerHour);

    $(this).stop(true).animate({
      left: 5+(width*people.indexOf(user)),
      width: width-2,
      top: (start.getHours()+start.getMinutes()/60-startHour)*pxPerHour+headerOffset,
      height: (end.getHours()+end.getMinutes()/60-start.getHours()-start.getMinutes()/60)*pxPerHour
    }, 1000);
  });
}

$(function(){
  $('.man-in-work').tooltip();

  $('#datepicker input').datepicker({format: 'yyyy-mm-dd', weekStart: 1}).on('changeDate', 
    function(ev){
      action = $(this).attr('act');
      if(action=='showtime')
        $(this).parent('form').attr('action','/week/time/'+$(this).val());
      else if(action=='showpeople')
        $(this).parent('form').attr('action','/week/people/'+$(this).val());
      
      $(this).parent('form').submit();

    });

  $('#people-picker > span.by-tags').popover({html: true, content: '<input id="people-picker-input" placeholder="name, surname or tags">'}).on('shown.bs.popover', function () {
    $('.popover-content').append($('.all-tags').clone());

    $('.popover-content .all-tags').slideDown();

    $('.popover-content .all-tags span').click(function(){
      $('#people-picker-input').val($(this).text()).keyup();
    });

    $('#people-picker-input').keyup(function(){
      tags = $(this).val();
      tags = tags || " ";

      if(view=="time")
        { setUpHoursPlans(tags); }
      else if(view=="people") {

        $('.hour').stop(true).slideUp();
        $('.hour[tags*="'+tags+'"]').stop(true).slideDown();
      }
    });
  });

  $('#people-picker > span.only-me').click(function(){
    tags=$(this).attr('me');

    if(view=="time")
      { setUpHoursPlans(tags); }
    else if(view=="people") {
      $('.hour').stop(true).slideUp();
      $('.hour[tags*="'+tags+'"]').stop(true).slideDown();
    }
  });


  startHour = startHour || false;
  endHour = endHour || false;

  if(startHour && endHour) {
    setUpHoursPlans(' ');  

    $('.hours-plan').tooltip();

    moveNowLine();
    setInterval(function(){moveNowLine();}, 1000);



    $('.hours-plan').hover(function(){
      $('.tooltip-inner').css('background-color', $(this).css('background-color'));
      $('.tooltip-arrow').css('display', 'none');

      $('.hours-plan').not('[user="'+$(this).attr('user')+'"]').stop(true,true).fadeTo(500,0.4);
      $('.hours-plan[user="'+$(this).attr('user')+'"]').stop(true,true).fadeTo(500,1);
    }, function() {
      $('.hours-plan').stop(true,true).fadeTo(500,0.8);
    });
  }
});