class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes_raw = @user.recipes.paginate(page: params[:page]).order('updated_at DESC')
    @recipes = RecipePresenter.build(@recipes_raw)
  end
end
