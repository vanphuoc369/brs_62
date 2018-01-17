$(document).ready(function(){
  $('#id_book').click(function(){
    var url= '/books/show';
    $('#right_body').load(url);
    $('body,html').animate({scrollTop: 0}, 'slow');
  });
});

function showChilds(){
  x = document.getElementById('list-childs');
  if(x.className.indexOf('w3-show') == -1){
    x.className += ' w3-show';
    x.previousElementSibling.className += ' w3-green';
  }
  else{
    x.className = x.className.replace(' w3-show', '');
    x.previousElementSibling.className =
      x.previousElementSibling.className.replace(' w3-green', '');
  }
}

$(document).ready(function(){
  $.fn.stars = function(){
    return $(this).each(function(){
      var rating = parseFloat($(this).data('rating'));
      var numStars = parseFloat($(this).data('numStars'));
      var fullStar = new Array(Math.floor(rating + 1)).join("<i class='fa fa-star r'></i>");
      var halfStar = ((rating % 1) !== 0) ? "<i class='fa fa-star-half-empty r'></i>": '';
      var noStar = new Array(Math.floor(numStars + 1 - rating)).join("<i class='fa fa-star-o r'></i>");
      $(this).html(fullStar + halfStar + noStar);
      });
  }
  $('.stars').stars();
});

$(document).ready(function() {
  $('#my_table').DataTable();
});
