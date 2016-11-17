require 'rails_helper'
require 'capybara/rails'

describe "the sign in process", :type => :feature do
	before(:each) do
		User.create(name: "Kenneth", email: "user@example.com", password: "euripides")
	end

	scenario 'signing in with valid credentials' do 
		visit '/login'
		within 'form' do
			fill_in 'email', with: "user@example.com"
			fill_in 'password', with: "euripides"
		end
		click_button 'Submit'
		expect(page).to have_content 'Hello, Kenneth'
	end

	scenario 'signing in with invalid credentials' do
		visit '/login'
		within 'form' do
			fill_in 'email', with: "use@example.com"
			fill_in 'password', with: 'euripides'
		end
		click_button 'Submit'
		expect(page).to have_content 'Unsuccessful log in attempt.'
	end
end