require 'rails_helper'
require_relative '../support/user_helper.rb'
include UserHelper

RSpec.describe PlansController, type: :controller do
  let!(:user) { create(:user) }
  let!(:plan) { build(:plan) }
  let!(:plan_with_recipes) { create(:plan_with_recipes) }

  describe "GET #index" do
    context "when a user is not logged in" do
      it "responds unsuccessfully with an HTTP 302 status code" do
        get :index
        expect(response).not_to be_success
        expect(response).to have_http_status(302)
      end

      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to('http://test.host/login')
      end
    end
    context "when a user is logged in" do
      before(:each) do
        log_user_in(user)
      end
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the correct template" do
        get :index
        expect(response).to render_template("index")
      end

      it "renders html" do
        get :index
        expect(response.content_type).to eq "text/html"
      end

      xit "brings in plan objects" do
        get :index
        # Don't adequately understand assigns to use it here
        expect(assigns(:plan_with_recipes)).to eq plan_with_recipes
      end
    end

  end

  describe "GET #new" do
    context "without a user signed in" do
      it "responds unsuccessfully with an HTTP 302 status code" do
        get :new
        expect(response).not_to be_success
        expect(response).to have_http_status(302)
      end

      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to('http://test.host/login')
      end
    end

    context "with a user signed in" do
      before(:each) do
        log_user_in(user)
      end
      it "responds successfully with an HTTP 200 status code" do
        get :new
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end

      it "assigns a new plan to @plan" do
        get :new
        expect(assigns(:plan)).to be_a_new(Plan)
      end

      it "renders html" do
        get :new
        expect(response.content_type).to eq "text/html"
      end
    end
  end

  describe "GET #show" do
    context "without a user signed in" do
      it "responds unsuccessfully with an HTTP 302 status code" do
        get :show, params: { id: plan_with_recipes.id }
        expect(response).not_to be_success
        expect(response).to have_http_status(302)
      end

      it "redirects to the login page" do
        get :show, params: { id: plan_with_recipes.id }
        expect(response).to redirect_to('http://test.host/login')
      end
    end

    context "with a user signed in" do
      before(:each) do
        log_user_in(user)
      end

      it "reresponds successfully with an HTTP 200 status code" do
        get :show, params: { id: plan_with_recipes.id }
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the show template" do
        get :show, params: { id: plan_with_recipes.id }
        expect(response).to render_template("show")
      end

      it "renders html" do
        get :show, params: { id: plan_with_recipes.id }
        expect(response.content_type).to eq "text/html"
      end

      it "brings in the correct plan object" do
        get :show, params: { id: plan_with_recipes.id }
        expect(assigns(:plan)).to eq plan_with_recipes
      end

      # Displays plan's recipe objects
    end
  end

  describe "GET #edit" do
    context "without a user signed in" do
      it "responds unsuccessfully with an HTTP 302 status code" do
        get :edit, params: { id: plan_with_recipes.id }
        expect(response).not_to be_success
        expect(response).to have_http_status(302)
      end

      it "redirects to the login page" do
        get :edit, params: { id: plan_with_recipes.id }
        expect(response).to redirect_to('http://test.host/login')
      end
    end

    context "with a user signed in" do
      before(:each) do
        log_user_in(user)
      end

      it "responds successfully with an HTTP 200 status code" do
        get :edit, params: { id: plan_with_recipes.id }
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the edit template" do
        get :edit, params: { id: plan_with_recipes.id }
        expect(response).to render_template("edit")
      end

      it "brings in the correct plan object" do
        get :edit, params: { id: plan_with_recipes.id }
        expect(assigns(:plan)).to eq plan_with_recipes
      end
    end
  end

  describe "POST #create" do
    before(:each) do
      log_user_in(user)
    end
    let!(:stub_plan_call) do
      # Let webmock loose!
      response_body = { "meals" => [
                {"id":795610,"title":"Death by Chocolate Zucchini Bread","readyInMinutes":65,"image":"death-by-chocolate-zucchini-bread-795610.jpg","imageUrls":["death-by-chocolate-zucchini-bread-795610.jpg"]},
                {"id":442034,"title":"Bierock Casserole","readyInMinutes":45,"image":"Bierock-Casserole-442034.jpg","imageUrls":["Bierock-Casserole-442034.jpg"]},
                {"id":773004,"title":"Supercharged Chicken Wings","readyInMinutes":80,"image":"supercharged-chicken-wings-773004.jpeg","imageUrls":["supercharged-chicken-wings-773004.jpeg"]}
              ]}
      p "response_body['meals] \n"
      p response_body['meals']
      stub_request(:get, /spoonacular-recipe-food-nutrition-v1.p.mashape.com*/).with(headers: { 'Accept' => 'application/json','X-Mashape-Key' => ENV['SPOONACULAR_KEY']}).to_return(status: [200, "OK"], body: response_body['meals'].to_json)
    end
    context "with valid attributes" do
      it "creates a new plan" do
        params = { plan:
                   { calories: 2000, time_frame: "day", plan_name: "Stub Plan", user_id: user.id }
                   }
        expect do
          # byebug
          post :create, params: params
        end.to change {Plan.count}.by(1)
        assert_requested stub_plan_call
      end
    end

    context "with invalid attributes" do
    end
  end

  xdescribe "PUT #update" do
    before(:each) do
      log_user_in(user)
    end

  end

  context "DELETE #destroy" do
    before(:each) do
      log_user_in(user)
    end

  end
end
