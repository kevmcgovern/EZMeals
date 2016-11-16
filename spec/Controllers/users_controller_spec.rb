require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let!(:user) { User.new(name: "Kevin", email: "kev@kev.com", password_digest: "$2a$10$yP65HDC5BjXvWHNRxGa08emsZGbj7bCi6IorTKI8i5XAZL3uQ3zRK") }
  context "GET #index" do
    it "raises routing error because route doesn't exist" do
      expect do
        begin get :index
        end.to_raise_error(RoutingError)
      end
    end
  end

  context "GET #new" do
    # Correct HTTP response code
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    # Correct template rendering
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  context "GET #edit" do
    before(:each) do
      user.save
    end
    # Correct HTTP response code
    it "responds successfully with an HTTP 200 status code" do
      get :edit, params: { id: user.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    # Correct Template
    it "renders the edit template" do
      get :edit, params: { id: user.id }
      expect(response).to render_template("edit")
    end
    # Brings in correct User object
    it "brings in the correct user object" do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq user
    end
  end

  context "GET #show" do
    before(:each) do
      user.save
    end
    # Correct HTTP response code
    it "reresponds successfully with an HTTP 200 status code" do
      get :show, params: { id: user.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    # Correct template
    it "renders the show template" do
      get :show, params: { id: user.id }
      expect(response).to render_template("show")
    end

    # Brings in the correct user object
    it "brings in the correct user object" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq user
    end

    # Displays user's recipes/plans
    # Need some sort of contrsuctor here
  end

  context "POST #create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect{
          post :create, params: { user: {name: user.name, email: user.email, password: "123password123" } }
        }.to change(User, :count)
      end
      it "redirects to the new user" do
        post :create, params: { user: {name: user.name, email: user.email, password: "123password123" } }
        expect(response).to redirect_to User.last
      end
      it "makes the newly created user the current user" do
        post :create, params: { user: {name: user.name, email: user.email, password: "123password123" } }
        expect(session[:user_id]).to eq(User.last.id)
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in database without an email" do
        user.email.clear
        expect{
          post :create, params: { user: {name: user.name, email: user.email, password: "123password123" } }
        }.not_to change(User, :count)
      end
      it "does not save the new contact in database with a name shorter than 5 characters" do
        user.name = "Tom"
        expect{
          post :create, params: { user: {name: user.name, email: user.email, password: "123password123" } }
        }.not_to change(User, :count)
      end
      it "re-renders the new method" do
        user.name = "Tom"
        post :create, params: { user: {name: user.name, email: user.email, password: "123password123" } }
        expect(response).to render_template("new")
      end
    end
  end

  context "PUT #update" do
    before(:each) do
      user.save
    end

    context "valid attributes" do
      it "locates the requested user" do
        put :update, params: { user: {name: user.name, email: user.email, password: "123password123", password_confirmation: "123password123" }, id: user.id }
        expect(assigns(:user)).to eq(user)
      end
      it "changes user's attributes" do
        put :update, params: { user: {name: "Chip Kelly", email: "scapegoat@49ers.com", password: "123password123", password_confirmation: "123password123" }, id: user.id }
        user.reload
        expect(user.name).to eq("Chip Kelly")
        expect(user.email).to eq("scapegoat@49ers.com")
      end
      it "redirects to the user's updated page" do
        put :update, params: { user: {name: "Chip Kelly", email: "scapegoat@49ers.com", password: "123password123", password_confirmation: "123password123" }, id: user.id }
        expect(response).to redirect_to user
      end
    end

    context "invalid attributes" do
      it "locates the requested user" do
        put :update, params: { user: {name: user.name, email: user.email, password: "123password123", password_confirmation: "123password123" }, id: user.id }
        expect(assigns(:user)).to eq(user)
      end
      it "does not change the user's attributes with a name too short" do
        put :update, params: { user: {name: "Tom", email: "scapegoat@49ers.com", password: "123password123", password_confirmation: "123password123" }, id: user.id }
        user.reload
        expect(user.name).not_to eq "Tom"
      end
      it "does not change the user's attributes with a nil email" do
        put :update, params: { user: {name: "Chip Kelly", email: nil, password: "123password123", password_confirmation: "123password123" }, id: user.id }
        expect(user.email).not_to eq nil
      end
      it "re-renders the edit method" do
        put :update, params: { user: {name: "Tom", email: "scapegoat@49ers.com", password: "123password123", password_confirmation: "123password123" }, id: user.id }
        expect(response).to render_template("edit")
      end
    end
  end

  context "DELETE destroy" do
    before(:each) do
      user.save
    end

    it "deletes the contact" do
      expect{
        delete :destroy, params: {id: user.id}
      }.to change(User, :count).by(-1)
    end
    it "redirects to root" do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to root_url
    end
    xit "deletes any associated plans" do
      # Being delayed until ready to work with FactoryGirl
    end
  end
end
