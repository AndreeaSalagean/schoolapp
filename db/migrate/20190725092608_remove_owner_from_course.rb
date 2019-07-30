class RemoveOwnerFromCourse < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :owner, :boolean
  end
end
