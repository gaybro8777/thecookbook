class RecipePresenter < ApplicationPresenter
  def initialize(recipe)
    @recipe = recipe
  end

  attr_reader :recipe

  delegate :id, :name, :user, :source, :directions, :image,
    :forked?, :intro_text, :fork_origin, to: :recipe

  def tag_links(delimiter = ',', classes = '')
    return if recipe.tags.empty?
    recipe.tags.map do |tag|
      h.link_to tag.name, "/tags/#{tag.name}", class: classes
    end.join(delimiter).html_safe
  end

  def ingredient_links(delimiter = ',', classes = '')
    return if recipe.ingredients.empty?
    recipe.ingredients.map do |tag|
      h.link_to tag.name, "/tags/#{tag.name}", class: classes
    end.join(delimiter).html_safe
  end

  def created_by(classes = '')
    h.link_to user.name, "/users/#{user.id}/#{(user.name || "").parameterize}", class: classes
  end

  def fork_origin_link
    if origin = recipe.fork_origin
      text = "#{origin.user.name}'s #{origin.name}"
      h.link_to('Forked', fork_history_path) +  "".html_safe + " from " + h.link_to(text, fork_origin_path)
    end
  end

  def get_fork_history
    links = []
    recipe.fork_history.recipe_chain.each do |recipe|
      if origin = recipe.fork_origin
        text = "#{origin.user.name}'s #{origin.name}"
        links << "".html_safe + "Forked from " + h.link_to(text, fork_origin_path)
      end
    end
    links
  end

  def fork_origin_icon_link
    if origin = recipe.fork_origin
      text = "#{origin.user.name}'s #{origin.name}"

      h.link_to h.content_tag(:i, nil, class: 'fa fa-arrow-right', id: "fork_origin#{recipe.fork_origin.id}"),
                fork_origin_path
    end
  end

  def source
    h.link_to(recipe.source, recipe.source) if recipe.source.present?
  end

  def to_param
    "#{recipe.id}/#{recipe.name.parameterize}"
  end

  def fork_link(current_user)
    text = "Fork this recipe"
    url  = "/recipes/#{id}/fork"
    icon = h.content_tag(:i, nil, class: 'fa fa-cutlery')
    options = {
      method: :post,
      class: 'btn btn-primary btn-fork',
      title: 'Make it your own!'
    }


    if user = current_user
      if forked_recipe = user.recipes.where(fork_origin_id: recipe.id).first
        text = "View your fork"
        url  = "/recipes/#{forked_recipe.id}"
        options.delete(:method)
        options.delete(:title)
      end
    end

    h.link_to [icon, text].join(' ').html_safe, url, options
  end

  private

  def fork_history_path
    "/recipes/#{recipe.id}/fork_history"
  end

  def fork_origin_path
    origin = recipe.fork_origin
    "/recipes/#{origin.id}/#{origin.name.parameterize}"
  end
end
