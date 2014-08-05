$(function()
{
  $('#stand-up-meeting-form').submit(function(event){
      console.log($(this).serializeArray());
        $.ajax('/ajax/stand_up/show',  {data: $(this).serializeArray()}).done(function(data){
          $('#stand-up-meetings').html(data);
        });

        //$('#modal').modal();
        event.preventDefault();
      });
});