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

ActiveRecord::Schema.define(version: 20161103224603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.string   "amount"
    t.string   "unit"
    t.integer  "spoon_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.string   "plan_name"
    t.string   "time_frame"
    t.integer  "calories"
    t.text     "recipe_collection"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["user_id"], name: "index_plans_on_user_id", using: :btree
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "title"
    t.integer  "cook_time_minutes"
    t.integer  "spoon_id"
    t.integer  "plan_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "instructions"
    t.index ["plan_id"], name: "index_recipes_on_plan_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",           null: false
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
