class RemoveTeacherFromCourse < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :teacher_id, :bigint
  end
end
