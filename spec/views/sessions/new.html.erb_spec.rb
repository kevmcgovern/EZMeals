require 'rails_helper'

RSpec.describe "/sessions/new", type: :view do
	it "renders the :new template" do
		render
		expect(view).to render_template(:new)
	end

	it "displays the correct header" do
		render
		expect(rendered).to include('Login')
	end
end