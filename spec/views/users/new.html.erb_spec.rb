require 'rails_helper'

RSpec.describe "users/new", type: :view do
	it "renders the :new template" do
		render
		expect(view).to render_template(:new)
	end
	
	it "displays the correct header" do
		render
		expect(rendered).to include('Signup')
	end

	it "renders the correct form" do
		render
		expect(rendered).to include('id="user_name"')
		expect(rendered).to include('id="user_email"')
		expect(rendered).to include('id="user_password"')
		expect(rendered).to include('id="user_password_confirmation"')
	end
end