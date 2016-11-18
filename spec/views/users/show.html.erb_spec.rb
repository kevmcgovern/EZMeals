require 'rails_helper'

RSpec.describe "users/show", type: :view do
	before(:each) do
		@user = create(:user)
		create(:plan_with_recipes, user_id: @user.id)
	end

	it "renders the :show template" do
		render
		expect(view).to render_template(:show)
	end

	it "displays the user's name as a header" do
		render
		expect(rendered).to include("<h1>Hello, Thomas Jefferson</h1>")
	end

	it "displays a link to users/edit" do
		render
		expect(rendered).to include("<a href=\"/users/#{@user.id}/edit\">Edit Profile</a>")
	end

	it "displays the user's information" do
		render 
		expect(rendered).to include("<div>Name: Thomas Jefferson</div>")
		expect(rendered).to include("<div>Email: tj@monticello.com</div>")
	end

	it "has a link for deleting the user's account" do
		render
		expect(rendered).to include("<input type=\"hidden\" name=\"_method\" value=\"delete\" />")
	end

	it "displays all plan objects associated with the user" do
		render
		expect(rendered).to include("plan-display")
	end

	it "displays the plan_recipes partial" do
		render
		expect(rendered).to render_template(partial: "_plan_recipes", count: 1)
	end

	it "has links to recipes in the dropdown" do
		render 
		expect(rendered).to include("<a href=\"/recipes/")
	end

end