require 'rails_helper'
require 'capybara/rails'
require_relative '../support/session_helper.rb'
include SessionHelper

describe "the log out process", type: :feature do
	let!(:user) {create(:user)}

	scenario 'logging out the current user' do
		login(user)
		within ('nav') do
			click_button 'Logout'
		end
		expect(page).to have_content 'Login'
	end
	
end
