require "rails_helper"

RSpec.describe User, :type => :model do

  describe "basic properties" do
    let!(:user) { build(:user) }
   	let!(:plan) { build(:plan) }
  	let!(:recipe) { build(:recipe) }
  	let!(:ingredient) { build(:ingredient) }
    context "object attributes" do
      # Has a name
      it "has a name" do
        expect(user.name).to eq "Thomas Jefferson"
      end
      # Has an email
      it "has an email" do
        expect(user.email).to eq "tj@monticello.com"
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
      # has_many recipes through plans
      it "has recipes associations through plans" do
      	expect(user.plans[0].recipes[0]).to be_a(Recipe)
      end
      # has_many ingredients through recipes
      it "has access to ingredient collection through recipes" do
      	expect(user.plans[0].recipes[0].ingredients).not_to be_empty
      end
      # objects available through association are ingredient objects
      it "has access to ingredient objects through recipes" do
      	expect(user.plans[0].recipes[0].ingredients[0]).to be_a(Ingredient)
    	end
    end

  end

  describe "advanced properties" do
  	# TBD
  end

end
