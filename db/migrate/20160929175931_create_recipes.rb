class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
    	t.string :title
    	t.string :cooktime
    	t.integer :spoon_id
    	t.references :plan

    	t.timestamps null: false
    end
  end
end
