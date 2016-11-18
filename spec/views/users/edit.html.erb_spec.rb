require 'rails_helper'

RSpec.describe "users/edit", type: :view do
	before(:each) do
		@user = create(:user)
	end

	it "renders the edit template" do
		render
		expect(view).to render_template(:edit)
	end

	it "displays the correct header" do
		render
		expect(rendered).to include('<h1>Edit Profile</h1>')
	end

	it "prepopulates the user's name and email address in the form" do
		render
		expect(rendered).to include("<input type=\"text\" value=\"Thomas Jefferson\" name=\"user[name]\" id=\"user_name\" />")
		expect(rendered).to include("<input type=\"text\" value=\"tj@monticello.com\" name=\"user[email]\" id=\"user_email\" />")
	end
end