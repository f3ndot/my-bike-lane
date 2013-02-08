# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  lastQueryData = {}
  $('#violation_violator_attributes_license').keyup ->
    $('.organization, .organization-offences').fadeOut() if $(this).val().length == 0
  $('#violation_violator_attributes_license').typeahead
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
            # $('.organization .name').text e.license+" doesn't belong to an organization"
            # $('.organization label.control-label').hide()
            # $('.organization').fadeIn()
            $('#violation_violator_attributes_organization_id').val ''
          else
            # $('.organization .name').text e.organization_name
            # $('.organization').fadeIn()
            # $('.organization-offences .total').text e.organization_offences
            # $('.organization-offences').fadeIn()
            $('#violation_violator_attributes_organization_id').val e.organization_id
      item