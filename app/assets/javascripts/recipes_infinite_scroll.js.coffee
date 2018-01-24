jQuery ->
  $('#load-more-items').click((ev) ->
    ev.preventDefault()

    $this = $(this)
    loader = $('#load-more-loader')
    next_page = $this.data('nextpage')
    baseurl = $this.data('baseurl')

    $this.hide()
    loader.show()

    $.getJSON(baseurl + '?page=' + next_page, (response) ->
      new_next_page = response.nextpage
      items = response.items

      if new_next_page
        $this.data('nextpage', new_next_page)
        recipes_load_more_process(items)
        $this.show()
      else
        $this.remove()

      loader.hide()
    )
  )

recipes_load_more_process = (items) ->
  grid = $('#recipes-grid')
  
  $.each(items, (index, item) ->
    container = $('<div/>', {
      class: 'col-md-4 col-sm-4 center-align recipe-dynamically-loaded'
    })

    container.css('opacity', 0)
    setTimeout(() ->
      container.css('opacity', 1)
    , index * 100)

    image_inner = $('<div/>', {
      class: 'col-md-12 image-red-mask'
    })

    image_link = $('<a/>', {
      href: '/recipes/' + item.id
    })

    image = $('<img>', {
      class: 'img-responsive image',
      src: item.image
    })

    image_link.append(image)
    image_inner.append(image_link)
    container.append(image_inner)

    title_inner = $('<div/>', {
      class: 'col-md-12'
    })

    title_link = $('<a/>', {
      href: '/recipes/' + item.id,
      class: 'recipe-link',
      text: item.name
    })

    title_inner.append(title_link)
    container.append(title_inner)

    tags_inner = $('<div/>', {
      class: 'col-md-12'
    })

    tags = []
    $.each(item.tags, (index, tag) ->
      tag_elem = $('<a/>', {
        href: '/tags/' + tag.name,
        text: tag.name,
        class: 'shaded'
      })

      tags.push(tag_elem[0].outerHTML)
    )

    tags_inner.append(tags.join(', '))
    container.append(tags_inner)

    ingredients_inner = $('<div/>', {
      class: 'col-md-12'
    })

    ingredients = []
    $.each(item.ingredients, (index, ingredient) ->
      ingredient_elem = $('<a/>', {
        href: '/tags/' + ingredient.name,
        text: ingredient.name,
        class: 'shaded'
      })

      ingredients.push(ingredient_elem[0].outerHTML)
    )

    ingredients_inner.append(ingredients.join(', '))
    container.append(ingredients_inner)

    grid.append(container)
  )
