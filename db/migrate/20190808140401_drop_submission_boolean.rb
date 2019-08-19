class DropSubmissionBoolean < ActiveRecord::Migration[5.2]
  def change
  	remove_column :assignments, :submission, :boolean
  end
end
