class CreateUserCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_courses do |t|

      t.belongs_to :course, index: true
      t.belongs_to :user, index: true
      t.boolean :owner
      t.timestamps
    end
  end
end
