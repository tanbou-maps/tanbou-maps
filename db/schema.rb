# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_11_28_014958) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "application_users", force: :cascade do |t|
    t.string "nickname"
    t.string "email"
    t.string "password_digest"
    t.string "account_type"
    t.string "corporate_type"
    t.text "profile_picture_url"
    t.text "background_picture_url"
    t.text "favorite_spots"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user", null: false
    t.string "user_id", null: false
    t.index ["email"], name: "index_application_users_on_email"
    t.index ["user_id"], name: "index_application_users_on_user_id", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_spots", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "spot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_spots_on_category_id"
    t.index ["spot_id"], name: "index_categories_spots_on_spot_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_spots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "model_course_id", null: false
    t.bigint "spot_id", null: false
    t.integer "order_number", null: false
    t.integer "stay_time_minutes"
    t.string "transportation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_course_id", "order_number"], name: "index_course_spots_on_model_course_id_and_order_number", unique: true
    t.index ["model_course_id"], name: "index_course_spots_on_model_course_id"
    t.index ["spot_id"], name: "index_course_spots_on_spot_id"
  end

  create_table "event_categories", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_event_categories_on_category_id"
    t.index ["event_id"], name: "index_event_categories_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "capacity"
    t.text "fee"
    t.bigint "spot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["spot_id"], name: "index_events_on_spot_id"
  end

  create_table "images", force: :cascade do |t|
    t.text "url"
    t.bigint "spot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_images_on_spot_id"
  end

  create_table "logs", force: :cascade do |t|
    t.bigint "application_user_id", null: false
    t.string "action_type", null: false
    t.integer "target_id"
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_user_id"], name: "index_logs_on_application_user_id"
  end

  create_table "model_course_images", force: :cascade do |t|
    t.uuid "model_course_id", null: false
    t.string "url", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_course_id"], name: "index_model_course_images_on_model_course_id"
  end

  create_table "model_courses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "theme_image_url"
    t.boolean "is_public", default: false, null: false
    t.string "public_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_user_id"
    t.index ["application_user_id"], name: "index_model_courses_on_application_user_id"
    t.index ["public_key"], name: "index_model_courses_on_public_key", unique: true
  end

  create_table "review_images", force: :cascade do |t|
    t.text "url"
    t.text "description"
    t.bigint "review_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_review_images_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "spot_id", null: false
    t.bigint "application_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_user_id"], name: "index_reviews_on_application_user_id"
    t.index ["spot_id"], name: "index_reviews_on_spot_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.integer "stamp_count_required"
    t.text "reward_description"
    t.text "reward_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spot_details", force: :cascade do |t|
    t.bigint "spot_id", null: false
    t.text "hours_of_operation"
    t.text "access_info"
    t.text "contact_info"
    t.text "website_url"
    t.text "recommended_season"
    t.text "entry_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_spot_details_on_spot_id"
  end

  create_table "spot_tags", force: :cascade do |t|
    t.string "name"
    t.bigint "spot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_spot_tags_on_spot_id"
  end

  create_table "spots", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.point "location"
    t.integer "popularity_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.bigint "application_user_id"
    t.index ["application_user_id"], name: "index_spots_on_application_user_id"
  end

  create_table "stamps", force: :cascade do |t|
    t.bigint "application_user_id", null: false
    t.bigint "spot_id", null: false
    t.datetime "date"
    t.point "location"
    t.text "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending", null: false
    t.index ["application_user_id"], name: "index_stamps_on_application_user_id"
    t.index ["spot_id"], name: "index_stamps_on_spot_id"
  end

  create_table "user_rewards", force: :cascade do |t|
    t.bigint "application_user_id", null: false
    t.bigint "reward_id", null: false
    t.datetime "obtained_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "obtained", default: false, null: false
    t.index ["application_user_id"], name: "index_user_rewards_on_application_user_id"
    t.index ["reward_id"], name: "index_user_rewards_on_reward_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories_spots", "categories"
  add_foreign_key "categories_spots", "spots"
  add_foreign_key "course_spots", "model_courses"
  add_foreign_key "course_spots", "spots"
  add_foreign_key "event_categories", "categories"
  add_foreign_key "event_categories", "events"
  add_foreign_key "events", "spots"
  add_foreign_key "images", "spots"
  add_foreign_key "logs", "application_users"
  add_foreign_key "model_course_images", "model_courses"
  add_foreign_key "model_courses", "application_users"
  add_foreign_key "review_images", "reviews"
  add_foreign_key "reviews", "application_users"
  add_foreign_key "reviews", "spots"
  add_foreign_key "spot_details", "spots"
  add_foreign_key "spot_tags", "spots"
  add_foreign_key "spots", "application_users"
  add_foreign_key "stamps", "application_users"
  add_foreign_key "stamps", "spots"
  add_foreign_key "user_rewards", "application_users"
  add_foreign_key "user_rewards", "rewards"
end
