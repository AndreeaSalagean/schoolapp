class AddEnableStudentColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :schools, :enable_enroll, :boolean
  end
end
