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

ActiveRecord::Schema.define(version: 20160517203032) do

  create_table "games", force: :cascade do |t|
    t.integer  "away_team_id",          null: false
    t.integer  "home_team_id",          null: false
    t.integer  "winner_team_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "final_home_team_score"
    t.integer  "final_away_team_score"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "games", ["away_team_id"], name: "index_games_on_away_team_id"
  add_index "games", ["home_team_id"], name: "index_games_on_home_team_id"
  add_index "games", ["winner_team_id"], name: "index_games_on_winner_team_id"

  create_table "player_games", force: :cascade do |t|
    t.integer  "game_id",                null: false
    t.integer  "player_id",              null: false
    t.integer  "score",      default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "player_games", ["game_id"], name: "index_player_games_on_game_id"
  add_index "player_games", ["player_id"], name: "index_player_games_on_player_id"

  create_table "player_teams", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.integer  "player_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "player_teams", ["player_id"], name: "index_player_teams_on_player_id"
  add_index "player_teams", ["team_id"], name: "index_player_teams_on_team_id"

  create_table "players", force: :cascade do |t|
    t.string   "name",               null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "win_count",  default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "player_id",               null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "videos", ["player_id"], name: "index_videos_on_player_id"

end
