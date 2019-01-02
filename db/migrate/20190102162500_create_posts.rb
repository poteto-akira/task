class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer "user_id", null: false
      t.string "name", null: false
      t.text "content"
      t.integer "current_state", default: 1
      t.integer "priority", default: 0
      t.datetime "deadline"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name"], name: "name_index"
      t.timestamps
    end
  end
end
