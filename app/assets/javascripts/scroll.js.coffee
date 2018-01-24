$(document).ready ->
  $('.scrollToBottom').click ->
    $('html, body').animate { scrollTop: $('body')[0].scrollHeight }, 500
    false
  return
