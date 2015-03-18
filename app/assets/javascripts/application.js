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
//= require_tree .
$(document).ready(function(){
  $(".nav-first-level").bind('click', function(){
    $('.menu_active').not(this).siblings('.nav-second-level').hide();
    $('.menu_active').not(this).children('span').removeClass('glyphicon-menu-down');
    $('.menu_active').not(this).removeClass('menu_active');
    $(this).children('span').toggleClass('glyphicon-menu-down');
    $(this).siblings('.nav-second-level').first().toggle();
    $(this).toggleClass('menu_active');
  })
})
