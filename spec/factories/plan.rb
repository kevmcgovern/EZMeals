FactoryGirl.define do
  factory :plan do
    plan_name "Testy McTestface"
    time_frame "day"
    calories 2000
    user

    factory :plan_with_recipes do
      transient do
        recipes_count 3
      end
      after(:create) do |plan, evaluator|
        create_list(:recipe, evaluator.recipes_count, plan: plan)
      end
    end
  end
end
