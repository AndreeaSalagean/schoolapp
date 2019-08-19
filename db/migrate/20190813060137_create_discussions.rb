class CreateDiscussions < ActiveRecord::Migration[5.2]
  def change
    create_table :discussions do |t|
      t.string :title
      t.string :started_by
      t.integer :replies
      t.text :comment
      t.references :forum, foreign_key: true

      t.timestamps
    end
  end
end
