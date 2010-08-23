# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100212112457) do

  create_table "daily_analytics", :force => true do |t|
    t.integer  "movie_id"
    t.string   "movie_name"
    t.datetime "run_date"
    t.integer  "show_count"
    t.float    "show_percent"
  end

  create_table "movies", :force => true do |t|
    t.string "name"
    t.string "genre"
    t.text   "cast"
  end

  create_table "opinions", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.integer  "movie_id",                           :null => false
    t.boolean  "seen",            :default => false
    t.boolean  "watchable",       :default => false
    t.boolean  "watchable_twice", :default => false
    t.boolean  "watchable_multi", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", :force => true do |t|
    t.integer  "theater_id"
    t.integer  "movie_id"
    t.datetime "start"
  end

  create_table "theaters", :force => true do |t|
    t.string "name"
    t.text   "location"
  end

  create_table "users", :force => true do |t|
    t.string   "login",               :default => "", :null => false
    t.string   "email",               :default => "", :null => false
    t.string   "crypted_password",    :default => "", :null => false
    t.string   "password_salt",       :default => "", :null => false
    t.string   "persistence_token",   :default => "", :null => false
    t.string   "single_access_token", :default => "", :null => false
    t.string   "perishable_token",    :default => "", :null => false
    t.integer  "login_count",         :default => 0,  :null => false
    t.integer  "failed_login_count",  :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
