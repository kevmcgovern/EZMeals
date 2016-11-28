class ChangeCookTimeMinutesToInteger < ActiveRecord::Migration[5.0]
  def change
  	change_column :recipes, :cook_time_minutes, 'integer USING CAST(cook_time_minutes AS integer)'
  end
end
