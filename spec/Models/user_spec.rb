require "rails_helper"

RSpec.describe User, :type => :model do

	describe "basic properties" do
		let!(:user) { User.new(name: "Kevin", email: "kev@kev.com", password_digest: "$2a$10$yP65HDC5BjXvWHNRxGa08emsZGbj7bCi6IorTKI8i5XAZL3uQ3zRK") }
		context "object attributes" do
		
		# Has a name
		it "has a name" do
			expect(user.name).to eq "Kevin"
		end
		# Has an email
		it "has an email" do
			expect(user.email).to eq "kev@kev.com"
		end
		# Has a password
		it "has a password" do
			expect(user.password_digest_before_type_cast).not_to be_empty
		end
		# Has a secure password
		it "has a secure password" do
			expect(user.password_digest?).to be true
		end

		end

		context "constraints and validations" do

			# Has validations

			# Is not valid without an email

			# Is not valid with a name shorter than 5 characters

		end

		context "associations" do

			# has_many plans

			# has_many recipes through plans (plan?)

			# has_many ingredients through recipes?

		end

	end

end