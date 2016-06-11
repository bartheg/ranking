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

ActiveRecord::Schema.define(version: 20160611210530) do

  create_table "default_ladder_configs", force: :cascade do |t|
    t.integer  "default_ranking"
    t.integer  "loot_factor"
    t.integer  "loot_constant"
    t.integer  "disproportion_factor"
    t.integer  "draw_factor"
    t.integer  "hours_to_confirm"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "is_default",           default: false, null: false
    t.integer  "ladder_id"
  end

  add_index "default_ladder_configs", ["ladder_id"], name: "index_default_ladder_configs_on_ladder_id", unique: true

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

  create_table "possible_results", force: :cascade do |t|
    t.integer  "score_factor"
    t.string   "description"
    t.integer  "game_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "possible_results", ["game_id"], name: "index_possible_results_on_game_id"

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

  create_table "rankings", force: :cascade do |t|
    t.integer  "ladder_id"
    t.integer  "profile_id"
    t.integer  "value"
    t.integer  "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rankings", ["ladder_id"], name: "index_rankings_on_ladder_id"
  add_index "rankings", ["profile_id"], name: "index_rankings_on_profile_id"
  add_index "rankings", ["report_id"], name: "index_rankings_on_report_id"

  create_table "report_comments", force: :cascade do |t|
    t.integer  "report_id"
    t.integer  "profile_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "report_comments", ["profile_id"], name: "index_report_comments_on_profile_id"
  add_index "report_comments", ["report_id"], name: "index_report_comments_on_report_id"

  create_table "reports", force: :cascade do |t|
    t.integer  "scenario_id"
    t.integer  "reporter_id"
    t.integer  "confirmer_id"
    t.integer  "reporters_faction_id"
    t.integer  "confirmers_faction_id"
    t.integer  "result_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "status",                default: 0
  end

  add_index "reports", ["confirmer_id"], name: "index_reports_on_confirmer_id"
  add_index "reports", ["confirmers_faction_id"], name: "index_reports_on_confirmers_faction_id"
  add_index "reports", ["reporter_id"], name: "index_reports_on_reporter_id"
  add_index "reports", ["reporters_faction_id"], name: "index_reports_on_reporters_faction_id"
  add_index "reports", ["scenario_id"], name: "index_reports_on_scenario_id"

  create_table "result_sets", force: :cascade do |t|
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "result_sets", ["game_id"], name: "index_result_sets_on_game_id"

  create_table "results", force: :cascade do |t|
    t.integer  "score"
    t.string   "description"
    t.integer  "result_set_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "results", ["result_set_id"], name: "index_results_on_result_set_id"

  create_table "scenarios", force: :cascade do |t|
    t.string   "full_name"
    t.string   "short_name"
    t.text     "description"
    t.boolean  "mirror_matchups_allowed"
    t.integer  "ladder_id"
    t.string   "map_size"
    t.boolean  "map_random_generated"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "scenarios", ["ladder_id"], name: "index_scenarios_on_ladder_id"

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
