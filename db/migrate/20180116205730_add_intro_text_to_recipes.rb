class AddIntroTextToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :intro_text, :text
  end
end
