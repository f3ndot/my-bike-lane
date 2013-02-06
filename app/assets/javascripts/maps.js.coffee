jQuery ->
  geocoder = new google.maps.Geocoder()

  default_latlng = new google.maps.LatLng 43.66365, -79.377594

  if document.getElementById("violation_map") != null
    map = new google.maps.Map document.getElementById("violation_map"),
      center: default_latlng,
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scrollwheel: false,
      streetViewControl: false,
      mapTypeControl: false
    marker = new google.maps.Marker
      map: map,
      position: default_latlng,
      visible: false

    $addr = $('#violationAddress')
    if $addr.data('longitude') == undefined or $addr.data('latitude') == undefined
      console.log 'lat/long data not found... geocoding on the fly'
      geocoder.geocode {'address': $addr.text()}, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          map.setCenter results[0].geometry.location
          map.setZoom 15
          marker.setPosition results[0].geometry.location
          marker.setVisible true
        else
          console.log "Geocode was not successful for the following reason: " + status
    else
      violation_pos = new google.maps.LatLng $addr.data('latitude'), $addr.data('longitude')
      map.setCenter violation_pos
      map.setZoom 15
      marker.setPosition violation_pos
      marker.setVisible true

  if document.getElementById("preview_map") != null
    preview_map = new google.maps.Map document.getElementById("preview_map"),
      center: default_latlng,
      zoom: 13,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      streetViewControl: false,
      mapTypeControl: false,
      scrollwheel: false

    preview_marker = new google.maps.Marker
      map: preview_map,
      position: default_latlng,
      visible: false

    if $('#violation_address').val().length > 0
      saved_latlng = new google.maps.LatLng $('#violation_latitude').val(), $('#violation_longitude').val()
      preview_map.setCenter saved_latlng
      preview_map.setZoom 15
      preview_marker.setPosition saved_latlng
      preview_marker.setVisible true

    $('#violation_address').on 'keyup', $.debounce(500, ->
      addr = $(this).val()
      city = $('#violation_city').val()
      return if addr.length == 0
      $('#preview_map_updating').fadeIn()
      console.log 'Should be: '+addr+', '+city
      geocoder.geocode {'address': addr+', '+city}, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          preview_map.setCenter results[0].geometry.location
          preview_map.setZoom 15
          preview_marker.setPosition results[0].geometry.location
          preview_marker.setVisible true
          $('#violation_latitude').val results[0].geometry.location.lat()
          $('#violation_longitude').val results[0].geometry.location.lng()
        else
          console.log "Geocode was not successful for the following reason: " + status
        $('#preview_map_updating').fadeOut()
    )

  if document.getElementById("violation_heatmap") != null
    heatmap = new google.maps.Map document.getElementById("violation_heatmap"),
      center: default_latlng,
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      streetViewControl: false,
      mapTypeControl: false