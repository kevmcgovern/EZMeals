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
	# 	# parameters = ActionController::Parameters.new(:instructions => api_call['instructions'])

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
			ingredient_instantiate(api_call)
			flash[:notice] = "Ingredients list generated"
# Work on making this an AJAX call.
			redirect_to :back
		else
			@errors = @recipe.errors.full_messages
			# Change this to the flash hash for consistency?
		end
	end

	def destroy
		recipe = Recipe.find(params[:id])
		recipe.destroy
		redirect_to current_user
	end 

	private
		def recipe_params
			params.require(:recipe).permit(:title, :cooktime, :spoon_id, :plan_id)
		end

		def generate_recipe(spoon_id)
			return response = HTTParty.get("https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/#{spoon_id}/information?includeNutrition=false", :headers => { 'X-Mashape-Key' => ENV['SPOONACULAR_KEY'], 'Accept' => 'application/json'
				})
		end

		def ingredient_instantiate(api_response)
			api_response['extendedIngredients'].each do |ingredient|
			raw_parameters = {:name => ingredient['name'] , :amount => ingredient['amount'] , :unit => ingredient['unit'] , :spoon_id => ingredient['id'] , :recipe_id => @recipe.id }
			parameters = ActionController::Parameters.new(raw_parameters)
			ingredient_object = Ingredient.create(parameters.permit(:name, :amount, :unit, :spoon_id, :recipe_id))
			end
		end
end