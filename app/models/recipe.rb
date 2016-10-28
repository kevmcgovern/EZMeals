class Recipe < ApplicationRecord
	belongs_to :plan
	has_many :ingredients
	accepts_nested_attributes_for :ingredients
	# has_many :ingredients, :through => :recipe_ingredients
end