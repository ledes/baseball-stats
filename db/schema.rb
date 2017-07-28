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

ActiveRecord::Schema.define(version: 20170701231149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string "name",       null: false
    t.string "given_name"
    t.string "position",   null: false
    t.string "type"
  end

  create_table "statistics", force: :cascade do |t|
    t.integer "player_id",       null: false
    t.integer "season",          null: false
    t.integer "games"
    t.integer "games_started"
    t.integer "at_bats",         null: false
    t.integer "runs"
    t.integer "hits",            null: false
    t.integer "doubles",         null: false
    t.integer "triples",         null: false
    t.integer "home_runs",       null: false
    t.integer "rbi",             null: false
    t.integer "caught_stealing"
    t.integer "sacrifice_hits"
    t.integer "sacrifice_flies", null: false
    t.integer "player_errors"
    t.integer "pb"
    t.integer "walks",           null: false
    t.integer "struck_out"
    t.integer "hit_by_pitch",    null: false
    t.integer "sb",              null: false
    t.string  "avg"
    t.string  "ops"
    t.index ["player_id"], name: "index_statistics_on_player_id", using: :btree
  end

end
