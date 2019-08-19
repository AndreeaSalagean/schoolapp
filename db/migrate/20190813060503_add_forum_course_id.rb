class AddForumCourseId < ActiveRecord::Migration[5.2]
  def change
  	add_column :forums, :course_id, :integer
  end
end
