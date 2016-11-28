require 'rails_helper'
require 'capybara/rails'

describe "the user editing process", type: :feature do
	
	let!(:user)	{ User.create(name: "Kenneth", email: "user@example.com", password: "euripides") }
	

	scenario 'editing user info with valid information' do
		visit edit_user_path(user)
		within 'form' do
			fill_in 'user[name]', with: 'Kenny G'
			fill_in 'user[email]', with: 'user@new-example.com'
			fill_in 'user[password]', with: 'saX4Lyfe'
			fill_in 'user[password_confirmation]', with: 'saX4Lyfe' 
		end
		click_button 'Submit'
		expect(page).to have_content 'Profile Updated'
	end

	context 'editing user info with invalid information' do
		scenario 'entering a name shorter than 5 characters' do
			visit edit_user_path(user)
			within 'form' do
				fill_in 'user[name]', with: 'Ken'
				fill_in 'user[password]', with: 'saX4Lyfe'
				fill_in 'user[password_confirmation]', with: 'saX4Lyfe'
			end
			click_button 'Submit'
			expect(page).to have_content 'There was an error editing your profile'
		end

		scenario 'entering an email shorter than 4 characters' do
			visit edit_user_path(user)
			within 'form' do
				fill_in 'user[email]', with: 'a@b'
				fill_in 'user[password]', with: 'saX4Lyfe'
				fill_in 'user[password_confirmation]', with: 'saX4Lyfe'
			end
			click_button 'Submit'
			expect(page).to have_content 'There was an error editing your profile'
		end

		scenario 'not entering a password' do
			visit edit_user_path(user)
			within 'form' do
				fill_in 'user[name]', with: 'Kenny G'
			end
			click_button 'Submit'
			expect(page).to have_content 'There was an error editing your profile'
		end

		scenario "password doesn't match password confirmation" do
			visit edit_user_path(user)
			within 'form' do
				fill_in 'user[name]', with: 'Kenny G'
				fill_in 'user[password]', with: 'saX4Lyfe'
				fill_in 'user[password_confirmation]', with: 'sax4lyfe'
			end
			click_button 'Submit'
			expect(page).to have_content 'There was an error editing your profile'
		end
	end
end