require 'rails_helper'
describe "the sign in process", :type => :feature do
	background do 
		create(:user)
	end

	scenario 'signing in with valid credentials' do 
		visit '/login'
		within 'form' do
			fill_in 'Email'
		end
	end
end