class CreateCourseTeachersJoinTable < ActiveRecord::Migration[5.2]
  def change
  	create_join_table :courses, :users do |t|
    t.index :course_id
    t.index :user_id
  end
  end
end
