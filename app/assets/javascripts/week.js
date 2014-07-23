function moveNowLine() {
  startHour = startHour || 7;
  endHour = endHour || 23;

  now = new Date();
  if(now.getHours()>startHour && now.getHours()<(endHour+1) ) {
    offset = (now.getHours()+now.getMinutes()/60+now.getSeconds()/3600-startHour)*50+70;
    $('#nowline').css('display','block');
    $('#nowline').css('top',offset+'px');
    $('#nowlinetext').text(now.toLocaleTimeString());
  } else {
    $('#nowline').css('display','none');
  }
  
}

$(function(){
  if(startHour && endHour) {
    moveNowLine();
    setInterval(function(){moveNowLine();}, 1000);
  }
})