# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  $('#violation_date_of_incident').datepicker
    format: 'yyyy-mm-dd'
  $('#violation_time_of_incident').timepicker
    defaultTime: false

  # $('#voteViolation').on 'show', ->
  #   $thisModal = $(this)
  #   $thisModal.find('.violation-name').text

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

  $organizationForm = $('#new_organization')
  $organizationSelect = $('#violation_violator_attributes_organization_id')
  $organizationForm.on 'ajax:success', (e, data, status, xhr)->
    $organizationSelect.append '<option value="' + data.id + '">' + data.name + '</option>'
    $organizationSelect.val data.id
    $organizationSelect.val(data.id).attr 'selected', 'selected'
    $('#newOrg').modal('hide')
    $organizationForm.find('.control-group').removeClass 'error'
    $organizationForm.find('.help-inline').remove()
    $organizationForm.find('input').not(':input[type=button], :input[type=submit], :input[type=reset]').val('')
    $organizationForm.find('textarea').val('')

  $('#new_organization').on 'ajax:error', (e, data, status, xhr)->
    errors = $.parseJSON data.responseText
    $name = $('#organization_name')
    $group = $name.parents('.control-group')

    $group.addClass 'error'
    $group.find('.help-inline').html('')
    $name.after "<span class=\"help-inline\">#{errors.name}</span>"

  # $('#violation_violator_attributes_organization_id').change ->
  #   console.log $(this).val()
  #   if $(this).val().length > 0 then $('.create-new-org-hint').hide() else $('.create-new-org-hint').show()
