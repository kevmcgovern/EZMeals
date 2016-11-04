require 'httparty'

class RecipesController < ApplicationController
include HTTParty
	
	def index
		@recipes = Recipe.all
		# This should be "browse recipes" as the text in the anchor tag
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	# def create
	# 	@recipe = Recipe.find(params[:id])
	# 	# parameters = ActionController::Parameters.new(:instructins => api_call['instructions'])

	# 	if @recipe.save
	# 		flash[:success] = "Now you have ingredients!"
	# 		# redirect_to '/'
	# 	else
	# 		flash[:notice] = @recipe.errors.full_messages
	# 	end
	# end

	def update
		@recipe = Recipe.find(params[:id])
		api_call = generate_recipe(@recipe.spoon_id)
		if @recipe.update_attributes(:instructions => api_call['instructions'])
		# @recipe.instructions = api_call['instructions']
		# if @recipe.save
			ingredient_instantiate(api_call)
# Work on making this an AJAX call.
			redirect_to :back
		else
			@errors = @recipe.errors.full_messages
		end
	end

	def destroy
	end 

	private
		def recipe_params
			params.require(:recipe).permit(:title, :cooktime, :spoon_id, :plan_id)
		end

		def generate_recipe(spoon_id)
			return response = HTTParty.get("https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/#{spoon_id}/information?includeNutrition=false", :headers => { 'X-Mashape-Key' => ENV['SPOONACULAR_KEY'], 'Accept' => 'application/json'
				})
		end

		def recipe_split(recipe_string)
			return recipe_string.split(", ")
		end

		def recipe_assign(recipe_object, title, spoon_id, cooktime)
			recipe_object.title = title
			recipe_object.spoon_id = spoon_id
			recipe_object.cooktime = cooktime
		end

		def ingredient_instantiate(api_response)
			api_response['extendedIngredients'].each do |ingredient|
			raw_parameters = {:name => ingredient['name'] , :amount => ingredient['amount'] , :unit => ingredient['unit'] , :spoon_id => ingredient['id'] , :recipe_id => @recipe.id }
			parameters = ActionController::Parameters.new(raw_parameters)
			ingredient_object = Ingredient.create(parameters.permit(:name, :amount, :unit, :spoon_id, :recipe_id))
			end
		end
end


=begin

Sample Recipe JSON

