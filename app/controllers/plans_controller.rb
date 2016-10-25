require 'httparty'

class PlansController < ApplicationController
include HTTParty

	def index
		@plans = Plan.all
	end

	def new
		@plan = Plan.new
	end

	def show
		@plan = Plan.find(params[:id])
	end

	def create
		@plan = Plan.new(plan_params)
		api_call = generate_plan(@plan.calories, @plan.time_frame)
		if @plan.time_frame == "Day"
			@plan.recipe_collection = day_parse_json(api_call['meals'])
		else
			@plan.recipe_collection = week_parse_json(api_call['items'])
		end
		p @plan
		if @plan.save
			redirect_to @plan
		else
			flash[:notice] = @plan.errors.full_messages
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
		def plan_params
			params.require(:plan).permit(:calories, :time_frame, :user_id)
		end

		base_uri 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/mealplans/generate?'
		# end of API call: targetCalories=2000&timeFrame=week

		def generate_plan(calories, time_frame)
			response = self.class.get("targetCalories=#{calories}&timeFrame=#{time_frame}", :headers => {'x-mashape-key' => ENV['SPOONACULAR_KEY'], 'accept' => 'application/json'})
			return response
		end

		def day_parse_json(json_object)
		response = ""
		json_object.each do |hash|
			response += hash["id"].to_s + ", "
			end
		return response.slice(0, response.length - 2)
		end

		def week_parse_json(json_object)
			response = ""
			json_object.each do |hash|
				response += week_parse_regex(hash['value']) + ", "
			end
			return response.slice(0, response.length - 2)
		end

		def week_parse_regex(string)
			# input: string that begins with the characters {\"id\":
				# 8 characters, final one is at index 7
			# Start the capture at index 8 
			# Stop the capture at first non numerical character
			return string.slice(/\d+/)
		end
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