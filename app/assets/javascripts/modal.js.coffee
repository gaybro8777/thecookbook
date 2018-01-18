$(document).ready ->
  $('.fa-cutlery').hover ->
    console.log @id
    $('.' + @id).modal show: true
    return
  return
