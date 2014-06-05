// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
// OMG THE ORDER OF THESE REQUIRED's matters so much  aaaaaaaaaaaaaaaaaaaaah
//
//= require bootstrap
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function() {
  $("#all_tickets th a, #all_tickets .pagination a").live("click", function() {
    $.getScript(this.href);
    //alert("You clicked");
    return false;
  });
  $("#tickets_search input").keyup(function() {
    $.get($("#tickets_search").attr("action"), $("#tickets_search").serialize(), null, "script");
    return false;
  });
});

