class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :tags, :ingredients
  has_many :tags, url: true
  has_many :ingredients, url: true

  def image
    object.image.url
  end
end
