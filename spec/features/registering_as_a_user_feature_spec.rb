require 'rails_helper'
# require 'capybara/rails'

describe "the sign up process", :type => :feature do
  scenario 'signing up with valid credentials' do
  	visit '/users/new'
  	within('form') do
  	  fill_in 'Name', with: "Tommy" 
      fill_in 'Email', with: "tj@monticello.com"
      fill_in 'Password', with: "123abc123"
      fill_in 'Password confirmation', with: "123abc123"
  	end
    click_button 'Submit'
    expect(page).to have_content 'Hello, Tommy'
  end

  scenario 'signing up with invalid credentials' do
    visit '/users/new'
    within('form') do
      fill_in 'Name', with: "Ben"
      fill_in 'Password', with: "123abc123"
      fill_in 'Password confirmation', with: "123abc123"
    end
    click_button 'Submit'
    expect(page).to have_content 'Signup'
    # This checks the re-rendering of the template, but it would be better to pivot off of the error
  end
end