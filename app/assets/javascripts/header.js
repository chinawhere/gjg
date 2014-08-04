// 返回顶部
$(function(){
  $('.page-footer').on('click', '.go-top', function () {
    $('body,html').animate({scrollTop:0},1000);
  });
});

// 用户设置
$(function(){
  $('.dropdown-user').hover(function(){
    $(this).children('ul.dropdown-menu').show();
  },function(){
    $(this).children('ul.dropdown-menu').hide();
  })
});