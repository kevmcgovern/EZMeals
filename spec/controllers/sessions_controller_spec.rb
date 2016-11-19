require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { build(:user) }

  context "GET #new)" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the login template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  context "POST #create" do
    before(:each) { user.save }
    context "with valid attributes" do
      it "logs the user in" do
        post :create, params: { email: user.email, password: user.password }
        expect(session['user_id']).to eq user.id
      end

      it "redirects to the current user" do
      	post :create, params: { email: user.email, password: user.password }
      	expect(response).to redirect_to user
      end
    end

    context "with invalid attributes" do
    	before(:each) { user.save }
    	it "does not log the user in" do
    	  post :create, params: { email: "tj@momicello.com", password: user.password }
    	  expect(session['user_id']).to be nil
    	end

    	it "re-renders the new template" do
    	  post :create, params: { email: user.email, password: "1253sir3" }
    	  expect(response).to redirect_to '/login'
    	end
    end
  end

  context "DELETE #destroy)" do
    before(:each) { user.save }

    it "redirects to /login" do
      delete :destroy
      expect(response).to redirect_to login_path
    end

    it "empties the sessions hash" do
      delete :destroy
      expect(session['user_id']).to be nil
    end
  end
end
