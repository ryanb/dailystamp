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

ActiveRecord::Schema.define(:version => 20091031172658) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stamp_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marks", :force => true do |t|
    t.integer  "stamp_id"
    t.boolean  "skip",       :default => false, :null => false
    t.date     "marked_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position_x"
    t.integer  "position_y"
  end

  create_table "month_caches", :force => true do |t|
    t.integer  "stamp_id"
    t.integer  "positive_points"
    t.integer  "negative_points"
    t.integer  "position"
    t.integer  "score"
    t.date     "for_month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "stamp_images", :force => true do |t|
    t.integer  "user_id"
    t.datetime "generated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stamps", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score_cache"
    t.string   "color"
    t.integer  "stamp_image_id"
    t.integer  "goal_score"
    t.text     "goal_reward"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_stamp_id"
    t.string   "openid_identifier"
    t.boolean  "guest",             :default => false, :null => false
    t.string   "time_zone"
  end

end
