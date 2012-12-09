jQuery ->
  geocoder = new google.maps.Geocoder()

  mapOptions =
    center: new google.maps.LatLng(-34.397, 150.644),
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP


  if document.getElementById("violation_map") != null
    map = new google.maps.Map document.getElementById("violation_map"), mapOptions

  if $('#violationAddress').text().length > 0
    geocoder.geocode {'address': $('#violationAddress').text()}, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        map.setCenter results[0].geometry.location
        marker = new google.maps.Marker
          map: map,
          position: results[0].geometry.location
      else
        console.log "Geocode was not successful for the following reason: " + status
