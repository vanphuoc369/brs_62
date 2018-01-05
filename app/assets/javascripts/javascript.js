$(document).ready(function(){
  $('#id_book').click(function(){
    var url= '/books/show';
    $('#right_body').load(url);
    $('body,html').animate({scrollTop: 0}, 'slow');
  });
});
