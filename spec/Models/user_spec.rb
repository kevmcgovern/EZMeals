require "rails_helper"

RSpec.describe User, :type => :model do

  describe "basic properties" do
    let!(:user) { User.new(name: "Kevin", email: "kev@kev.com", password_digest: "$2a$10$yP65HDC5BjXvWHNRxGa08emsZGbj7bCi6IorTKI8i5XAZL3uQ3zRK") }
   	let!(:plan) {Plan.new(plan_name: "Test Test", time_frame: "day", calories: 2000, user_id: user.id)}
  	let!(:recipe) {Recipe.new(title: "Meat Lasagna", plan_id: plan.id)}
  	let!(:ingredient) {Ingredient.new(name: "Cheese", amount: "3", unit: "pounds", recipe_id: recipe.id)}
    context "object attributes" do
      # Has a name
      it "has a name" do
        expect(user.name).to eq "Kevin"
      end
      # Has an email
      it "has an email" do
        expect(user.email).to eq "kev@kev.com"
      end
      # Has a password
      it "has a password" do
        expect(user.password_digest_before_type_cast).not_to be_empty
      end
      # Has a secure password
      it "has a secure password" do
        expect(user.password_digest?).to be true
      end

    end

    context "constraints and validations" do
      # Has validations
      it "has validations" do
        expect(user._validators?).to be true
      end
      # Is not valid without an email
      it "must have an email" do
        user.email.clear
        expect do
          begin
            user.save

          end.to_raise_error(NotNullViolation)
        end
      end
      # Is not valid with a name shorter than 5 characters
      it "must have a name of at least 5 characters" do
        user.name.clear
        expect do
          begin
            user.save
          end.to_raise_error(RecordInvalid)
        end
      end
    end

    context "associations" do
      before(:each) do 
      	user.save
      	plan.user_id = user.id ; plan.save
      	recipe.plan_id = plan.id ; recipe.save
      	ingredient.recipe_id = recipe.id ; ingredient.save
      # This should be refactored. Sloppy AF right here
      end
      # has_many plans
      it "has a one to many relationship with plans" do
      	expect(user.plans[0]).to be_a(Plan)
      end
      # has_many recipes through plans (plan?)
      it "has recipes associations through plans" do
      	expect(user.plans[0].recipes[0]).to be_a(Recipe)
      end
      # has_many ingredients through recipes?
      it "has access to ingredient objects through recipes" do
      	p user.plans[0].recipes[0].ingredients
      	expect(user.plans[0].recipes[0].ingredients).not_to be_empty
      end
    end

  end

  describe "advanced properties" do
  	# TBD
  end

end
