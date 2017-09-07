$(document).on('blur', '.edit_comment .comment-field', function(){
  $(this).hide();
  $(this).parent().parent().parent().find('.body').show();
});
