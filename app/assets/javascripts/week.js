headerOffset = 70;
pxPerHour = 50;

function moveNowLine() {
  startHour = startHour || 7;
  endHour = endHour || 23;

  now = new Date();
  if(now.getHours()>startHour && now.getHours()<(endHour+1) ) {
    offset = (now.getHours()+now.getMinutes()/60+now.getSeconds()/3600-startHour)*pxPerHour+headerOffset;
    $('#nowline').css('display','block');
    $('#nowline').css('top',offset+'px');
    $('#nowlinetext').text(now.toLocaleTimeString());
  } else {
    $('#nowline').css('display','none');
  }
  
}

function setUpHoursPlans() {
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

  $('.hours-plan').each(function() {
    start = new Date($(this).attr('start')); // pobierz dane
    end = new Date($(this).attr('end'));
    user = $(this).attr('user');

    if(people.indexOf(user)==-1) { //jeśli nie wstawialiśmy jeszcze użytkownika to dodaj go do array
      people.push(user);
    }
  });

  $('.hours-plan').each(function() {
    start = new Date($(this).attr('start')); // pobierz dane
    end = new Date($(this).attr('end'));
    user = $(this).attr('user');

    if(people.indexOf(user)<colors.length)
      {$(this).css('background-color',colors[people.indexOf(user)]);}

    width = 200/people.length;
    if(width>30) 
      {width=30;}

    $(this).css('left', 5+(width*people.indexOf(user)));
    $(this).css('width', width);

    $(this).animate({
      top: (start.getHours()+start.getMinutes()/60-startHour)*pxPerHour+headerOffset,
      height: (end.getHours()+end.getMinutes()/60-start.getHours()-start.getMinutes()/60)*pxPerHour
    }, 1000);
  });
}

$(function(){
  if(startHour && endHour) {
    setUpHoursPlans();

    moveNowLine();
    setInterval(function(){moveNowLine();}, 1000);
  }
})