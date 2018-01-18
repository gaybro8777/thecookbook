$(document).ready ->
  $('#ingredient_tags').select2
    tags: true
    placeholder: 'Granny Smith Apples'
  # take tags from select2 generated select and
  # set those tags to the value in the hidden field
  $(document).on 'change', '#ingredient_tags', ->
    taggable_id = $(this).attr('id')
    hidden_id = taggable_id.replace('_select2', '')
    hidden = $('.hidden_tags')
    joined = ($(this).val() or []).join(',')
    hidden.val joined
    return
  return
