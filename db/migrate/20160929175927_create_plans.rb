class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
    	t.string :plan_name
    	t.string :time_frame
    	t.integer :calories
    	t.text :recipe_collection

    	t.references :user

    	t.timestamps null: false
    end
  end
end
