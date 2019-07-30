class FixColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :user_courses, :user_id, :teacher_id
  end
end
