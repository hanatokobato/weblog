$(document).ready(function(){
  setTimeout(function(){
        $("#flash").slideUp();
    }, 2000);

  $('body').on('click', '.comment-link', function() {
    $(this).parent().find('.post-loadding-comments').toggle();
  });
});

$(document).on('blur', '.edit_comment .comment-field', function(){
  $(this).hide();
  $(this).parent().parent().parent().find('.body').show();
});

