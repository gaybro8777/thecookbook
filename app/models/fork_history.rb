class ForkHistory < ActiveRecord::Base
  belongs_to :recipe, foreign_key: :id

  def recipe_chain
    Recipe.find(self.path)
  end
end
