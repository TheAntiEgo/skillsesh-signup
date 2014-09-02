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

ActiveRecord::Schema.define(version: 20140902054929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "authentications", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "provider"
    t.string   "provider_id"
    t.string   "provider_token"
    t.datetime "provider_token_expires_at"
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "provider_id"], name: "index_authentications_on_provider_and_provider_id", unique: true, using: :btree

  create_table "courses", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.text     "goal"
    t.text     "how"
    t.text     "requirements"
    t.decimal  "duration"
    t.decimal  "price"
    t.integer  "location"
    t.uuid     "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["instructor_id"], name: "index_courses_on_instructor_id", using: :btree

  create_table "courses_skills", id: false, force: true do |t|
    t.uuid "course_id"
    t.uuid "skill_id"
  end

  add_index "courses_skills", ["course_id"], name: "index_courses_skills_on_course_id", using: :btree
  add_index "courses_skills", ["skill_id"], name: "index_courses_skills_on_skill_id", using: :btree

  create_table "profiles", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "bio"
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "skills", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string "email",          null: false
    t.uuid   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", unique: true, using: :btree

end
