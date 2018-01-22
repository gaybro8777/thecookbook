$(document).ready ->
  $('.image-red-mask').hover ->
    $( this ).removeClass "image-red-mask"
    return
  , ->
    $( this ).addClass "image-red-mask"
    return
