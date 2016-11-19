require 'rails_helper'
require 'capybara/rails'

describe "the log out process", type: :feature do
	let!(:user) {create(:user)}

	scenario 'logging out the current user' do
		visit "/users/#{user.id}"
		within ('.navbar') do
			click_link '#logout'
		end
		expect(page).to have_content 'Login'
	end
end