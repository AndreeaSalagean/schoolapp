class AddRoleIdForUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :role, "ENUM('admin', 'teacher', 'student')"
  end
end
