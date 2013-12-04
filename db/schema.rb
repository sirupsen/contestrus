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

ActiveRecord::Schema.define(version: 20131202123524) do

  create_table "comedy_jobs", force: true do |t|
    t.string   "class_name", null: false
    t.text     "ivars",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitions", force: true do |t|
    t.string   "name",       null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: true do |t|
    t.text     "source",                             null: false
    t.integer  "task_id",                            null: false
    t.integer  "user_id",                            null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "path",                               null: false
    t.string   "status",         default: "Pending", null: false
    t.text     "body"
    t.boolean  "passed",         default: false
    t.string   "language",                           null: false
    t.integer  "competition_id"
  end

  add_index "submissions", ["task_id", "passed"], name: "index_submissions_on_task_id_and_passed"
  add_index "submissions", ["task_id", "user_id"], name: "index_submissions_on_task_id_and_user_id"

  create_table "tasks", force: true do |t|
    t.integer  "competition_id",                 null: false
    t.string   "name",                           null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "body"
    t.text     "restrictions",   default: "",    null: false
    t.string   "scoring",        default: "acm"
  end

  add_index "tasks", ["competition_id"], name: "index_tasks_on_competition_id"

  create_table "test_cases", force: true do |t|
    t.text     "input",      null: false
    t.text     "output",     null: false
    t.integer  "task_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "test_cases", ["task_id"], name: "index_test_cases_on_task_id"

  create_table "users", force: true do |t|
    t.string   "username",                        null: false
    t.string   "password_digest",                 null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "email",                           null: false
    t.boolean  "admin",           default: false, null: false
    t.string   "session_hash",                    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
