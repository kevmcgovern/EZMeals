class ChangeCooktimeToCookTimeMinutes < ActiveRecord::Migration[5.0]
  def change
  	rename_column :recipes, :cooktime, :cook_time_minutes
  end
end
