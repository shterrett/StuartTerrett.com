# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("#project_technology_tokens").tokenInput "/technologies/tokens.json",
    prePopulate: $("#project_technology_tokens").data("load")

