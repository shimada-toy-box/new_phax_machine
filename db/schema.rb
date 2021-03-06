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

ActiveRecord::Schema.define(version: 2018_12_18_043113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fax_numbers", force: :cascade do |t|
    t.integer "organization_id"
    t.string "manager_label"
    t.string "label"
    t.string "fax_number", null: false
    t.boolean "has_webhook_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "org_switched_at"
    t.index ["deleted_at"], name: "index_fax_numbers_on_deleted_at"
    t.index ["org_switched_at"], name: "index_fax_numbers_on_org_switched_at"
  end

  create_table "logo_links", force: :cascade do |t|
    t.string "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.integer "manager_id"
    t.string "label", null: false
    t.string "fax_tag"
    t.boolean "fax_numbers_purchasable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_organizations_on_deleted_at"
  end

  create_table "user_fax_numbers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "fax_number_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_permissions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "permission", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_permissions_on_deleted_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer "organization_id"
    t.string "email", null: false
    t.string "caller_id_number"
    t.string "fax_tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
