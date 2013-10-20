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
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap
toggleItemEntryMethods = function () {
    if ($("#item_type_text_box").is(':hidden')) {
        $("#item_type_text_box").show();
        $("#item_type_text_box #item_item_type").prop('disabled', false);
        $("#item_type_dropdown").hide();
        $("#item_type_dropdown #item_item_type").prop('disabled', true);
    } else {
        $("#item_type_dropdown").show();
        $("#item_type_dropdown #item_item_type").prop('disabled', false);
        $("#item_type_text_box").hide();
        $("#item_type_text_box #item_item_type").prop('disabled', true);
    }
};