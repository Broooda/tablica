$(function() {
  $('.heart').click(function() {
    $('body').append('<div id="credits-fog"></div>');
    $('#credits-fog').fadeIn();

    $('<img id="credits-photo" src="/assets/folks.jpg">').load(function() {
      $(this).appendTo('body').addClass('throw_photo');

      $('<img/>').attr('src', '/assets/credits_sheet.png').load(function() {
        $(this).remove(); //

        $('body').append('<div id="credits-made"></div>');    
        $('body').append('<div id="credits-with"></div>');    
        $('body').append('<div id="credits-love"></div>');    
        $('body').append('<div id="credits-forbinar"></div>');

        $('#credits-made').delay( 1300 ).fadeIn( 700 );
        $('#credits-with').delay( 1800 ).fadeIn( 700 );
        $('#credits-love').delay( 2300 ).fadeIn( 700 );
        $('#credits-forbinar').delay( 2800 ).fadeIn( 700 );


      });
    });
  });

  //$('.heart').click();
});