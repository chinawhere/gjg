// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require ckeditor/init


$(document).ready(function(){
	// 活动日历
  $(".nav-first-level").bind('click', function(){
    $('.menu_active').not(this).siblings('.nav-second-level').hide();
    $('.menu_active').not(this).children('span').removeClass('glyphicon-menu-down');
    $('.menu_active').not(this).removeClass('menu_active');
    $(this).children('span').toggleClass('glyphicon-menu-down');
    $(this).siblings('.nav-second-level').first().toggle();
    $(this).toggleClass('menu_active');
  });
  // 如果没有城市信息， 提示用户选择
  if(gon.city_id == null){
    $.get("/cities/select", null, null);
  }
})
