User.create(email: 'admin@endpoint.com', password: 'pizza123', name: 'admin')

# seed recipes
for i in 0..100
  recipe = Recipe.new

  recipe.user = User.where(email: 'admin@endpoint.com').first
  recipe.name = Faker::Food.dish
  recipe.source = Faker::Internet.url
  recipe.ingredient_list = [Faker::Food.ingredient, Faker::Food.ingredient, Faker::Food.ingredient, Faker::Food.ingredient]
  recipe.tag_list = [Faker::Food.ingredient, Faker::Food.ingredient, Faker::Food.ingredient, Faker::Food.ingredient]
  recipe.intro_text = Faker::Food.description
  recipe.directions = Faker::Food.description

  temp_image = Tempfile.new(['temp_image', '.jpg'])
  temp_image.binmode
  open('https://source.unsplash.com/featured/?food') do |url_file|
    temp_image.write(url_file.read)
  end
  recipe.image = temp_image
  temp_image.close

  recipe.save!
end
