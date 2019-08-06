class AddEnrollementKey < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses, :enrollement_key, :string
  end
end