{
  "vegetarian": false,
  "vegan": false,
  "glutenFree": true,
  "dairyFree": false,
  "veryHealthy": false,
  "cheap": false,
  "veryPopular": false,
  "sustainable": false,
  "weightWatcherSmartPoints": 30,
  "gaps": "no",
  "lowFodmap": false,
  "ketogenic": false,
  "whole30": false,
  "servings": 3,
  "sourceUrl": "http://glutenfreeeasily.com/popover-pizza-with-baby-bellas/",
  "spoonacularSourceUrl": "https://spoonacular.com/popover-pizza-with-bellas-onions-and-peppers-26082",
  "aggregateLikes": 2,
  "creditText": "Gluten Free Easily",
  "sourceName": "Gluten Free Easily",
  "extendedIngredients": [
    {
      "id": 11266,
      "aisle": "Produce",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/mushrooms.jpg",
      "name": "baby bella mushrooms",
      "amount": 6,
      "unit": "oz",
      "unitShort": "oz",
      "unitLong": "ounces",
      "originalString": "6 oz Baby Bella Mushrooms",
      "metaInformation": []
    },
    {
      "id": 2069,
      "aisle": "Oil, Vinegar, Salad Dressing",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/balsamic-vinegar.jpg",
      "name": "balsamic vinegar",
      "amount": 1,
      "unit": "tsp",
      "unitShort": "t",
      "unitLong": "teaspoon",
      "originalString": "1 tsp balsamic vinegar",
      "metaInformation": []
    },
    {
      "id": 2044,
      "aisle": "Produce",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/basil.jpg",
      "name": "basil",
      "amount": 3,
      "unit": "servings",
      "unitShort": "servings",
      "unitLong": "servings",
      "originalString": "Basil",
      "metaInformation": []
    },
    {
      "id": 4582,
      "aisle": "Oil, Vinegar, Salad Dressing",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/vegetable-oil.jpg",
      "name": "cooking oil",
      "amount": 3,
      "unit": "servings",
      "unitShort": "servings",
      "unitLong": "servings",
      "originalString": "cooking oil",
      "metaInformation": []
    },
    {
      "id": 1123,
      "aisle": "Milk, Eggs, Other Dairy",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/egg.jpg",
      "name": "eggs",
      "amount": 2,
      "unit": "",
      "unitShort": "",
      "unitLong": "",
      "originalString": "2 x eggs",
      "metaInformation": []
    },
    {
      "id": 11215,
      "aisle": "Produce",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/garlic.jpg",
      "name": "garlic",
      "amount": 3,
      "unit": "servings",
      "unitShort": "servings",
      "unitLong": "servings",
      "originalString": "Garlic",
      "metaInformation": []
    },
    {
      "id": 93620,
      "aisle": "Baking",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/coconut-flour-or-other-gluten-free-flour.jpg",
      "name": "gluten free flour",
      "amount": 1,
      "unit": "cup",
      "unitShort": "c",
      "unitLong": "cup",
      "originalString": "1 cup gluten free flour",
      "metaInformation": [
        "gluten free"
      ]
    },
    {
      "id": 1077,
      "aisle": "Milk, Eggs, Other Dairy",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/milk.jpg",
      "name": "milk",
      "amount": 1,
      "unit": "cup",
      "unitShort": "c",
      "unitLong": "cup",
      "originalString": "1 cup Milk",
      "metaInformation": []
    },
    {
      "id": 1026,
      "aisle": "Cheese",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/mozzarella-fresh.jpg",
      "name": "mozzarella",
      "amount": 2,
      "unit": "cup",
      "unitShort": "c",
      "unitLong": "cups",
      "originalString": "2 cup Mozzarella",
      "metaInformation": []
    },
    {
      "id": 1033,
      "aisle": "Cheese",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/parmesan-or-romano.jpg",
      "name": "parmesan cheese",
      "amount": 0.5,
      "unit": "cup",
      "unitShort": "c",
      "unitLong": "cups",
      "originalString": "1/2 cup Parmesan Cheese",
      "metaInformation": []
    },
    {
      "id": 10011549,
      "aisle": "Pasta and Rice",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/tomato-sauce-or-pasta-sauce.jpg",
      "name": "pasta sauce",
      "amount": 1,
      "unit": "packet",
      "unitShort": "packet",
      "unitLong": "packet",
      "originalString": "1 packet Pasta Sauce",
      "metaInformation": []
    },
    {
      "id": 2047,
      "aisle": "Spices and Seasonings",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/salt.jpg",
      "name": "salt",
      "amount": 0.25,
      "unit": "tsp",
      "unitShort": "t",
      "unitLong": "teaspoons",
      "originalString": "1/4 tsp Salt",
      "metaInformation": []
    },
    {
      "id": 19335,
      "aisle": "Baking",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/sugar-cubes.jpg",
      "name": "sugar",
      "amount": 3,
      "unit": "servings",
      "unitShort": "servings",
      "unitLong": "servings",
      "originalString": "Sugar",
      "metaInformation": []
    },
    {
      "id": 10211821,
      "aisle": "Produce",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/yellow-bell-pepper.jpg",
      "name": "sweet pepper",
      "amount": 3,
      "unit": "servings",
      "unitShort": "servings",
      "unitLong": "servings",
      "originalString": "sweet pepper",
      "metaInformation": []
    },
    {
      "id": 4513,
      "aisle": "Oil, Vinegar, Salad Dressing",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/vegetable-oil.jpg",
      "name": "vegetable oil",
      "amount": 1,
      "unit": "tbsp",
      "unitShort": "T",
      "unitLong": "tablespoon",
      "originalString": "1 tbsp Vegetable Oil",
      "metaInformation": []
    },
    {
      "id": 11294,
      "aisle": "Produce",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/sweet-onion.jpg",
      "name": "vidalia onion",
      "amount": 2,
      "unit": "",
      "unitShort": "",
      "unitLong": "",
      "originalString": "2 x Vidalia Onion",
      "metaInformation": []
    },
    {
      "id": 93626,
      "aisle": "Gluten Free",
      "image": "https://spoonacular.com/cdn/ingredients_100x100/white-powder.jpg",
      "name": "xanthan gum",
      "amount": 0.5,
      "unit": "tsp",
      "unitShort": "t",
      "unitLong": "teaspoons",
      "originalString": "1/2 tsp Xanthan Gum",
      "metaInformation": []
    }
  ],
  "id": 26082,
  "title": "Popover Pizza With Bellas, Onions, And Peppers",
  "readyInMinutes": 30,
  "image": "https://spoonacular.com/recipeImages/popover_pizza_with_bellas_onions_and_peppers-26082.jpg",
  "imageType": "jpg",
  "cuisines": [
    "mediterranean",
    "european",
    "italian"
  ],
  "instructions": null
}


=end