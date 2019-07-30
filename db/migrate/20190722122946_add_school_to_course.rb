class AddSchoolToCourse < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses, :school_id, :bigint
  end
end
