jQuery ->
  $voteBtns = $('.voting a')

  $voteBtns.click (e) ->
    $link = $(this)
    $.ajax $link.attr('href'),
      type: 'GET',
      dataType: 'json',
      error: (jqXHR, textStatus, errorThrown) ->
        alert 'There was an error trying to cast your vote... Sorry!'
        console.log jqXHR
        console.log textStatus
        console.log errorThrown
      success: (data, textStatus, jqXHR) ->
        console.log data
        $link.addClass 'voted' if data.status == 'upvoted' or data.status == 'downvoted'
        $link.removeClass 'voted' if data.status == 'unvoted'

        $tally = $link.parent().find('.vote-tally')
        console.log $tally
        tally_num = parseInt($.trim($tally.html()))
        $tally.html ++tally_num if data.status == 'upvoted' or (data.status == 'unvoted' and $link.hasClass 'arrow-s')
        $tally.html --tally_num if data.status == 'downvoted' or (data.status == 'unvoted' and $link.hasClass 'arrow-n')

    e.preventDefault()