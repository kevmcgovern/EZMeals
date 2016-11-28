module SessionHelper
	def login(user)
		visit root_path
		click_link 'Login'
		fill_in 'email', with: "tj@monticello.com"
		fill_in 'password', with: '123abc123'
		click_button 'Submit'
	end
end