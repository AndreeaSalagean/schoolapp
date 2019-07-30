class RemoveColumnFromStudentCourse < ActiveRecord::Migration[5.2]
  def change
  	remove_column :student_courses, :user_id, :bigint
  end
end
