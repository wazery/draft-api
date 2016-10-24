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

ActiveRecord::Schema.define(version: 20161024224451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artboards", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "object_id"
    t.string   "page_object_id"
    t.string   "page_name"
    t.string   "name"
    t.string   "slug"
    t.integer  "status"
    t.integer  "width"
    t.integer  "height"
    t.datetime "due_date"
    t.string   "token"
    t.json     "layers"
    t.json     "slices"
    t.json     "exportables"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "artboard_image_file_name"
    t.string   "artboard_image_content_type"
    t.integer  "artboard_image_file_size"
    t.datetime "artboard_image_updated_at"
    t.index ["project_id"], name: "index_artboards_on_project_id", using: :btree
  end

  create_table "beta_requesters", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.integer  "team_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["email"], name: "index_invites_on_email", using: :btree
    t.index ["recipient_id"], name: "index_invites_on_recipient_id", using: :btree
    t.index ["sender_id"], name: "index_invites_on_sender_id", using: :btree
    t.index ["team_id"], name: "index_invites_on_team_id", using: :btree
    t.index ["token"], name: "index_invites_on_token", using: :btree
  end

  create_table "links", force: :cascade do |t|
    t.integer  "artboard_id"
    t.string   "link"
    t.boolean  "public"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["artboard_id"], name: "index_links_on_artboard_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.index ["team_id"], name: "index_memberships_on_team_id", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "artboard_id"
    t.string   "object_id"
    t.text     "note"
    t.json     "rect"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["artboard_id"], name: "index_notes_on_artboard_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "platform"
    t.string   "thumb"
    t.string   "scale"
    t.string   "unit"
    t.string   "color_format"
    t.integer  "artboards_count", default: 0
    t.json     "slices"
    t.json     "colors"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",          default: 0
    t.index ["slug"], name: "index_projects_on_slug", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string  "taggable_type"
    t.integer "taggable_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "artboard_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["artboard_id"], name: "index_tags_on_artboard_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.integer "project_id"
    t.index ["project_id"], name: "index_teams_on_project_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: ""
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "name"
    t.string   "nickname"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "teams", "projects"
end
