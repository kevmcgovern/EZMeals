module PlansHelper
	def recipe_collection_split(plan_object)
		return plan_object.recipe_collection.split(", ")
	end
end