FactoryGirl.define do
  factory :recipe do
  	title "Testy Meat Lasagna"
  	cook_time_minutes 45
  	plan

  	factory :recipe_with_ingredients do
  		transient do
  			ingredients_count 10
  		end
  		after(:create) do |recipe, evaluator|
  			create_list(:ingredient, evaluator.ingredients_count, recipe: recipe)
  		end
  	end
  end
end
