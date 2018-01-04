class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :avatar
      t.string :password_digest
      t.boolean :is_admin, default: false
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.string :remember_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
