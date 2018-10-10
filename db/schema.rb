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

ActiveRecord::Schema.define(version: 20181007104209) do

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "schedule_id"
    t.string   "status"
    t.string   "comment"
    t.string   "part"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["schedule_id"], name: "index_answers_on_schedule_id", using: :btree
    t.index ["user_id", "schedule_id"], name: "index_answers_on_user_id_and_schedule_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_answers_on_user_id", using: :btree
  end

  create_table "schedules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "event"
    t.date     "event_date"
    t.time     "start_at"
    t.time     "end_at"
    t.string   "location"
    t.string   "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_schedules_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "part"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "answers", "schedules"
  add_foreign_key "answers", "users"
  add_foreign_key "schedules", "users"
end
