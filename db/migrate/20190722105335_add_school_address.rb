class AddSchoolAddress < ActiveRecord::Migration[5.2]
  def change
  	add_column :schools, :address, :string
  end
end
