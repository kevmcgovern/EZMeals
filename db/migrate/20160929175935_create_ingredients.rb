class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
    	t.string :name
    	t.string :amount
    	t.string :unit
    	t.integer :spoon_id
    	t.references :recipe

    	t.timestamps null: false
    end
  end
end
