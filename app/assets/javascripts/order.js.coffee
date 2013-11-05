# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".edit_user").on("ajax:success",(e, data, status, xhr) ->
    notifications_change_submit_button = $(".edit_user input[type=\"submit\"]")
    $(".edit_user #response").html data
    if $("#user_notifications").is(':checked')
      $("#user_notifications").prop('checked', false);
      $("#current_notification_state").html("Email notifications currently on")
      notifications_change_submit_button.val("Turn them off")
    else
      $("#user_notifications").prop('checked', true);
      $("#current_notification_state").html("Email notifications currently off")
      notifications_change_submit_button.val("Turn them on")



  ).bind "ajax:error", (e, xhr, status, error) ->
    $(".edit_user #response").append "There was an error updating, please reload page and try again"