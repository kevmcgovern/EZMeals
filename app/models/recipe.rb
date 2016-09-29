class Recipe < ApplicationRecord
	belongs_to :plan
	has_many :recipe_ingredients
	has_many :ingredients, :through => :recipe_ingredients
end