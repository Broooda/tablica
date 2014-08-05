$(function()
{
  $('#stand-up-meeting-form').submit(function(event){
      console.log($(this).serializeArray());
        $.ajax('/ajax/stand_up/show',  {data: $(this).serializeArray()}).done(function(data){
          $('#stand-up-meetings').html(data);

          $('.meeting').hover(function(){
            $(this).find(".people").slideDown();
          }, function() {
            $(this).find(".people").slideUp();
          });

        });

        //$('#modal').modal();
        event.preventDefault();
      });

});