class AddSchoolTelephone < ActiveRecord::Migration[5.2]
  def change
  	add_column :schools, :telephone, :string
  end
end
