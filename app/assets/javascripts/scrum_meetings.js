$(function()
{
  $('#stand-up-meeting-form').submit(function(event){
        $('#stand-up-meetings').slideUp();
        $('#stand-up-loader').slideDown();

        $.ajax('/ajax/stand_up/show',  {data: $(this).serializeArray()}).done(function(data){
          $('#stand-up-meetings').slideDown();
          $('#stand-up-loader').slideUp();

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