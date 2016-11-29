class Plan < ApplicationRecord
	belongs_to :user
	has_many :recipes, dependent: :destroy
	validates :plan_name, presence: true
end