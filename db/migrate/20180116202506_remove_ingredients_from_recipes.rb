class RemoveIngredientsFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :ingredients, :text
  end
end
