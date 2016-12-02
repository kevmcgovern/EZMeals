require 'httparty'

class PlansController < ApplicationController
include HTTParty
helper PlansHelper

	def index
		authorize
		@plans = Plan.all
	end

	def new
		authorize
		@plan = Plan.new
	end

	def show
		authorize
		@plan = Plan.find(params[:id])
	end

	def create
		@plan = Plan.new(plan_params)
		api_call = generate_plan(@plan.calories, @plan.time_frame)
		print "This is meals"
		p "*************************************** \n"
		p api_call['meals']
		if @plan.save
		  day_instantiate(api_call['meals'], @plan)
		  flash[:notice] = 'Successfully generated plan'
			redirect_to @plan
		else
			flash[:alert] = @plan.errors.full_messages
		end
	end

	def edit
		authorize
		@plan = Plan.find(params[:id])
	end

	def update
		@plan = Plan.find(params[:id])
		# INCOMPLETE
	end

	def destroy
		plan = Plan.find(params[:id])
		plan.destroy!
		flash[:notice] = 'Successfully deleted account'
		redirect_to root_path
	end

	private
		def plan_params
			params.require(:plan).permit(:calories, :time_frame, :user_id, :plan_name)
		end

		base_uri 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/mealplans/generate?'
		# end of API call: targetCalories=2000&timeFrame=week

		def generate_plan(calories, time_frame)
			response = self.class.get("targetCalories=#{calories}&timeFrame=#{time_frame}", :headers => {'x-mashape-key' => ENV['SPOONACULAR_KEY'], 'accept' => 'application/json'})
			return response
		end

		def day_instantiate(api_response, plan_object)
			# byebug
			api_response.each do |recipe|
				raw_parameters = { :title => recipe['title'], :spoon_id => recipe['id'], :cook_time_minutes => recipe['readyInMinutes'], :plan_id => plan_object.id }
				parameters = ActionController::Parameters.new(raw_parameters)
				recipe_object = Recipe.create(parameters.permit(:title, :spoon_id, :cook_time_minutes, :plan_id))
			end
		end

		# Still need a week instantiate

end


=begin

Here's the json object from our first query:

[
{
	"id"=>78160, 
	"title"=>"Classic Eggs Benedict", 
	"readyInMinutes"=>24, 
	"image"=>"classic-eggs-benedict-2-78160.jpg", "imageUrls"=>["classic-eggs-benedict-2-78160.jpg"]
}, 
{
	"id"=>248532, 
	"title"=>"Diced Caprese Salad with a Pesto Dressing", 
	"readyInMinutes"=>45, "image"=>"Diced-Caprese-Salad-with-a-Pesto-Dressing-248532.jpg",
	"imageUrls"=>["Diced-Caprese-Salad-with-a-Pesto-Dressing-248532.jpg"]
}, 
{
	"id"=>71776, 
	"title"=>"Hula Joes", 
	"readyInMinutes"=>21, 
	"image"=>"hula_joes-71776.jpg", 
	"imageUrls"=>["hula_joes-71776.jpg", 
	"hula-joes-2-71776.jpg"]
}
]

Here's the weekly json object (one day of 7)
[
{
	"day"=>1, 
	"slot"=>1, 
	"position"=>0, 
	"type"=>"RECIPE",
	"value"=>
		"{
			\"id\":475003,
			\"imageType\":\"jpg\",
			\"title\":\"Carrot Pineapple Muffins {and a giveaway!}\"
		}", 
	"mealPlanId"=>0
}, 
{
	"day"=>1, 
	"slot"=>2, 
	"position"=>0, 
	"type"=>"RECIPE", 
	"value"=>
		"{
			\"id\":764096,
			\"imageType\":\"jpg\",
			\"title\":\"Spicy Shrimp Chorizo Stew\"
		}", 
	"mealPlanId"=>0
}, 
{
	"day"=>1, 
	"slot"=>3, 
	"position"=>0, 
	"type"=>"RECIPE", "value"=>
		"{
				\"id\":376696,
				\"imageType\":\"jpg\",
				\"title\":\"Chicken Salad Panini\"
		}", 
	"mealPlanId"=>0
},


=end