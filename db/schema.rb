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

ActiveRecord::Schema.define(version: 20170508132444) do

  create_table "answers", force: :cascade do |t|
    t.string   "answer"
    t.integer  "tf"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "freelancer_categories", force: :cascade do |t|
    t.float    "skill_point"
    t.float    "experience_point"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["category_id"], name: "index_freelancer_categories_on_category_id"
    t.index ["user_id"], name: "index_freelancer_categories_on_user_id"
  end

  create_table "joiners", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "work_id"
    t.date     "joined_date"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_joiners_on_user_id"
    t.index ["work_id"], name: "index_joiners_on_work_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "question"
    t.integer  "level"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_questions_on_category_id"
  end

  create_table "review_freelancers", force: :cascade do |t|
    t.string   "content"
    t.float    "rank"
    t.integer  "joiner_id"
    t.integer  "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["joiner_id"], name: "index_review_freelancers_on_joiner_id"
    t.index ["work_id"], name: "index_review_freelancers_on_work_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "fullname"
    t.string   "gender"
    t.string   "email"
    t.string   "contact"
    t.string   "info"
    t.integer  "role_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "work_categories", force: :cascade do |t|
    t.integer  "work_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_work_categories_on_category_id"
    t.index ["work_id"], name: "index_work_categories_on_work_id"
  end

  create_table "works", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "price"
    t.date     "created_date"
    t.date     "deadline"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_works_on_user_id"
  end

end
