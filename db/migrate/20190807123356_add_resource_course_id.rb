class AddResourceCourseId < ActiveRecord::Migration[5.2]
  def change
  	add_column :resources, :course_id, :integer
  	add_column :resources, :chapter_id, :integer
  end
end
