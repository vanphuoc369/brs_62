class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.string :type_activity
      t.references :user, foreign_key: true
      t.integer :activity_id

      t.timestamps
    end
  end
end
