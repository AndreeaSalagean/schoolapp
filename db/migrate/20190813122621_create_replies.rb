class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.string :commenter
      t.text :body
      t.references :discussion, foreign_key: true

      t.timestamps
    end
  end
end
