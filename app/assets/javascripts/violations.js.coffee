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
        $.map lastQueryData, (e, i) ->
          plates.push e.violator.license
        process plates
    updater: (item) ->
      $.map lastQueryData, (e, i) ->
        if e.violator.license == item
          console.log e

          if e.violator.organization == null
            $('#violation_violator_attributes_organization_id').val ''
          else
            $('#violation_violator_attributes_organization_id').val e.violator.organization.id
      item

  # $('#violation_violator_attributes_organization_id').change ->
  #   console.log $(this).val()
  #   if $(this).val().length > 0 then $('.create-new-org-hint').hide() else $('.create-new-org-hint').show()
