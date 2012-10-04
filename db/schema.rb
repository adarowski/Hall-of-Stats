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

ActiveRecord::Schema.define(:version => 20121004015215) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published",    :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.datetime "published_at"
  end

  create_table "articles_players", :id => false, :force => true do |t|
    t.integer "article_id"
    t.string  "player_id"
  end

  add_index "articles_players", ["article_id", "player_id"], :name => "index_articles_players_on_article_id_and_player_id"

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
    t.text     "bio"
    t.integer  "first_year"
    t.integer  "last_year"
    t.integer  "runs_pitch"
    t.string   "img_url"
  end

  add_index "players", ["id"], :name => "index_players_on_id", :unique => true

end
