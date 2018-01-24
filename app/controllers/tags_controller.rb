class TagsController < ApplicationController
  def show
    @tag = params[:id]
    @recipes_raw = Recipe.tagged_with(@tag).paginate(page: params[:page]).order('updated_at DESC')
    @recipes = RecipePresenter.build(@recipes_raw)
  end
end
