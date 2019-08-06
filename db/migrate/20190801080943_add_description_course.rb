class AddDescriptionCourse < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses, :description, :text
  end
end
