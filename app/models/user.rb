class User < ApplicationRecord
	has_secure_password

	has_many :plans

	validates :name, presence: true, length: { minimum: 5 }
end