jQuery ->
  $sendFeedbackBtn = $('#sendFeedback')
  $feedback = $('#feedback')

  $feedback.focus ->
    return if !$sendFeedbackBtn.hasClass 'disabled'
    $sendFeedbackBtn.removeClass 'disabled'
    $sendFeedbackBtn.addClass 'btn-primary'
    $feedback.autosize
      append: "\n"
