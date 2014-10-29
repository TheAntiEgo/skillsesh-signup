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

ActiveRecord::Schema.define(version: 20141027201620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "provider_id"
    t.string   "provider_token"
    t.string   "provider_token_expires_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "provider_id"], name: "index_authentications_on_provider_and_provider_id", unique: true, using: :btree

  create_table "conversations", force: true do |t|
    t.integer  "customer_id"
    t.integer  "merchant_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["course_id"], name: "index_conversations_on_course_id", using: :btree
  add_index "conversations", ["customer_id"], name: "index_conversations_on_customer_id", using: :btree
  add_index "conversations", ["merchant_id"], name: "index_conversations_on_merchant_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "name"
    t.text     "goal"
    t.text     "how"
    t.text     "requirements"
    t.decimal  "duration"
    t.decimal  "price"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "instructor_id"
  end

  add_index "courses", ["instructor_id"], name: "index_courses_on_instructor_id", using: :btree

  create_table "courses_skills", id: false, force: true do |t|
    t.integer "course_id"
    t.integer "skill_id"
  end

  add_index "courses_skills", ["course_id"], name: "index_courses_skills_on_course_id", using: :btree
  add_index "courses_skills", ["skill_id"], name: "index_courses_skills_on_skill_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.text     "content"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conversation_id"
    t.integer  "parent_id"
    t.boolean  "read",            default: false
    t.integer  "recepient_id"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["parent_id"], name: "index_messages_on_parent_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "preferences", force: true do |t|
    t.boolean  "new_messages", default: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferences", ["user_id"], name: "index_preferences_on_user_id", using: :btree

  create_table "skills", force: true do |t|
    t.string   "name",       limit: 20, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["name"], name: "index_skills_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string "email",          null: false
    t.uuid   "remember_token", null: false
    t.string "first_name",     null: false
    t.string "last_name",      null: false
    t.text   "bio",            null: false
    t.string "photo",          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", unique: true, using: :btree

  create_table "users_skills", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "skill_id"
  end

end
