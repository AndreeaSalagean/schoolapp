class AddAssigSub < ActiveRecord::Migration[5.2]
  def change
  	add_column :submissions, :assignment_id, :integer
  end
end
