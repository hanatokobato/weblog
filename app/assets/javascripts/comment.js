$(document).on('blur', '.edit_comment .comment-field', function(){
  $(this).hide();
  $(this).parents().eq(2).find('.body').show();
});
