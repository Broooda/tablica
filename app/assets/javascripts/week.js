function moveNowLine() {
  now = new Date();
  if(now.getHours()>7 && now.getHours()<23 ) {
    offset = (now.getHours()+now.getMinutes()/60+now.getSeconds()/3600-7)*50+50;
    $('#nowline').css('display','block');
    $('#nowline').css('top',offset+'px');
    $('#nowlinetext').text(now.toLocaleTimeString());
  } else {
    $('#nowline').css('display','none');
  }
  
}

$(function(){
  moveNowLine();
  setInterval(function(){moveNowLine();}, 1000);
})