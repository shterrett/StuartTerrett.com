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

ActiveRecord::Schema.define(version: 20130707122024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abouts", force: true do |t|
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employment_techs", force: true do |t|
    t.integer  "technology_id"
    t.integer  "employment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employments", force: true do |t|
    t.string   "company"
    t.string   "position"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "project_techs", force: true do |t|
    t.integer "project_id"
    t.integer "technology_id"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "short_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.integer  "employment_id"
  end

  create_table "technologies", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

end
