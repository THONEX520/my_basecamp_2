
ActiveRecord::Schema[8.0].define(version: 2025_03_10_131536) do
  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
