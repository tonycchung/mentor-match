# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".roleswithjs").show()
  $(".rolesnojs").hide()
  $("#rolestudent").click (event)->
    event.preventDefault()
    $(@).removeClass("alert")
    $("#rolementor").addClass("alert")
    $("#user_role_student").prop("checked", true)
  $("#rolementor").click (event)->
    event.preventDefault()
    $(@).removeClass("alert")
    $("#rolestudent").addClass("alert")
    $("#user_role_mentor").prop("checked", true)