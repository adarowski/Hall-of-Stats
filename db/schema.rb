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

ActiveRecord::Schema.define(:version => 20180213185025) do

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
    t.string   "slug"
  end

  create_table "articles_players", :id => false, :force => true do |t|
    t.integer "article_id"
    t.string  "player_id"
  end

  add_index "articles_players", ["article_id", "player_id"], :name => "index_articles_players_on_article_id_and_player_id"

  create_table "franchise_ratings", :id => false, :force => true do |t|
    t.string   "player_id",    :null => false
    t.string   "franchise_id", :null => false
    t.decimal  "hall_rating"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "franchise_ratings", ["franchise_id"], :name => "index_franchise_ratings_on_franchise_id"
  add_index "franchise_ratings", ["player_id", "franchise_id"], :name => "index_franchise_ratings_on_player_id_and_franchise_id", :unique => true
  add_index "franchise_ratings", ["player_id"], :name => "index_franchise_ratings_on_player_id"

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
    t.float    "peak_pct"
    t.float    "longevity_pct"
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
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "photo_path"
    t.text     "bio"
    t.integer  "first_year"
    t.integer  "last_year"
    t.integer  "runs_pitch"
    t.string   "img_url"
    t.string   "alt_hof"
    t.boolean  "cover_model",        :default => false
    t.string   "compatibility_id"
    t.integer  "ranking_overall"
    t.integer  "ranking_position"
    t.integer  "ranking_hof"
    t.integer  "ranking_hos"
    t.text     "franchise_rankings"
    t.boolean  "personal_hof"
    t.boolean  "hom"
    t.boolean  "ross_hof"
    t.boolean  "bryan_hof"
    t.integer  "consensus"
    t.boolean  "dan_hof"
    t.boolean  "dalton_hof"
    t.string   "nickname"
    t.integer  "hof_year"
    t.string   "hof_via"
    t.string   "era_committee"
    t.integer  "ranking_eligible"
  end

  add_index "players", ["cover_model"], :name => "index_players_on_cover_model"
  add_index "players", ["era_committee"], :name => "index_players_on_era_committee"
  add_index "players", ["id"], :name => "index_players_on_id", :unique => true

  create_table "season_stats", :id => false, :force => true do |t|
    t.string   "player_id",    :null => false
    t.integer  "year",         :null => false
    t.float    "waa_tot",      :null => false
    t.float    "war_tot",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "team"
    t.string   "franchise_id"
    t.integer  "stint"
    t.string   "lg"
    t.float    "war_pos"
    t.float    "waa_pos"
    t.float    "war_p"
    t.float    "waa_p"
    t.float    "hall_rating"
  end

  add_index "season_stats", ["player_id"], :name => "index_season_stats_on_player_id"

  create_table "similarity_scores", :id => false, :force => true do |t|
    t.string   "player1_id", :null => false
    t.string   "player2_id", :null => false
    t.decimal  "score",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "similarity_scores", ["player1_id", "player2_id"], :name => "index_similarity_scores_on_player1_id_and_player2_id", :unique => true
  add_index "similarity_scores", ["player1_id"], :name => "index_similarity_scores_on_player1_id"
  add_index "similarity_scores", ["player2_id"], :name => "index_similarity_scores_on_player2_id"

  create_table "voting_results", :force => true do |t|
    t.string   "player_id",                       :null => false
    t.integer  "year",                            :null => false
    t.string   "vote_type",  :default => "bbwaa", :null => false
    t.integer  "ballots",                         :null => false
    t.integer  "votes",                           :null => false
    t.float    "pct",                             :null => false
    t.boolean  "inducted",   :default => false
    t.boolean  "dropped",    :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "voting_results", ["player_id"], :name => "index_voting_results_on_player_id"

end
