class AddSubmitBoolean < ActiveRecord::Migration[5.2]
  def change
  	add_column :submissions, :submit, :boolean
  end
end
