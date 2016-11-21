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

ActiveRecord::Schema.define(version: 20130729000000) do

  create_table "moves", force: :cascade do |t|
    t.string  "san",              limit: 7
    t.integer "from_position_id", limit: 4
    t.integer "to_position_id",   limit: 4
    t.integer "total",            limit: 4, default: 0
  end

  add_index "moves", ["from_position_id"], name: "index_moves_on_from_position_id", using: :btree
  add_index "moves", ["to_position_id", "from_position_id"], name: "index_moves_on_to_position_id_and_from_position_id", unique: true, using: :btree

  create_table "positions", force: :cascade do |t|
    t.integer "zhash",             limit: 8
    t.string  "fen",               limit: 81
    t.string  "comment",           limit: 255
    t.integer "total",             limit: 4,   default: 0
    t.integer "white",             limit: 4,   default: 0
    t.integer "draw",              limit: 4,   default: 0
    t.integer "score",             limit: 4
    t.integer "score_white_best",  limit: 4
    t.integer "score_black_best",  limit: 4
    t.integer "score_theoretical", limit: 4
    t.integer "white_elo_total",   limit: 8,   default: 0
    t.integer "black_elo_total",   limit: 8,   default: 0
  end

  add_index "positions", ["zhash"], name: "index_positions_on_zhash", unique: true, using: :btree

end
