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
//= require kindeditor
//= require jquery_ujs
//= require_directory .

$(document).ready(function(){
  // 如果没有城市信息， 提示用户选择
  if(gon.city_id == null){
    $.get("/cities/select", null, null);
  }

  $("#btn-pop-submit").bind('click', null, function () {
    console.log("clicked");
    $("#myModal form").submit();
  })
})
