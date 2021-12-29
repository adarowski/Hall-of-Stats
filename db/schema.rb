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

ActiveRecord::Schema.define(version: 20211227151847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.text     "body"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "namespace",     limit: 255
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "body"
    t.boolean  "published",                default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.datetime "published_at"
    t.string   "slug",         limit: 255
  end

  create_table "articles_players", id: false, force: :cascade do |t|
    t.integer "article_id"
    t.string  "player_id",  limit: 255
  end

  add_index "articles_players", ["article_id", "player_id"], name: "index_articles_players_on_article_id_and_player_id", using: :btree

  create_table "franchise_ratings", id: false, force: :cascade do |t|
    t.string   "player_id",    limit: 255, null: false
    t.string   "franchise_id", limit: 255, null: false
    t.decimal  "hall_rating"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "franchise_ratings", ["franchise_id"], name: "index_franchise_ratings_on_franchise_id", using: :btree
  add_index "franchise_ratings", ["player_id", "franchise_id"], name: "index_franchise_ratings_on_player_id_and_franchise_id", unique: true, using: :btree
  add_index "franchise_ratings", ["player_id"], name: "index_franchise_ratings_on_player_id", using: :btree

  create_table "players", id: false, force: :cascade do |t|
    t.string   "id",                 limit: 255
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.decimal  "waa0_tot"
    t.decimal  "war162_tot"
    t.decimal  "wwar"
    t.decimal  "hall_rating"
    t.string   "position",           limit: 255
    t.boolean  "hos"
    t.boolean  "hof"
    t.string   "eligibility",        limit: 255
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
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "photo_path",         limit: 255
    t.text     "bio"
    t.integer  "first_year"
    t.integer  "last_year"
    t.integer  "runs_pitch"
    t.string   "img_url",            limit: 255
    t.string   "alt_hof",            limit: 255
    t.boolean  "cover_model",                    default: false
    t.string   "compatibility_id",   limit: 255
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
    t.string   "nickname",           limit: 255
    t.integer  "hof_year"
    t.string   "hof_via",            limit: 255
    t.string   "era_committee",      limit: 255
    t.integer  "ranking_eligible"
    t.boolean  "has_mle",                        default: false
    t.boolean  "only_mle",                       default: false
    t.float    "mle_rating"
    t.string   "seamheads_id"
  end

  add_index "players", ["cover_model"], name: "index_players_on_cover_model", using: :btree
  add_index "players", ["era_committee"], name: "index_players_on_era_committee", using: :btree
  add_index "players", ["id"], name: "index_players_on_id", unique: true, using: :btree

  create_table "season_stats", id: false, force: :cascade do |t|
    t.string   "player_id",    limit: 255, null: false
    t.integer  "year",                     null: false
    t.float    "waa_tot",                  null: false
    t.float    "war_tot",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "team",         limit: 255
    t.string   "franchise_id", limit: 255
    t.integer  "stint"
    t.string   "lg",           limit: 255
    t.float    "war_pos"
    t.float    "waa_pos"
    t.float    "war_p"
    t.float    "waa_p"
    t.float    "hall_rating"
  end

  add_index "season_stats", ["player_id"], name: "index_season_stats_on_player_id", using: :btree

  create_table "similarity_scores", id: false, force: :cascade do |t|
    t.string   "player1_id", limit: 255, null: false
    t.string   "player2_id", limit: 255, null: false
    t.decimal  "score",                  null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "similarity_scores", ["player1_id"], name: "index_similarity_scores_on_player1_id", using: :btree

  create_table "voting_results", force: :cascade do |t|
    t.string   "player_id",  limit: 255,                   null: false
    t.integer  "year",                                     null: false
    t.string   "vote_type",  limit: 255, default: "bbwaa", null: false
    t.integer  "ballots",                                  null: false
    t.integer  "votes",                                    null: false
    t.float    "pct",                                      null: false
    t.boolean  "inducted",               default: false
    t.boolean  "dropped",                default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

end
