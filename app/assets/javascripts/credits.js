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

        $('body').append('<div id="credits-justyna"></div>');
        $('body').append('<div id="credits-adam"></div>'); 
        $('body').append('<div id="credits-kamil"></div>'); 
        $('body').append('<div id="credits-maciek"></div>'); 
        $('body').append('<div id="credits-przemek"></div>'); 

        $('#credits-made').delay( 1300 ).fadeIn( 700 );
        $('#credits-with').delay( 1800 ).fadeIn( 700 );
        $('#credits-love').delay( 2300 ).fadeIn( 700 );
        $('#credits-forbinar').delay( 2800 ).fadeIn( 700 );

        $('#credits-justyna').delay( 3700 ).fadeIn( 700 );
        $('#credits-kamil').delay( 4200 ).fadeIn( 700 );
        $('#credits-przemek').delay( 4700 ).fadeIn( 700 );
        $('#credits-maciek').delay( 5200 ).fadeIn( 700 );
        $('#credits-adam').delay( 5700 ).fadeIn( 700 );


      });
    });
  });

  //$('.heart').click();
});