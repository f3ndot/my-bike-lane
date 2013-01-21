# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  $('#violation_license_plate').typeahead
    source: (query, process) ->
      $.get '/violators/plates', {query: query}, (data) ->
        process data.options
    # updater: (item) ->
    #   item