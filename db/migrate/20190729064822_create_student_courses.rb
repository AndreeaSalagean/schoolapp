class CreateStudentCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :student_courses do |t|
      t.belongs_to :course, index: true
      t.belongs_to :user, index: true
      t.bigint :course_id
      t.bigint :student_id
      t.timestamps
   
    end
  end
end
