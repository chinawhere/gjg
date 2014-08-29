$(function(){
  $(".comment_info").on('click', 'a.deleteComment', function(){
    var $this = $(this),
        comment_id = $this.data('reply_to_comment_id'),
        $commentPanel = $this.closest('.commentPanel');
    $.post('/comments/destroy_comment', { comment_id : comment_id, current_user_id: Chinawhere.current_user_id }, function (data) {
      if (data.success) {
        $this.closest('li').remove();
        console.log($commentPanel.find('ul:first li'));
        console.log($commentPanel.find('ul:first li').length == 0);
        if ($commentPanel.find('ul:first li').length == 0)
          $commentPanel.find('.commentLoading').empty().append('<p>暂无评论...</p>').show();
      }
    }, 'json');
  });
});

$(function(){
  $('.commentPanel').each(function () {
    var $this = $(this);
    var auto_load = $this.data('auto_load');
    if (auto_load == 'on') loadComment($this);
  });

  function loadComment ($commentPanel) {
    var commentable_id = $commentPanel.data('commentable_id'),
        commentable_type = $commentPanel.data('commentable_type'),
        paramters = { commentable_id : commentable_id, commentable_type : commentable_type };
    $commentPanel.find('textarea').val('');
    if ($commentPanel.find('ul.comment_li').length == 0) {
      $.get('/comments', paramters, function (data) {
        if (data.success){
          if (data.html == '') {
            $('.commentLoading').empty().append('<p>暂无评论...</p>');
          } else {
            $('.commentLoading').hide();
          }
        // if ($commentPanel.find('.commentsCount').length == 1)
        //   $commentPanel.find('.commentsCount i').text(data.data.comments_count);
          $commentPanel.find('ul:first').empty().append($(data.html));
        }
      }, 'json');
    }
  };
})
$(function(){
  $('.comment_info').on('click', 'a.replyToComment', function () {
    var $this = $(this);
    // var $reply = $this.parents('.com_li');
    var $replyBox = $this.parents('.com_li').find('.reply_box');
    var user_name = $this.data('user_name'),
        reply_to_user_id = $this.data('reply_to_user_id'),
        reply_to_comment_id = $this.data('reply_to_comment_id');
    var reply_text = '回复' + user_name + '：';
    $replyBox.find('.postCommentBtn').attr('data-reply_to_user_id', reply_to_user_id)
      .attr('data-reply_to_comment_id', reply_to_comment_id);
    // if ($reply.is(':hidden')) $reply.show();
    $replyBox.show().find('textarea').val('').focus().val(reply_text);
  });

  $(".comment_info").on('click', 'a.postCommentBtn', function(){
    var $this = $(this);
    if(!Chinawhere.current_user_id ){
      $("span.unload_warning").css("display","block");
    }else{
      var $commentPanel = $this.parents('.commentPanel');
      var commentable_id = $commentPanel.data('commentable_id');
      var commentable_type = $commentPanel.data('commentable_type');
      var $content = $this.parents('.reply_box').find('textarea');

      var content = $content.val(),
          reply_to_user_id = $this.data('reply_to_user_id'),
          p_comment_id = $this.data('p_comment_id'),
          reply_to_comment_id = $this.data('reply_to_comment_id');
      var paramters = {
        current_user_id: Chinawhere.current_user_id,
        commentable_id : commentable_id,
        commentable_type : commentable_type,
        content : content,
        reply_to_user_id : reply_to_user_id,
        reply_to_comment_id : reply_to_comment_id,
        p_comment_id : p_comment_id
      };
      if ($.trim(content).length < 1) return false;
      if ($('.commentLoading').length > 0) $('.commentLoading').hide();
      $.post('/comments', paramters, function (data) {
        console.log(data);
        if (data.success) {
          var $html = $(data.html);
          if (p_comment_id == '' || p_comment_id == undefined) {
            $commentPanel.find('ul:first').append($html);
          } else {
            $this.closest('.reply_box').prev().append($html);
          }
          $content.val('').focus().keyup();
        }
      }, 'json');
    }
  });
})
