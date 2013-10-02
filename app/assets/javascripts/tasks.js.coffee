# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

upload = ->
  $(".browser").click ->
    $("#submission_source").click()

  $("#submission_source").change ->
    $("#pretty_file").val $(this).val()

document.addEventListener "page:load", upload
$ upload
