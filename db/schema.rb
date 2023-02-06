# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_06_063640) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "notes", force: :cascade do |t|
    t.text "content"
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_notes_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.boolean "home_grown_nation", default: false
    t.boolean "home_grown_club", default: false
    t.date "home_grown_date"
    t.boolean "on_loan", default: false
    t.string "positions"
    t.float "current_ability", default: 0.0
    t.float "potential_low", default: 0.0
    t.float "potential_high", default: 0.0
    t.integer "age"
    t.integer "transfer_value"
    t.string "media_desc"
    t.integer "release_clause"
    t.integer "release_clause_special"
    t.string "recommendation"
    t.string "nationality"
    t.string "club"
    t.bigint "team_id", null: false
    t.integer "price_purchased"
    t.integer "price_sold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "spot_places", force: :cascade do |t|
    t.integer "position"
    t.bigint "spot_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_spot_places_on_player_id"
    t.index ["spot_id"], name: "index_spot_places_on_spot_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.integer "row_number"
    t.bigint "squad_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["squad_id"], name: "index_spots_on_squad_id"
  end

  create_table "squads", force: :cascade do |t|
    t.string "name"
    t.integer "total_rows", default: 3
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_squads_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.date "current_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "notes", "players"
  add_foreign_key "players", "teams"
  add_foreign_key "spot_places", "players"
  add_foreign_key "spot_places", "spots"
  add_foreign_key "spots", "squads"
  add_foreign_key "squads", "teams"
  add_foreign_key "teams", "users"
end
