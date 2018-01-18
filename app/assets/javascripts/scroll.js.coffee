$(document).ready ->
  $('.scrollToBottom').click ->
    $('html, body').animate { scrollTop: $(window).height() }, 500
    false
  return
