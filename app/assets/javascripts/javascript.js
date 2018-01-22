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

$(document).ready(function() {
  $('#my_table').DataTable();
});

function hidden_comment_edit(comment_id) {
  $('#comment_' + comment_id).remove();
}

$(document).ready(function() {
  $('#review-paginate a').attr('data-remote', 'true');
});

$(document).ready(function() {
  $('#request-paginate a').attr('data-remote', 'true');
});
