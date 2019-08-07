class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.string :title
      t.datetime :due_date
      t.boolean :submission
      t.integer :grade
      t.references :chapter, foreign_key: true

      t.timestamps
    end
  end
end
