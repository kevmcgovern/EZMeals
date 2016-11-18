class User < ApplicationRecord
	has_secure_password

	has_many :plans, dependent: :destroy

	validates :name, presence: true, length: { minimum: 5 }
	validates :email, presence: true, length: { minimum: 4 }
	validates :password, presence: true
end