jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("a[rel=avatar-tooltip]").tooltip
    placement: "bottom"
