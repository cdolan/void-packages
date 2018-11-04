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

ActiveRecord::Schema.define(version: 2018_11_04_035559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arches", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_arches_on_name", unique: true
  end

  create_table "builds", force: :cascade do |t|
    t.bigint "arch_id", null: false
    t.bigint "package_id", null: false
    t.datetime "build_date", null: false
    t.string "filename_sha256", null: false
    t.bigint "filename_size", null: false
    t.bigint "installed_size", null: false
    t.index ["arch_id", "package_id"], name: "index_builds_on_arch_id_and_package_id", unique: true
    t.index ["arch_id"], name: "index_builds_on_arch_id"
    t.index ["package_id"], name: "index_builds_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "name", null: false
    t.string "homepage"
    t.string "license", null: false
    t.string "maintainer"
    t.string "version", null: false
    t.integer "revision", null: false
    t.string "description"
    t.string "source_revision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_packages_on_name", unique: true
  end

  add_foreign_key "builds", "arches", on_delete: :cascade
  add_foreign_key "builds", "packages", on_delete: :cascade
end
