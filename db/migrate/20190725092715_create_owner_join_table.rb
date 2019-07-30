class CreateOwnerJoinTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses_users, :owner, :boolean
  end
end
