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

ActiveRecord::Schema.define(:version => 20120415132811) do

  create_table "gem_files", :force => true do |t|
    t.string   "file"
    t.integer  "rubygem_version_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gem_files", ["rubygem_version_id"], :name => "index_gem_files_on_rubygems_version_id"

  create_table "pipegems", :force => true do |t|
    t.string "name"
  end

  create_table "rubygem_files", :force => true do |t|
    t.string   "file"
    t.integer  "rubygem_version_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rubygem_files", ["rubygem_version_id"], :name => "index_rubygem_files_on_rubygem_version_id"

  create_table "rubygem_versions", :force => true do |t|
    t.integer  "rubygem_id"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
  end

  add_index "rubygem_versions", ["rubygem_id"], :name => "index_rubygem_versions_on_rubygem_id"

  create_table "rubygems", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rubygems", ["user_id"], :name => "index_rubygems_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "github_token"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "version_files", :force => true do |t|
    t.integer  "version_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "file"
  end

  create_table "versions", :force => true do |t|
    t.integer  "pipegem_id"
    t.string   "name"
    t.boolean  "published",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

end
