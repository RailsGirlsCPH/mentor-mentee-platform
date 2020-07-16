# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_24_193617) do

  create_table "api_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "city"
    t.string "email", default: "", null: false
    t.boolean "mentor", null: false
    t.boolean "mentee", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_api_users_on_authentication_token", unique: true
    t.index ["email", "mentor", "mentee"], name: "index_api_users_on_email_and_mentor_and_mentee"
    t.index ["email"], name: "index_api_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_api_users_on_reset_password_token", unique: true
  end

  create_table "experiences", force: :cascade do |t|
    t.boolean "available_offline"
    t.boolean "available_online"
    t.string "qualification"
    t.integer "api_user_id"
    t.integer "programminglanguage_id"
    t.integer "meetinginterval_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["api_user_id"], name: "index_experiences_on_api_user_id"
    t.index ["meetinginterval_id"], name: "index_experiences_on_meetinginterval_id"
    t.index ["programminglanguage_id"], name: "index_experiences_on_programminglanguage_id"
  end

  create_table "meetingintervals", force: :cascade do |t|
    t.string "interval"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "models", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_models_on_email", unique: true
    t.index ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true
  end

  create_table "programminglanguages", force: :cascade do |t|
    t.string "language"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wishes", force: :cascade do |t|
    t.boolean "available_offline"
    t.boolean "available_online"
    t.string "goal"
    t.integer "api_user_id"
    t.integer "programminglanguage_id"
    t.integer "meetinginterval_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["api_user_id"], name: "index_wishes_on_api_user_id"
    t.index ["meetinginterval_id"], name: "index_wishes_on_meetinginterval_id"
    t.index ["programminglanguage_id"], name: "index_wishes_on_programminglanguage_id"
  end

  add_foreign_key "experiences", "api_users"
  add_foreign_key "wishes", "api_users"
end
