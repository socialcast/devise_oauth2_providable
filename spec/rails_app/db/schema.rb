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

ActiveRecord::Schema.define(:version => 20110511210926) do

  create_table "access_tokens", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.integer  "refresh_token_id"
    t.string   "token"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["client_id"], :name => "index_access_tokens_on_client_id"
  add_index "access_tokens", ["expires_at"], :name => "index_access_tokens_on_expires_at"
  add_index "access_tokens", ["token"], :name => "index_access_tokens_on_token", :unique => true
  add_index "access_tokens", ["user_id"], :name => "index_access_tokens_on_user_id"

  create_table "authorization_codes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.string   "token"
    t.datetime "expires_at"
    t.string   "redirect_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorization_codes", ["client_id"], :name => "index_authorization_codes_on_client_id"
  add_index "authorization_codes", ["expires_at"], :name => "index_authorization_codes_on_expires_at"
  add_index "authorization_codes", ["token"], :name => "index_authorization_codes_on_token", :unique => true
  add_index "authorization_codes", ["user_id"], :name => "index_authorization_codes_on_user_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "redirect_uri"
    t.string   "website"
    t.string   "identifier"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["identifier"], :name => "index_clients_on_identifier", :unique => true

  create_table "refresh_tokens", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.string   "token"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refresh_tokens", ["client_id"], :name => "index_refresh_tokens_on_client_id"
  add_index "refresh_tokens", ["expires_at"], :name => "index_refresh_tokens_on_expires_at"
  add_index "refresh_tokens", ["token"], :name => "index_refresh_tokens_on_token", :unique => true
  add_index "refresh_tokens", ["user_id"], :name => "index_refresh_tokens_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128, :default => "", :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
