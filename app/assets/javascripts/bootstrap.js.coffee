jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $("a[rel=bottom-tooltip]").tooltip
    placement: "bottom"

  $('.announcement-text .close').click (e) ->
    e.preventDefault()
    $btn = $(this)
    $announcement = $btn.parent()
    $.get $btn.attr('href'), (data) ->
      $announcement.fadeOut ->
        $('.announcement').fadeOut() if $('.announcement-text:visible').length < 1  