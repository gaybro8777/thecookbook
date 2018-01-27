class ForkHistory < ActiveRecord::Base
  belongs_to :recipe, foreign_key: :id

  def recipe_chain
    Recipe.where(id: self.path).order('id ASC')
  end
end
