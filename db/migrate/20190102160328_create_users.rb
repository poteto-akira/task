class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string "username", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "password_digest", null: false
      t.string "remember_digest"
      t.boolean "admin", default: false
      t.timestamps
    end
  end
end
