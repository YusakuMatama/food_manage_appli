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

ActiveRecord::Schema.define(version: 20190729105200) do

  create_table "food_eatings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "food_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_food_eatings_on_food_id", using: :btree
    t.index ["user_id"], name: "index_food_eatings_on_user_id", using: :btree
  end

  create_table "foods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",             null: false
    t.integer  "calorie",          null: false
    t.string   "hiragana_name",    null: false
    t.integer  "menu_id",          null: false
    t.integer  "menu_category_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["menu_category_id"], name: "index_foods_on_menu_category_id", using: :btree
    t.index ["menu_id"], name: "index_foods_on_menu_id", using: :btree
  end

  create_table "menu_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
  end

  create_table "menus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
  end

  create_table "metabolisms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "age_base",                           null: false
    t.string   "gender",                             null: false
    t.float    "base_metabolic_standard", limit: 24, null: false
    t.float    "base_weight",             limit: 24, null: false
    t.integer  "base_metabolic_rate",                null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "user_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",           null: false
    t.integer  "age",            null: false
    t.string   "gender",         null: false
    t.integer  "weight"
    t.integer  "est_energy_req", null: false
    t.integer  "metabolism_id",  null: false
    t.integer  "user_id",        null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["metabolism_id"], name: "index_user_statuses_on_metabolism_id", using: :btree
    t.index ["user_id"], name: "index_user_statuses_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "line_id",                             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "food_eatings", "foods"
  add_foreign_key "food_eatings", "users"
  add_foreign_key "foods", "menu_categories"
  add_foreign_key "foods", "menus"
  add_foreign_key "user_statuses", "metabolisms"
  add_foreign_key "user_statuses", "users"
end
