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

ActiveRecord::Schema.define(version: 20131020045603) do

  create_table "comedy_jobs", force: true do |t|
    t.string   "class_name", null: false
    t.text     "ivars",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: true do |t|
    t.text     "body"
    t.boolean  "passed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "submission_id"
    t.string   "status"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.string   "extension"
    t.string   "image"
    t.string   "build"
    t.string   "run"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", force: true do |t|
    t.text     "source"
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "language_id"
    t.string   "path"
  end

  create_table "tasks", force: true do |t|
    t.integer  "competition_id"
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
    t.text     "restrictions"
  end

  create_table "test_cases", force: true do |t|
    t.text     "input"
    t.text     "output"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.boolean  "admin"
  end

  add_index "users", ["id"], name: "index_users_on_id"

end
