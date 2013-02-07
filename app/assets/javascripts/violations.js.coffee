# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  lastQueryData = {}
  $('#violation_license_plate').typeahead
    source: (query, process) ->
      $.get '/violators/autocomplete.json', {query: query}, (data) ->
        lastQueryData = data
        plates = []
        $.map lastQueryData.violators, (e, i) ->
          plates.push e.license
        process plates
    updater: (item) ->
      $.map lastQueryData.violators, (e, i) ->
        if e.license == item
          console.log e

          if e.organization_id == null
            $('.organization .name').text e.license+" doesn't belong to an organization"
            $('.organization label.control-label').hide()
            $('.organization').show()
          else
            $('.organization .name').text e.organization.name
            $('.organization').show()
            $('.organization-offences .total').text 'TODO'
            $('.organization-offences').show()
      item