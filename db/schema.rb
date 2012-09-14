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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120914001909) do

  create_table "players", :id => false, :force => true do |t|
    t.string   "id"
    t.string   "first_name"
    t.string   "last_name"
    t.decimal  "waa0_tot"
    t.decimal  "war162_tot"
    t.decimal  "wwar"
    t.decimal  "hall_rating"
    t.string   "position"
    t.boolean  "hos"
    t.boolean  "hof"
    t.string   "eligibility"
    t.integer  "peak_pct"
    t.integer  "longevity_pct"
    t.decimal  "runs_bat"
    t.decimal  "runs_br"
    t.decimal  "runs_dp"
    t.decimal  "runs_defense"
    t.decimal  "runs_totalpos"
    t.integer  "pa"
    t.decimal  "war_pos"
    t.decimal  "war162_pos"
    t.decimal  "waa_pos"
    t.integer  "ip_outs"
    t.decimal  "war_p"
    t.decimal  "war162_p"
    t.decimal  "waa_p"
    t.decimal  "war_tot"
    t.decimal  "waa_tot"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "photo_path"
    t.text     "editable_bio"
    t.text     "rendered_bio"
  end

  add_index "players", ["id"], :name => "index_players_on_id", :unique => true

end
