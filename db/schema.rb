# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160414132244) do

  create_table "faction_to_scenario_assignments", force: :cascade do |t|
    t.integer  "faction_id"
    t.integer  "scenario_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "faction_to_scenario_assignments", ["faction_id"], name: "index_faction_to_scenario_assignments_on_faction_id"
  add_index "faction_to_scenario_assignments", ["scenario_id"], name: "index_faction_to_scenario_assignments_on_scenario_id"

  create_table "factions", force: :cascade do |t|
    t.string   "full_name"
    t.string   "short_name"
    t.text     "description"
    t.boolean  "scenario_dependent"
    t.integer  "game_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "factions", ["full_name"], name: "index_factions_on_full_name", unique: true
  add_index "factions", ["game_id"], name: "index_factions_on_game_id"
  add_index "factions", ["short_name"], name: "index_factions_on_short_name", unique: true

  create_table "games", force: :cascade do |t|
    t.string   "full_name"
    t.string   "short_name"
    t.text     "description"
    t.boolean  "simultaneous_turns"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "games", ["full_name"], name: "index_games_on_full_name", unique: true
  add_index "games", ["short_name"], name: "index_games_on_short_name", unique: true

  create_table "ladders", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "game_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ladders", ["game_id"], name: "index_ladders_on_game_id"
  add_index "ladders", ["name"], name: "index_ladders_on_name", unique: true

  create_table "languages", force: :cascade do |t|
    t.string   "iso_639_1"
    t.string   "english_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "languages_profiles", id: false, force: :cascade do |t|
    t.integer "language_id"
    t.integer "profile_id"
  end

  add_index "languages_profiles", ["language_id", "profile_id"], name: "index_languages_profiles_on_language_id_and_profile_id"

  create_table "maps", force: :cascade do |t|
    t.string   "full_name"
    t.string   "short_name"
    t.string   "size"
    t.text     "description"
    t.boolean  "random_generated"
    t.integer  "scenario_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "maps", ["scenario_id"], name: "index_maps_on_scenario_id"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "description"
    t.string   "color"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
  end

  add_index "profiles", ["name"], name: "index_profiles_on_name", unique: true
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "scenarios", force: :cascade do |t|
    t.string   "full_name"
    t.string   "short_name"
    t.text     "description"
    t.boolean  "mirror_matchups_allowed"
    t.integer  "game_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "scenarios", ["game_id"], name: "index_scenarios_on_game_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "profile_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["profile_id"], name: "index_users_on_profile_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
