$(function(){
  $('#datetimepicker1').datepicker({format: 'yyyy-mm-dd'});
  $('#datetimepicker2').datepicker({format: 'yyyy-mm-dd'});

  $('#post_stat').click(function(e){
    $('#statistic_type').val('posts');
  });

  $('#common_post_stat').click(function(e){
    $('#statistic_type').val('common_posts');
  });

  $('#user_stat').click(function(e){
    $('#statistic_type').val('new_users');
  });

  $('#active_user_stat').click(function(e){
    $('#statistic_type').val('active_users');
  });
});
