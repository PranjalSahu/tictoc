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

ActiveRecord::Schema.define(version: 201505041051278) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"
  enable_extension "btree_gist"
  enable_extension "pg_stat_statements"

  create_table "access_profiles", force: :cascade do |t|
    t.string   "access_name"
    t.integer  "team_id"
    t.integer  "role_id"
    t.json     "access"
    t.integer  "parent_profile_id"
    t.integer  "status",            default: 0
    t.integer  "created_by_id"
    t.integer  "modified_by_ids",   default: [],              array: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "access_category",   default: 0,  null: false
  end

  create_table "account_details", force: :cascade do |t|
    t.integer  "hotel_id"
    t.string   "name"
    t.string   "bank_name"
    t.text     "bank_address"
    t.string   "bank_account_no"
    t.integer  "account_type"
    t.string   "bank_ifsc_code"
    t.string   "bank_micr_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "service_tax_no"
    t.string   "pan_no"
    t.string   "vat_no"
    t.string   "cst_no"
    t.integer  "credit_limit",                                 default: 0
    t.integer  "credit_usage_period",                          default: 0
    t.date     "last_billed_date"
    t.integer  "settlement_period",                            default: 0
    t.decimal  "discount",            precision: 12, scale: 3, default: 0.0
    t.integer  "discount_type",                                default: 0
    t.boolean  "btc_allowed",                                  default: false
    t.integer  "status",                                       default: 0
    t.json     "commision"
    t.boolean  "skip_prepaid",                                 default: false
    t.integer  "payment_method",                               default: 0
    t.integer  "wallet_id"
    t.integer  "ach_status",                                   default: 0
    t.integer  "share_pc"
    t.boolean  "coupon_allowed",                               default: false
  end

  add_index "account_details", ["hotel_id"], name: "index_account_details_on_hotel_id", using: :btree
  add_index "account_details", ["item_id", "item_type"], name: "index_account_details_on_item_id_and_item_type", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.integer  "booking_id"
    t.float    "host_share",             default: 0.0,   null: false
    t.float    "oyo_share",              default: 0.0,   null: false
    t.float    "source_share",           default: 0.0,   null: false
    t.integer  "room_nights",            default: 0,     null: false
    t.boolean  "manual",                 default: false, null: false
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "host_share_first_cycle", default: 0.0
    t.float    "tax_payable_to_host",    default: 0.0
    t.float    "booking_advance",        default: 0.0
    t.integer  "month"
    t.integer  "year"
    t.float    "tariff_amount",          default: 0.0,   null: false
    t.float    "oyo_bill_amount",        default: 0.0,   null: false
    t.float    "owner_bill_amount",      default: 0.0,   null: false
    t.integer  "acc_type",               default: 0,     null: false
    t.integer  "host_orr",               default: 0
    t.float    "payable_host_share"
    t.float    "payment_to_host"
    t.float    "payment_to_oyo"
    t.float    "payment_to_source"
    t.float    "host_meal_share"
    t.float    "oyo_meal_share"
    t.integer  "hotel_id"
  end

  add_index "accounts", ["booking_id"], name: "index_accounts_on_booking_id", using: :btree
  add_index "accounts", ["hotel_id", "year", "month"], name: "index_accounts_on_hotel_id_and_year_and_month", using: :btree
  add_index "accounts", ["month", "year", "booking_id"], name: "index_accounts_on_month_and_year_and_booking_id", unique: true, using: :btree

  create_table "affiliates", force: :cascade do |t|
    t.integer  "api_client_id",                  null: false
    t.string   "name",                           null: false
    t.text     "affiliate_details"
    t.integer  "account_manager_id",             null: false
    t.integer  "status",             default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "billing_name"
    t.text     "billing_address"
    t.integer  "admin_id"
  end

  add_index "affiliates", ["api_client_id"], name: "index_affiliates_on_api_client_id", using: :btree

  create_table "agreements", force: :cascade do |t|
    t.float    "rs"
    t.integer  "ft"
    t.integer  "ft_double"
    t.integer  "ft_triple"
    t.integer  "mgft"
    t.integer  "mgft_double"
    t.integer  "mgft_triple"
    t.integer  "mg_rooms"
    t.float    "early_checkin_host_share"
    t.float    "late_checkout_host_share"
    t.integer  "rooms",                                                           null: false
    t.boolean  "active",                                           default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_peak_buyout"
    t.integer  "agreement_type"
    t.integer  "default_rooms"
    t.integer  "mg_rooms_array",                                   default: [],                array: true
    t.decimal  "penalty_percent",          precision: 5, scale: 2
  end

  create_table "api_clients", force: :cascade do |t|
    t.string   "client_name",    limit: 255
    t.string   "app_key",        limit: 255
    t.string   "app_secret",     limit: 255
    t.string   "permissions",    limit: 255
    t.string   "client_details", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
  end

  add_index "api_clients", ["app_key"], name: "index_api_clients_on_app_key", using: :btree
  add_index "api_clients", ["client_name"], name: "index_api_clients_on_client_name", using: :btree

  create_table "app_videos", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "api_client_id"
    t.integer "tag_id"
    t.text    "url"
    t.integer "size"
    t.integer "length"
    t.integer "start_time"
    t.integer "end_time"
    t.string  "thumbnail_url"
    t.integer "version"
    t.string  "app_version"
    t.boolean "force_download"
    t.string  "download_name"
    t.string  "language",       default: "english"
  end

  create_table "apslar_attributions", force: :cascade do |t|
    t.string   "device_id"
    t.string   "campaign_source"
    t.datetime "install_time"
    t.string   "attribution"
  end

  create_table "apslar_sales", force: :cascade do |t|
    t.string "platform"
    t.string "udid"
    t.string "booking_id"
  end

  create_table "audit_entities", force: :cascade do |t|
    t.string   "name",                             null: false
    t.string   "display_name",                     null: false
    t.integer  "frequency_days",                   null: false
    t.integer  "hotel_categories",                              array: true
    t.integer  "status",           default: 0,     null: false
    t.integer  "priority",         default: 1,     null: false
    t.boolean  "night_audit",      default: false
    t.integer  "overall_score",    default: 100
    t.integer  "min_score",        default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "audit_entities", ["hotel_categories"], name: "index_audit_entities_on_hotel_categories", using: :gin
  add_index "audit_entities", ["status"], name: "index_audit_entities_on_status", using: :btree

  create_table "audit_entity_questions", force: :cascade do |t|
    t.integer  "audit_question_id",             null: false
    t.integer  "audit_entity_id",               null: false
    t.integer  "priority",          default: 1, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "audit_entity_questions", ["audit_entity_id"], name: "index_audit_entity_questions_on_audit_entity_id", using: :btree
  add_index "audit_entity_questions", ["audit_question_id", "audit_entity_id"], name: "unique_audit_entity_questions", unique: true, using: :btree
  add_index "audit_entity_questions", ["audit_question_id"], name: "index_audit_entity_questions_on_audit_question_id", using: :btree

  create_table "audit_questions", force: :cascade do |t|
    t.text     "question_text",                     null: false
    t.integer  "question_type",                     null: false
    t.integer  "question_category",                 null: false
    t.integer  "status",            default: 0,     null: false
    t.boolean  "optional",          default: false
    t.integer  "hotel_categories",                               array: true
    t.string   "positive_answers",                               array: true
    t.string   "negative_answers",                               array: true
    t.string   "other_answers",                                  array: true
    t.integer  "weight",            default: 1,     null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "audit_questions", ["hotel_categories"], name: "index_audit_questions_on_hotel_categories", using: :gin
  add_index "audit_questions", ["status"], name: "index_audit_questions_on_status", using: :btree

  create_table "audit_survey_responses", force: :cascade do |t|
    t.integer  "audit_survey_id",                null: false
    t.integer  "audit_question_id",              null: false
    t.integer  "room_id"
    t.string   "answer",                         null: false
    t.text     "image_url",         default: [],              array: true
    t.text     "comment"
    t.integer  "weight",                         null: false
    t.float    "point_score",                    null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "audit_survey_responses", ["audit_question_id"], name: "index_audit_survey_responses_on_audit_question_id", using: :btree
  add_index "audit_survey_responses", ["audit_survey_id"], name: "index_audit_survey_responses_on_audit_survey_id", using: :btree
  add_index "audit_survey_responses", ["room_id"], name: "index_audit_survey_responses_on_room_id", using: :btree

  create_table "audit_surveys", force: :cascade do |t|
    t.integer  "hotel_id",                                   null: false
    t.integer  "audit_entity_id",                            null: false
    t.integer  "submitted_by_id",                            null: false
    t.string   "ext_ref_no",                                 null: false
    t.text     "comment"
    t.datetime "started_at",                                 null: false
    t.string   "start_location"
    t.string   "end_location"
    t.boolean  "audited_within_hotel_range", default: false
    t.integer  "min_score",                                  null: false
    t.integer  "score",                                      null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "audit_surveys", ["audit_entity_id"], name: "index_audit_surveys_on_audit_entity_id", using: :btree
  add_index "audit_surveys", ["created_at"], name: "index_audit_surveys_on_created_at", using: :btree
  add_index "audit_surveys", ["ext_ref_no"], name: "index_audit_surveys_on_ext_ref_no", unique: true, using: :btree
  add_index "audit_surveys", ["hotel_id"], name: "index_audit_surveys_on_hotel_id", using: :btree
  add_index "audit_surveys", ["started_at"], name: "index_audit_surveys_on_started_at", using: :btree

  create_table "audits", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "user_id"
    t.string   "audit_no",                   limit: 255
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.string   "start_location"
    t.string   "end_location"
    t.boolean  "audited_within_hotel_range",             default: false
    t.string   "ext_ref_no"
  end

  add_index "audits", ["hotel_id"], name: "index_audits_on_hotel_id", using: :btree
  add_index "audits", ["user_id"], name: "index_audits_on_user_id", using: :btree

  create_table "bills", force: :cascade do |t|
    t.integer  "booking_id",                    null: false
    t.integer  "amount",            default: 0
    t.integer  "bill_type"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",            default: 0
    t.integer  "modified_by_id"
    t.string   "reason"
    t.integer  "applicable_amount"
    t.datetime "settlement_time"
    t.json     "tax_details"
  end

  add_index "bills", ["booking_id"], name: "index_bills_on_booking_id", using: :btree
  add_index "bills", ["settlement_time"], name: "index_bills_on_settlement_time", using: :btree

  create_table "booking_availability_logs", force: :cascade do |t|
    t.integer  "item_id",           null: false
    t.string   "item_type",         null: false
    t.string   "action_type",       null: false
    t.json     "availability_info"
    t.datetime "created_at"
  end

  add_index "booking_availability_logs", ["item_id", "item_type"], name: "index_booking_availability_logs_on_item_id_and_item_type", using: :btree

  create_table "booking_details", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "room_id"
    t.date     "from_date"
    t.date     "to_date"
    t.integer  "number_of_person"
    t.integer  "count"
    t.integer  "per_day_tariff"
    t.integer  "total_tariff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "booking_enquiries", force: :cascade do |t|
    t.integer  "guest_id"
    t.integer  "hotel_id"
    t.integer  "city_id"
    t.integer  "cluster_id"
    t.integer  "created_by_agent_id"
    t.date     "checkin"
    t.date     "checkout"
    t.text     "notes"
    t.integer  "price_range_min"
    t.integer  "price_range_max"
    t.datetime "expected_checkin_time"
    t.json     "guest_rooms"
    t.string   "location"
    t.integer  "disposition_reason"
    t.datetime "callback_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "booking_enquiries", ["checkin"], name: "index_booking_enquiries_on_checkin", using: :btree
  add_index "booking_enquiries", ["checkout"], name: "index_booking_enquiries_on_checkout", using: :btree
  add_index "booking_enquiries", ["city_id"], name: "index_booking_enquiries_on_city_id", using: :btree
  add_index "booking_enquiries", ["cluster_id"], name: "index_booking_enquiries_on_cluster_id", using: :btree
  add_index "booking_enquiries", ["created_by_agent_id"], name: "index_booking_enquiries_on_created_by_agent_id", using: :btree
  add_index "booking_enquiries", ["guest_id"], name: "index_booking_enquiries_on_guest_id", using: :btree
  add_index "booking_enquiries", ["hotel_id"], name: "index_booking_enquiries_on_hotel_id", using: :btree

  create_table "booking_guests", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "guest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guest_alias"
    t.integer  "notify_update_flag", default: 4
  end

  add_index "booking_guests", ["booking_id"], name: "index_booking_guests_on_booking_id", using: :btree
  add_index "booking_guests", ["guest_id"], name: "index_booking_guests_on_guest_id", using: :btree

  create_table "booking_legs", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "leg_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "booking_legs", ["booking_id"], name: "index_booking_legs_on_booking_id", using: :btree
  add_index "booking_legs", ["leg_id", "booking_id"], name: "index_booking_legs_on_leg_id_and_booking_id", unique: true, using: :btree

  create_table "booking_rooms", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "room_id"
    t.integer  "no_of_person"
    t.integer  "tariff"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "extra_cost"
    t.integer  "base_tariff"
    t.json     "datewise_base_pricing",     default: {}, null: false
    t.json     "datewise_surge_pricing",    default: {}, null: false
    t.json     "datewise_supplier_pricing", default: {}, null: false
    t.integer  "surge_tariff"
  end

  add_index "booking_rooms", ["booking_id"], name: "index_booking_rooms_on_booking_id", using: :btree
  add_index "booking_rooms", ["room_id"], name: "index_booking_rooms_on_room_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "guest_id"
    t.integer  "booked_by_id"
    t.integer  "hotel_id"
    t.integer  "ota_id"
    t.integer  "company_id"
    t.integer  "travel_agent_id"
    t.date     "checkin"
    t.date     "checkout"
    t.date     "payment_date"
    t.integer  "discount"
    t.integer  "amount"
    t.integer  "amount_paid"
    t.string   "payment_reference_id",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.text     "payments"
    t.integer  "payment_type"
    t.integer  "payment_status",                         default: 0
    t.integer  "source"
    t.text     "modified_by_id"
    t.text     "notes"
    t.string   "zoho_lead_id",               limit: 255
    t.string   "invoice_no",                 limit: 255
    t.string   "ota_booking_id",             limit: 255
    t.text     "extra_cost_json"
    t.text     "guest_requests"
    t.boolean  "extended"
    t.string   "coupon_code",                limit: 35
    t.integer  "owner_amount"
    t.boolean  "after_booking",                          default: false
    t.integer  "after_booking_status"
    t.datetime "expected_checkin_time"
    t.integer  "oyo_rooms",                              default: 0
    t.integer  "owner_rooms",                            default: 0
    t.string   "booked_hotel_name",          limit: 255
    t.string   "masked_number"
    t.integer  "sales_agent_id"
    t.datetime "checkin_time"
    t.datetime "checkout_time"
    t.datetime "cancellation_time"
    t.string   "tickets",                                default: [],                 array: true
    t.integer  "notify_flag",                            default: 4
    t.integer  "discount_prepaid",                       default: 0
    t.integer  "auto_upgrade",                           default: 0,     null: false
    t.boolean  "sap_invoice_created"
    t.integer  "minimum_prepay_amount"
    t.integer  "selling_amount"
    t.integer  "vendor_payment_type"
    t.integer  "affiliate_id"
    t.string   "external_reference_id"
    t.boolean  "force_prepaid",                          default: false
    t.integer  "cancellation_reason"
    t.integer  "agent_commission",                       default: 0
    t.integer  "agent_discount",                         default: 0
    t.integer  "oyo_rack_rate"
    t.integer  "micro_market_id"
    t.boolean  "sap_sync"
    t.json     "negotiated_orr_details"
    t.integer  "source_subtype"
    t.integer  "key_source"
    t.integer  "no_show_reason"
    t.boolean  "alcott_sap_invoice_created"
    t.integer  "selling_amount_per_month"
    t.integer  "long_stay_notice_period"
    t.integer  "long_stay_lockin_period"
    t.datetime "no_show_time"
  end

  add_index "bookings", ["auto_upgrade"], name: "index_bookings_on_auto_upgrade", using: :btree
  add_index "bookings", ["booked_by_id"], name: "index_bookings_on_booked_by_id", using: :btree
  add_index "bookings", ["checkin"], name: "index_bookings_on_checkin", using: :btree
  add_index "bookings", ["checkout", "checkin", "hotel_id"], name: "index_bookings_on_checkout_checkin_hotel_id", using: :btree
  add_index "bookings", ["checkout"], name: "index_bookings_on_checkout", using: :btree
  add_index "bookings", ["company_id"], name: "index_bookings_on_company_id", using: :btree
  add_index "bookings", ["coupon_code"], name: "index_bookings_on_coupon_code", using: :btree
  add_index "bookings", ["created_at"], name: "index_bookings_on_created_at", using: :btree
  add_index "bookings", ["external_reference_id"], name: "index_bookings_on_external_reference_id", using: :btree
  add_index "bookings", ["guest_id"], name: "index_bookings_on_guest_id", using: :btree
  add_index "bookings", ["hotel_id"], name: "index_bookings_on_hotel_id", using: :btree
  add_index "bookings", ["invoice_no"], name: "index_bookings_on_invoice_no", using: :btree
  add_index "bookings", ["micro_market_id"], name: "index_bookings_on_micro_market_id", using: :btree
  add_index "bookings", ["ota_booking_id"], name: "index_bookings_on_ota_booking_id", using: :btree
  add_index "bookings", ["ota_id"], name: "index_bookings_on_ota_id", using: :btree
  add_index "bookings", ["source", "key_source"], name: "index_bookings_on_source_and_key_source", using: :btree
  add_index "bookings", ["status"], name: "index_bookings_on_status", using: :btree
  add_index "bookings", ["travel_agent_id"], name: "index_bookings_on_travel_agent_id", using: :btree

  create_table "calendar", id: false, force: :cascade do |t|
    t.date     "date"
    t.float    "year"
    t.float    "month"
    t.text     "monthname"
    t.float    "day"
    t.float    "dayofyear"
    t.text     "weekdayname"
    t.float    "calendarweek"
    t.text     "formatteddate"
    t.text     "quartal"
    t.text     "yearquartal"
    t.text     "yearmonth"
    t.text     "yearcalendarweek"
    t.text     "weekend"
    t.text     "period"
    t.date     "cwstart"
    t.date     "cwend"
    t.date     "monthstart"
    t.datetime "monthend"
  end

  create_table "calls", force: :cascade do |t|
    t.integer  "staff_id"
    t.string   "phone",      limit: 255
    t.string   "centrix_id", limit: 255
    t.string   "status",     limit: 255
    t.string   "bound",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "keywords",         limit: 255
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.text     "city_data"
    t.float    "tax"
    t.string   "title",            limit: 255
    t.string   "description",      limit: 255
    t.string   "code",             limit: 255
    t.integer  "city_manager_id"
    t.json     "popular_location"
    t.text     "meta_description"
    t.integer  "hub_id"
    t.integer  "city_type"
    t.string   "time_zone"
    t.string   "image_name"
    t.integer  "state_id"
    t.integer  "country_id",                   default: 1
    t.text     "boundary"
    t.point    "centre"
    t.json     "osm_data"
    t.json     "metadata"
    t.string   "boundarya"
  end

  add_index "cities", ["hub_id"], name: "index_cities_on_hub_id", using: :btree
  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "cluster_peak_coefficients", force: :cascade do |t|
    t.integer  "cluster_id"
    t.integer  "brn_index"
    t.string   "coefficient_name"
    t.float    "coefficient_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cluster_peak_coefficients", ["cluster_id"], name: "index_cluster_peak_coefficients_on_cluster_id", using: :btree

  create_table "cluster_predicted_urns", force: :cascade do |t|
    t.integer  "cluster_id"
    t.date     "date"
    t.integer  "predicted_urns"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cluster_predicted_urns", ["cluster_id"], name: "index_cluster_predicted_urns_on_cluster_id", using: :btree
  add_index "cluster_predicted_urns", ["predicted_urns"], name: "index_cluster_predicted_urns_on_predicted_urns", using: :btree

  create_table "clusters", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "keywords",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority",                       default: 10
    t.integer  "city_id"
    t.integer  "status"
    t.integer  "micro_market_id"
    t.integer  "category",                       default: 0,  null: false
    t.decimal  "crs_masking_factor"
  end

  add_index "clusters", ["city_id"], name: "index_clusters_on_city_id", using: :btree
  add_index "clusters", ["micro_market_id"], name: "index_clusters_on_micro_market_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "company_ref_code", limit: 255
    t.string   "name",             limit: 255
    t.integer  "discount"
    t.integer  "sales_agent_id"
    t.string   "billing_name",     limit: 255
    t.string   "billing_address",  limit: 255
    t.string   "contract",         limit: 255
    t.integer  "credit_limit"
    t.binary   "allowed_credit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "admin_name",       limit: 255
    t.string   "admin_email",      limit: 255
    t.string   "admin_phone",      limit: 255
    t.integer  "category"
    t.string   "state",            limit: 255
    t.string   "city",             limit: 255
    t.string   "region",           limit: 255
    t.string   "payment_term",     limit: 255
    t.integer  "payment_mode"
    t.string   "fax",              limit: 255
    t.string   "telephone",        limit: 255
    t.integer  "status",                       default: 0
    t.string   "pin_code"
    t.string   "pan_image_name"
  end

  add_index "companies", ["company_ref_code"], name: "index_companies_on_company_ref_code", using: :btree
  add_index "companies", ["sales_agent_id", "status"], name: "index_companies_on_sales_agent_id_and_status", using: :btree

  create_table "company_wallet_details", force: :cascade do |t|
    t.integer  "wallet_id",                     null: false
    t.integer  "lower_limit_1",                 null: false
    t.datetime "last_lower_limit_1_alert_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_wallet_details", ["wallet_id"], name: "index_company_wallet_details_on_wallet_id", using: :btree

  create_table "constances", force: :cascade do |t|
    t.string   "config_key"
    t.string   "config_value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "constances", ["config_key"], name: "index_constances_on_config_key", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.float    "rs_owner"
    t.float    "rs_source_owner"
    t.integer  "min_tariff"
    t.integer  "min_tariff_if_double"
    t.integer  "min_tariff_if_triple"
    t.integer  "excess"
    t.boolean  "min_guarantee_with_liability", default: false
    t.boolean  "deduct_ota",                   default: false
    t.float    "exclude_tax"
    t.integer  "min_guarantee"
    t.float    "min_guarantee_sharing"
    t.integer  "rooms"
    t.boolean  "active",                       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "luxury_tax"
    t.integer  "amount_liable"
    t.float    "early_checkin_host_share",     default: 0.7
    t.float    "late_checkout_host_share",     default: 0.4
  end

  create_table "countries", force: :cascade do |t|
    t.string  "name"
    t.string  "phone_code"
    t.integer "status",        default: 0
    t.string  "isotwocode"
    t.string  "customer_care"
    t.string  "iso_a2_code"
  end

  create_table "country_currencies", force: :cascade do |t|
    t.integer "country_id"
    t.integer "currency_id"
  end

  create_table "coupon_groups", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "max_usage"
    t.integer  "max_usage_hotel"
    t.integer  "max_usage_user"
    t.boolean  "status"
    t.integer  "created_by_id"
    t.integer  "user_filter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code",                         limit: 255,                                              null: false
    t.string   "name",                         limit: 255
    t.text     "description"
    t.integer  "category"
    t.decimal  "value",                                    precision: 12, scale: 3
    t.integer  "max_value",                    limit: 8
    t.integer  "qualifying_amount",            limit: 8
    t.integer  "created_by_id"
    t.integer  "requested_by_id"
    t.text     "restrict_to_users",                                                 default: [],                     array: true
    t.text     "restrict_to_hotels",                                                default: [],                     array: true
    t.datetime "start_date"
    t.datetime "expiry_date"
    t.integer  "max_usage",                    limit: 8
    t.integer  "max_usage_per_user",           limit: 8
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "allowed_channel"
    t.string   "allowed_campaign",             limit: 255
    t.datetime "checkin_start_date"
    t.datetime "checkin_end_date"
    t.integer  "min_rooms"
    t.integer  "max_rooms"
    t.integer  "min_nights"
    t.integer  "max_nights"
    t.integer  "min_room_nights"
    t.integer  "max_room_nights"
    t.integer  "min_advance_period"
    t.integer  "max_advance_period"
    t.integer  "coupon_group_id"
    t.text     "restrict_to_cities",                                                default: [],                     array: true
    t.integer  "type",                                                              default: 0
    t.integer  "allowed_gateway"
    t.text     "allowed_sources",                                                   default: [],                     array: true
    t.decimal  "max_value_prepaid",                                                 default: 0.0
    t.integer  "value_prepaid",                                                     default: 0
    t.boolean  "is_prepaid",                                                        default: false
    t.text     "description_prepaid"
    t.integer  "min_room_night_tarriff"
    t.boolean  "valid_only_for_prepaid"
    t.string   "ta_emails"
    t.string   "salt"
    t.text     "restrict_to_booking_creators",                                      default: [],                     array: true
    t.decimal  "value_for_app",                            precision: 12, scale: 3
    t.datetime "blackout_dates",                                                    default: [],                     array: true
    t.json     "pg_json"
    t.text     "restrict_to_countries",                                             default: [],                     array: true
    t.text     "testingarray",                                                      default: ["1"],                  array: true
    t.integer  "currency_id"
    t.text     "arraytesta",                                                        default: ["India"],              array: true
    t.integer  "extra_cb_max_value"
    t.integer  "extra_cb_value"
    t.text     "flat_values",                                                       default: [],                     array: true
    t.text     "flat_max_values",                                                   default: [],                     array: true
    t.json     "meta",                                                              default: {}
    t.json     "allowed_channel_with_source",                                       default: {}
  end

  add_index "coupons", ["code", "status"], name: "unique_coupon_code_index", unique: true, where: "(status = true)", using: :btree
  add_index "coupons", ["coupon_group_id"], name: "index_coupons_on_coupon_group_id", using: :btree
  add_index "coupons", ["created_by_id"], name: "index_coupons_on_created_by_id", using: :btree
  add_index "coupons", ["requested_by_id"], name: "index_coupons_on_requested_by_id", using: :btree
  add_index "coupons", ["salt"], name: "index_coupons_on_salt", using: :btree

  create_table "crs_enums", force: :cascade do |t|
    t.string  "table_name",  null: false
    t.string  "column_name", null: false
    t.integer "enum_key",    null: false
    t.string  "enum_val",    null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "currency_code"
    t.string "symbol"
  end

  create_table "cx_feedbacks", force: :cascade do |t|
    t.integer  "agent_id",                                              null: false
    t.integer  "booking_id",                                            null: false
    t.integer  "gender"
    t.integer  "dob_day_of_month"
    t.integer  "dob_month"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guest_name"
    t.string   "guest_email"
    t.string   "guest_phone"
    t.decimal  "latitude",                     precision: 10, scale: 7
    t.decimal  "longitude",                    precision: 10, scale: 7
    t.string   "address",          limit: 500
  end

  add_index "cx_feedbacks", ["agent_id"], name: "index_cx_feedbacks_on_agent_id", using: :btree
  add_index "cx_feedbacks", ["booking_id"], name: "index_cx_feedbacks_on_booking_id", using: :btree

  create_table "cx_question_response_options", force: :cascade do |t|
    t.integer  "cx_question_id", null: false
    t.string   "text",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cx_question_response_options", ["cx_question_id"], name: "index_cx_question_response_options_on_cx_question_id", using: :btree

  create_table "cx_question_responses", force: :cascade do |t|
    t.integer  "cx_feedback_id",                 null: false
    t.integer  "cx_question_id",                 null: false
    t.integer  "cx_question_response_option_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cx_question_responses", ["cx_feedback_id"], name: "index_cx_question_responses_on_cx_feedback_id", using: :btree
  add_index "cx_question_responses", ["cx_question_id"], name: "index_cx_question_responses_on_cx_question_id", using: :btree
  add_index "cx_question_responses", ["cx_question_response_option_id"], name: "index_cx_question_responses_on_cx_question_response_option_id", using: :btree

  create_table "cx_questions", force: :cascade do |t|
    t.integer  "question_type", null: false
    t.string   "text",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["locked_by"], name: "idx_tmp_rhl_locked_by_dj", using: :btree
  add_index "delayed_jobs", ["priority", "run_at", "failed_at", "queue"], name: "index_delayed_job", using: :btree
  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["queue"], name: "index_delayed_jobs_on_queue", using: :btree

  create_table "device_identifiers", force: :cascade do |t|
    t.string   "device_id"
    t.string   "device_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "device_identifiers", ["device_id"], name: "index_device_identifiers_on_device_id", using: :btree

  create_table "device_tokens", force: :cascade do |t|
    t.integer  "user_profile_id"
    t.integer  "device_type"
    t.string   "token",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "device_tokens", ["device_type"], name: "index_device_type_on_device_tokens", using: :btree
  add_index "device_tokens", ["token"], name: "index_token_on_device_tokens", using: :btree
  add_index "device_tokens", ["user_profile_id"], name: "index_device_tokens_on_user_profile_id", using: :btree

  create_table "disputes", force: :cascade do |t|
    t.integer  "item_id",            null: false
    t.integer  "item_type",          null: false
    t.integer  "category",           null: false
    t.float    "amount"
    t.datetime "dispute_date"
    t.integer  "source_type",        null: false
    t.integer  "status"
    t.string   "notes",              null: false
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sap_sync"
  end

  add_index "disputes", ["category"], name: "index_disputes_on_category", using: :btree
  add_index "disputes", ["dispute_date"], name: "index_disputes_on_dispute_date", using: :btree
  add_index "disputes", ["item_id"], name: "index_disputes_on_item_id", using: :btree
  add_index "disputes", ["item_type"], name: "index_disputes_on_item_type", using: :btree
  add_index "disputes", ["source_type"], name: "index_disputes_on_source_type", using: :btree
  add_index "disputes", ["status"], name: "index_disputes_on_status", using: :btree

  create_table "employee_upload_logs", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.json     "file_information"
    t.integer  "status",           default: 0
    t.integer  "total_count"
    t.integer  "failed_count"
    t.integer  "company_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.integer  "city",              default: [],              array: true
    t.integer  "cluster",           default: [],              array: true
    t.integer  "team_id"
    t.integer  "role_id"
    t.integer  "hotel_id"
    t.integer  "user_id",                        null: false
    t.integer  "access_profile_id"
    t.string   "email",                          null: false
    t.string   "phone"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "micro_market_id"
    t.integer  "permission_set",    default: [],              array: true
  end

  add_index "employees", ["email"], name: "index_employees_on_email", using: :btree
  add_index "employees", ["hotel_id"], name: "index_employees_on_hotel_id", using: :btree
  add_index "employees", ["permission_set"], name: "index_employees_on_permission_set", using: :gin
  add_index "employees", ["user_id"], name: "index_employees_on_user_id", using: :btree

  create_table "enquiries", force: :cascade do |t|
    t.integer  "guest_id"
    t.integer  "staff_id"
    t.text     "request"
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
    t.integer  "status"
    t.json     "meta_data"
    t.integer  "booking_id"
    t.integer  "city_id"
    t.integer  "lead_type"
    t.datetime "followup_at"
    t.string   "modified_by_id",      limit: 255
    t.string   "source",              limit: 255
    t.datetime "first_modified_time"
    t.string   "lead_id"
  end

  add_index "enquiries", ["booking_id"], name: "index_enquiries_on_booking_id", using: :btree
  add_index "enquiries", ["category", "status"], name: "enquiries_on_category_status", using: :btree
  add_index "enquiries", ["city_id"], name: "index_enquiries_on_city_id", using: :btree
  add_index "enquiries", ["created_at"], name: "index_enquiries_on_created_at", using: :btree
  add_index "enquiries", ["guest_id"], name: "index_enquiries_on_guest_id", using: :btree
  add_index "enquiries", ["source", "lead_id"], name: "uniqueness_index", unique: true, using: :btree
  add_index "enquiries", ["staff_id"], name: "index_enquiries_on_staff_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "booking_id"
    t.integer  "location"
    t.integer  "costumer_support"
    t.integer  "service_quality"
    t.integer  "hotel_staff"
    t.integer  "cleanliness"
    t.text     "comment"
    t.integer  "check_in_call_status"
    t.integer  "feedback_call_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "food_quality"
    t.integer  "overall_experience"
    t.integer  "suggest_oyo"
    t.string   "phone",                limit: 255
    t.integer  "value_for_money"
    t.integer  "source"
    t.integer  "issues",                           default: [],    array: true
    t.integer  "hotel_id"
    t.string   "user_name"
    t.boolean  "new",                              default: false
  end

  add_index "feedbacks", ["booking_id"], name: "index_feedbacks_on_booking_id", using: :btree
  add_index "feedbacks", ["created_at"], name: "index_feedbacks_on_created_at", using: :btree
  add_index "feedbacks", ["source", "suggest_oyo"], name: "index_feedbacks_on_source_and_suggest_oyo", using: :btree

  create_table "flagship_expenses", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.float    "amount"
    t.datetime "expense_date"
    t.integer  "expense_type",                               null: false
    t.integer  "category",                                   null: false
    t.integer  "flagship_owner_agreement_id",                null: false
    t.boolean  "active",                      default: true
  end

  add_index "flagship_expenses", ["category"], name: "index_flagship_expenses_on_category", using: :btree
  add_index "flagship_expenses", ["expense_date"], name: "index_flagship_expenses_on_expense_date", using: :btree
  add_index "flagship_expenses", ["expense_type"], name: "index_flagship_expenses_on_expense_type", using: :btree
  add_index "flagship_expenses", ["flagship_owner_agreement_id"], name: "index_flagship_expenses_on_flagship_owner_agreement_id", using: :btree

  create_table "flagship_meta", force: :cascade do |t|
    t.integer  "hotel_id",                             null: false
    t.string   "bazaar_url"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "delhivery_collection", default: false
  end

  add_index "flagship_meta", ["hotel_id"], name: "index_flagship_meta_on_hotel_id", unique: true, using: :btree

  create_table "flagship_owner_agreements", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "hotel_id",                         null: false
    t.float    "monthly_lease"
    t.float    "rs"
    t.date     "valid_from"
    t.date     "valid_till"
    t.float    "increment_percent", default: 0.0
    t.integer  "increment_cycle"
    t.float    "service_tax_rate",  default: 0.0
    t.boolean  "active",            default: true
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "signed_by_id"
  end

  add_index "flagship_owner_agreements", ["hotel_id"], name: "index_flagship_owner_agreements_on_hotel_id", using: :btree
  add_index "flagship_owner_agreements", ["valid_from"], name: "index_flagship_owner_agreements_on_valid_from", using: :btree
  add_index "flagship_owner_agreements", ["valid_till"], name: "index_flagship_owner_agreements_on_valid_till", using: :btree

  create_table "flagship_reconciliations", force: :cascade do |t|
    t.integer  "hotel_id",                                null: false
    t.float    "total_owner_rs",          default: 0.0
    t.float    "total_lease_amount",      default: 0.0
    t.float    "total_addition_amount",   default: 0.0
    t.float    "total_deduction_amount",  default: 0.0
    t.integer  "month",                                   null: false
    t.integer  "year",                                    null: false
    t.integer  "reconciliation_id",                       null: false
    t.boolean  "completed",               default: false
    t.boolean  "calculating",             default: false
    t.string   "notes_additions"
    t.string   "notes_deductions"
    t.datetime "calculated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "previous_month_recovery", default: 0.0
    t.boolean  "alcott_sap_sync"
  end

  add_index "flagship_reconciliations", ["hotel_id", "month", "year"], name: "index_flagship_reconciliations_on_hotel_id_and_month_and_year", unique: true, using: :btree

  create_table "flash_sale_prices", force: :cascade do |t|
    t.integer  "hotel_id",                                          null: false
    t.integer  "flash_sale_id",                                     null: false
    t.date     "visible_from",                                      null: false
    t.date     "visible_till",                                      null: false
    t.decimal  "price_so",      precision: 8, scale: 2,             null: false
    t.date     "from",                                              null: false
    t.date     "to",                                                null: false
    t.integer  "state",                                 default: 0, null: false
    t.json     "metadata"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flash_sale_prices", ["flash_sale_id"], name: "index_flash_sale_prices_on_flash_sale_id", using: :btree
  add_index "flash_sale_prices", ["hotel_id", "from", "to", "state", "flash_sale_id"], name: "hotel_from_to_state_flash_sale_index", using: :btree
  add_index "flash_sale_prices", ["hotel_id"], name: "index_flash_sale_prices_on_hotel_id", using: :btree
  add_index "flash_sale_prices", ["state"], name: "index_flash_sale_prices_on_state", using: :btree

  create_table "flash_sales", force: :cascade do |t|
    t.string   "deal"
    t.string   "description"
    t.datetime "valid_from"
    t.datetime "valid_till"
    t.integer  "status",      default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flash_sales", ["status"], name: "index_flash_sales_on_status", using: :btree
  add_index "flash_sales", ["valid_from", "valid_till"], name: "index_flash_sales_on_valid_from_and_valid_till", using: :btree

  create_table "food_categories", force: :cascade do |t|
    t.string   "name",                              null: false
    t.time     "start_time",                        null: false
    t.time     "end_time",                          null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.time     "start_time_additional"
    t.time     "end_time_additional"
    t.integer  "meal_type",             default: 1
    t.integer  "priority",              default: 0
  end

  create_table "food_items", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.integer  "food_type",            default: 0,     null: false
    t.text     "description"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "beverage",             default: false
    t.integer  "food_vat_category_id"
  end

  add_index "food_items", ["food_type"], name: "index_food_items_on_food_type", using: :btree

  create_table "food_menu_items", force: :cascade do |t|
    t.integer  "food_item_id",                 null: false
    t.integer  "price",                        null: false
    t.integer  "status",           default: 0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "food_category_id"
    t.integer  "hotel_id"
    t.float    "vat"
    t.float    "tax_applicable"
  end

  add_index "food_menu_items", ["status"], name: "index_food_menu_items_on_status", using: :btree

  create_table "food_order_items", force: :cascade do |t|
    t.integer  "food_order_id",                     null: false
    t.integer  "food_menu_item_id",                 null: false
    t.integer  "price",                             null: false
    t.integer  "quantity",                          null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "complementary_count", default: 0
    t.float    "vat",                 default: 0.0
    t.float    "tax_applicable"
    t.integer  "food_vendor_id"
    t.integer  "food_vendor_price",   default: 0
  end

  add_index "food_order_items", ["food_menu_item_id"], name: "index_food_order_items_on_food_menu_item_id", using: :btree
  add_index "food_order_items", ["food_order_id"], name: "index_food_order_items_on_food_order_id", using: :btree
  add_index "food_order_items", ["food_vendor_id"], name: "index_food_order_items_on_food_vendor_id", using: :btree

  create_table "food_orders", force: :cascade do |t|
    t.integer  "booking_id",                          null: false
    t.string   "room_no",                             null: false
    t.string   "order_invoice_no",                    null: false
    t.integer  "status",                  default: 0, null: false
    t.integer  "meal_type",               default: 1, null: false
    t.datetime "scheduled_delivery_time",             null: false
    t.datetime "delivered_time"
    t.integer  "amount",                  default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "source",                  default: 0
    t.text     "notes"
    t.json     "tax_details"
    t.integer  "bill_id"
    t.integer  "vendor_amount",           default: 0
  end

  add_index "food_orders", ["booking_id"], name: "index_food_orders_on_booking_id", using: :btree
  add_index "food_orders", ["order_invoice_no"], name: "index_food_orders_on_order_invoice_no", using: :btree
  add_index "food_orders", ["scheduled_delivery_time"], name: "index_food_orders_on_scheduled_delivery_time", using: :btree
  add_index "food_orders", ["status"], name: "index_food_orders_on_status", using: :btree

  create_table "food_vat_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_vendor_hotels", force: :cascade do |t|
    t.integer "hotel_id"
    t.integer "food_vendor_id"
    t.integer "priority",       default: 0
  end

  create_table "food_vendor_menu_items", force: :cascade do |t|
    t.integer "food_vendor_id"
    t.integer "food_item_id"
    t.integer "price",          default: 0
  end

  create_table "food_vendors", force: :cascade do |t|
    t.string   "name"
    t.string   "owner_email"
    t.string   "owner_name"
    t.string   "phone"
    t.boolean  "external",    default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "gifts", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "vendor"
    t.integer  "gift_type"
    t.json     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
  end

  add_index "gifts", ["booking_id"], name: "index_gifts_on_booking_id", using: :btree

  create_table "grouped_hotel_ranks", force: :cascade do |t|
    t.integer  "hotel_id",                   null: false
    t.integer  "group_type",                 null: false
    t.integer  "ranking_basis",              null: false
    t.integer  "rank",                       null: false
    t.integer  "update_counter", default: 1, null: false
    t.integer  "status",         default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_count",                null: false
  end

  add_index "grouped_hotel_ranks", ["group_type", "ranking_basis", "hotel_id"], name: "index_grouped_hotel_ranks_composite", using: :btree
  add_index "grouped_hotel_ranks", ["hotel_id"], name: "index_grouped_hotel_ranks_on_hotel_id", using: :btree

  create_table "guest_data_points", force: :cascade do |t|
    t.integer "guest_id",                                   null: false
    t.integer "valid_bookings_count",       default: 0,     null: false
    t.integer "cancelled_bookings_count",   default: 0,     null: false
    t.integer "consumed_bookings_count",    default: 0,     null: false
    t.integer "past_paid_amount",           default: 0,     null: false
    t.boolean "last_booking_cancelled",     default: false, null: false
    t.integer "cancelled_on_checkin_count", default: 0
  end

  add_index "guest_data_points", ["guest_id"], name: "index_guest_data_points_on_guest_id", using: :btree

  create_table "hm_day_cash_closes", force: :cascade do |t|
    t.integer  "hotel_id",                       null: false
    t.date     "applicable_for",                 null: false
    t.integer  "applicable_amount",              null: false
    t.integer  "closed_amount",                  null: false
    t.integer  "status",             default: 1, null: false
    t.integer  "submitted_by_id",                null: false
    t.text     "comments"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "collector",          default: 0
    t.string   "collector_order_no"
    t.integer  "collection_status",  default: 0
    t.datetime "scheduled_at"
    t.datetime "collected_at"
    t.string   "order_ref_id"
  end

  add_index "hm_day_cash_closes", ["collector_order_no"], name: "index_hm_day_cash_closes_on_collector_order_no", using: :btree
  add_index "hm_day_cash_closes", ["hotel_id", "applicable_for"], name: "uniqueness_index_for_hm_day_cash_closes", unique: true, using: :btree

  create_table "homes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotel_account_details", force: :cascade do |t|
    t.integer  "hotel_id",        null: false
    t.string   "name"
    t.string   "bank_name",       null: false
    t.text     "bank_address"
    t.string   "bank_account_no", null: false
    t.integer  "account_type",    null: false
    t.string   "bank_ifsc_code"
    t.string   "bank_micr_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "service_tax_no"
    t.string   "pan_no"
    t.string   "vat_no"
    t.string   "cst_no"
  end

  add_index "hotel_account_details", ["hotel_id"], name: "index_hotel_account_details_on_hotel_id", using: :btree

  create_table "hotel_agreement_details", force: :cascade do |t|
    t.integer  "agreement_id"
    t.integer  "hotel_id"
    t.date     "valid_from",    null: false
    t.date     "valid_till",    null: false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "signed_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hotel_agreement_details", ["agreement_id"], name: "index_hotel_agreement_details_on_agreement_id", using: :btree
  add_index "hotel_agreement_details", ["created_by_id"], name: "index_hotel_agreement_details_on_created_by_id", using: :btree
  add_index "hotel_agreement_details", ["hotel_id"], name: "index_hotel_agreement_details_on_hotel_id", using: :btree

  create_table "hotel_amenities_lists", force: :cascade do |t|
    t.string   "name",         limit: 40,             null: false
    t.text     "description"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amenity_type",            default: 0
  end

  create_table "hotel_amenities_lists_hotels", force: :cascade do |t|
    t.integer  "hotel_id",                null: false
    t.integer  "hotel_amenities_list_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sub_amenity_name"
    t.string   "sub_amenity_type"
    t.text     "sub_amenity_description"
    t.integer  "sub_amenity_priority"
  end

  add_index "hotel_amenities_lists_hotels", ["hotel_amenities_list_id"], name: "index_hotel_amenities_lists_hotels_on_hotel_amenities_list_id", using: :btree
  add_index "hotel_amenities_lists_hotels", ["hotel_id"], name: "index_hotel_amenities_lists_hotels_on_hotel_id", using: :btree

  create_table "hotel_booked_room_counts", id: false, force: :cascade do |t|
    t.integer  "owner_rooms", limit: 8
    t.integer  "oyo_rooms",   limit: 8
    t.integer  "hotel_id"
    t.datetime "date"
    t.text     "room_type"
  end

  add_index "hotel_booked_room_counts", ["hotel_id", "date", "room_type"], name: "avail_mat_view_index", using: :btree

  create_table "hotel_contract_details", force: :cascade do |t|
    t.integer  "contract_id"
    t.integer  "hotel_id"
    t.date     "valid_from",    null: false
    t.date     "valid_till",    null: false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
  end

  add_index "hotel_contract_details", ["contract_id"], name: "index_hotel_contract_details_on_contract_id", using: :btree
  add_index "hotel_contract_details", ["created_by_id"], name: "index_hotel_contract_details_on_created_by_id", using: :btree
  add_index "hotel_contract_details", ["hotel_id"], name: "index_hotel_contract_details_on_hotel_id", using: :btree
  add_index "hotel_contract_details", ["updated_by_id"], name: "index_hotel_contract_details_on_updated_by_id", using: :btree

  create_table "hotel_contract_incentives", force: :cascade do |t|
    t.integer  "amount"
    t.date     "valid_from",                null: false
    t.date     "valid_till",                null: false
    t.integer  "hotel_contract_details_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotel_employees", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hotel_employees", ["employee_id"], name: "index_hotel_employees_on_employee_id", using: :btree
  add_index "hotel_employees", ["hotel_id"], name: "index_hotel_employees_on_hotel_id", using: :btree

  create_table "hotel_floor_orrs", force: :cascade do |t|
    t.date     "start_date",    null: false
    t.date     "end_date",      null: false
    t.integer  "orr",           null: false
    t.integer  "hotel_id",      null: false
    t.integer  "created_by_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "hotel_floor_orrs", ["start_date", "end_date", "hotel_id"], name: "index_hotel_floor_orrs_on_start_date_and_end_date_and_hotel_id", using: :btree

  create_table "hotel_images", force: :cascade do |t|
    t.integer  "hotel_id"
    t.string   "category",                       limit: 255
    t.string   "hotel_image",                    limit: 255
    t.string   "caption",                        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
    t.string   "dominant_color",                 limit: 12
    t.integer  "status",                                     default: 1
    t.string   "file_url"
    t.string   "file_name"
    t.integer  "image_type",                                 default: 0
    t.integer  "hotel_amenities_lists_hotel_id"
  end

  add_index "hotel_images", ["hotel_amenities_lists_hotel_id"], name: "index_hotel_images_on_hotel_amenities_lists_hotel_id", using: :btree
  add_index "hotel_images", ["hotel_id", "status"], name: "index_hotel_images_on_hotel_id_and_status", using: :btree

  create_table "hotel_localities", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "locality_id"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hotel_localities", ["hotel_id"], name: "index_hotel_localities_on_hotel_id", using: :btree
  add_index "hotel_localities", ["locality_id"], name: "index_hotel_localities_on_locality_id", using: :btree
  add_index "hotel_localities", ["priority"], name: "index_hotel_localities_on_priority", using: :btree

  create_table "hotel_management_details", force: :cascade do |t|
    t.integer  "hotel_id"
    t.string   "software_type"
    t.string   "software_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "hotel_management_details", ["hotel_id"], name: "index_hotel_management_details_on_hotel_id", using: :btree

  create_table "hotel_payments", force: :cascade do |t|
    t.integer  "hotel_id",                                null: false
    t.integer  "request_type",                            null: false
    t.integer  "status",                                  null: false
    t.integer  "amount",                                  null: false
    t.text     "notes"
    t.date     "recovery_start_date"
    t.date     "recovery_end_date"
    t.integer  "amount_settled_till_date"
    t.text     "settlement_notes"
    t.date     "settlement_date"
    t.string   "utr_no"
    t.integer  "reconciliation_id"
    t.integer  "requested_by_id"
    t.integer  "approved_by_id"
    t.integer  "released_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "advance_ids",                default: [],              array: true
    t.datetime "approval_time"
    t.integer  "advance_type"
    t.boolean  "sap_sync"
    t.datetime "initiation_time"
    t.json     "metadata"
    t.string   "uniq_id"
    t.integer  "payment_mode"
    t.integer  "flagship_reconciliation_id"
    t.integer  "individual_recipient_id"
  end

  add_index "hotel_payments", ["hotel_id"], name: "index_hotel_payments_on_hotel_id", using: :btree
  add_index "hotel_payments", ["reconciliation_id", "request_type", "status"], name: "rahul_temp_hotelpmt_reconid", using: :btree
  add_index "hotel_payments", ["uniq_id"], name: "index_hotel_payments_on_uniq_id", unique: true, using: :btree

  create_table "hotel_policies_lists", force: :cascade do |t|
    t.string   "name",        limit: 40, null: false
    t.text     "description"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotel_policies_lists_hotels", force: :cascade do |t|
    t.integer  "hotel_id",               null: false
    t.integer  "hotel_policies_list_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hotel_policies_lists_hotels", ["hotel_id"], name: "index_hotel_policies_lists_hotels_on_hotel_id", using: :btree
  add_index "hotel_policies_lists_hotels", ["hotel_policies_list_id"], name: "index_hotel_policies_lists_hotels_on_hotel_policies_list_id", using: :btree

  create_table "hotel_restrictions", force: :cascade do |t|
    t.integer  "restriction_id"
    t.integer  "hotel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "from_time"
    t.date     "to_time"
    t.json     "meta_data",      default: {}
    t.integer  "status",         default: 0
    t.integer  "staff_id"
  end

  add_index "hotel_restrictions", ["hotel_id"], name: "index_hotel_restrictions_on_hotel_id", using: :btree
  add_index "hotel_restrictions", ["restriction_id"], name: "index_hotel_restrictions_on_restriction_id", using: :btree

  create_table "hotel_room_blocks", force: :cascade do |t|
    t.date     "start_date",    null: false
    t.date     "end_date",      null: false
    t.integer  "type"
    t.integer  "action",        null: false
    t.integer  "oyo_rooms",     null: false
    t.integer  "hotel_id",      null: false
    t.integer  "created_by_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "sub_type"
  end

  add_index "hotel_room_blocks", ["created_by_id"], name: "index_hotel_room_blocks_on_created_by_id", using: :btree
  add_index "hotel_room_blocks", ["hotel_id", "start_date", "end_date"], name: "idx_hotel_room_blocks_on_hotel_id_start_date_end_date", using: :btree
  add_index "hotel_room_blocks", ["type", "sub_type"], name: "index_hotel_room_blocks_on_type_and_sub_type", using: :btree

  create_table "hotel_room_details", force: :cascade do |t|
    t.integer  "hotel_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "oyo_rooms"
    t.boolean  "is_default", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     default: 1
  end

  add_index "hotel_room_details", ["hotel_id", "start_date", "end_date"], name: "unique_hrd_index", unique: true, where: "(status = 1)", using: :btree
  add_index "hotel_room_details", ["hotel_id"], name: "index_hotel_room_details_on_hotel_id", using: :btree

  create_table "hotel_room_types", force: :cascade do |t|
    t.integer   "hotel_id"
    t.integer   "room_type_id"
    t.integer   "room_pricing_id"
    t.date      "dynamic_price_from"
    t.date      "dynamic_price_to"
    t.integer   "created_by_id"
    t.string    "reason",                 limit: 255
    t.boolean   "is_default"
    t.integer   "modified_by_id"
    t.datetime  "created_at"
    t.datetime  "updated_at"
    t.integer   "status",                             default: 1
    t.boolean   "auto_calculated",                    default: false
    t.daterange "date_range"
    t.json      "price_metadata"
    t.integer   "avg_price_without_disc"
  end

  add_index "hotel_room_types", ["date_range", "hotel_id"], name: "hotel_room_types_date_range_hotel_id_excl", where: "(((status = 1) AND (dynamic_price_to > '2016-05-25'::date)) AND (is_default = false))", using: :gist
  add_index "hotel_room_types", ["dynamic_price_from", "dynamic_price_to"], name: "room_type_price_index", using: :btree
  add_index "hotel_room_types", ["hotel_id", "room_type_id", "is_default", "status", "dynamic_price_to", "dynamic_price_from"], name: "hotel_room_type_dpf_dpt_status_hotel", where: "(status = 1)", using: :btree
  add_index "hotel_room_types", ["hotel_id", "room_type_id"], name: "index_hotel_room_types_on_hotel_id_and_room_type_id", using: :btree
  add_index "hotel_room_types", ["is_default", "room_type_id"], name: "hotel_room_type_is_default_room_type", using: :btree
  add_index "hotel_room_types", ["room_pricing_id"], name: "index_hotel_room_types_on_room_pricing_id", using: :btree
  add_index "hotel_room_types", ["status", "room_type_id", "dynamic_price_from", "dynamic_price_to"], name: "tmp_hrt_idx", using: :btree
  add_index "hotel_room_types", ["status"], name: "index_hotel_room_types_on_status", using: :btree

  create_table "hotel_services", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "service_type"
    t.integer  "created_by_id"
    t.integer  "modified_by_id"
    t.string   "service_id"
    t.date     "activation_date"
    t.date     "end_date"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotel_staffs", force: :cascade do |t|
    t.integer  "hotel_id",               null: false
    t.string   "name",                   null: false
    t.string   "phone"
    t.integer  "role"
    t.integer  "status",     default: 1, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "hotel_staffs", ["hotel_id"], name: "index_hotel_staffs_on_hotel_id", using: :btree
  add_index "hotel_staffs", ["status"], name: "index_hotel_staffs_on_status", using: :btree

  create_table "hotel_surge_costs", force: :cascade do |t|
    t.integer  "hotel_id",                                               null: false
    t.date     "date",                                                   null: false
    t.datetime "applicable_from",                                        null: false
    t.datetime "applicable_till"
    t.decimal  "price_so",         precision: 8, scale: 2,               null: false
    t.decimal  "price_do",         precision: 8, scale: 2,               null: false
    t.decimal  "price_to",         precision: 8, scale: 2
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "surged_by",                                default: 0
    t.float    "surge_factor",                             default: 1.0
    t.boolean  "is_oyo_surge"
    t.integer  "created_by_id"
    t.decimal  "calc_so",          precision: 8, scale: 2,               null: false
    t.decimal  "calc_do",          precision: 8, scale: 2,               null: false
    t.decimal  "calc_to",          precision: 8, scale: 2,               null: false
    t.decimal  "prev_so",          precision: 8, scale: 2
    t.decimal  "prev_do",          precision: 8, scale: 2
    t.decimal  "prev_to",          precision: 8, scale: 2
    t.integer  "analytics_factor"
    t.json     "metadata"
  end

  add_index "hotel_surge_costs", ["created_at"], name: "index_hotel_surge_costs_on_created_at", using: :btree
  add_index "hotel_surge_costs", ["hotel_id", "date", "applicable_till"], name: "index_on_surge_cost", using: :btree

  create_table "hotel_take_rates", force: :cascade do |t|
    t.integer  "hotel_id",                           null: false
    t.date     "date",                               null: false
    t.decimal  "take_rate",  precision: 8, scale: 2, null: false
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "expired_at"
  end

  add_index "hotel_take_rates", ["hotel_id", "date"], name: "index_hotel_take_rates_on_hotel_id_and_date", using: :btree

  create_table "hotel_user_profiles", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "user_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",            default: 0
  end

  add_index "hotel_user_profiles", ["hotel_id"], name: "index_hotel_user_profiles_on_hotel_id", using: :btree
  add_index "hotel_user_profiles", ["user_profile_id"], name: "index_hotel_user_profiles_on_user_profile_id", using: :btree

  create_table "hotel_wifi_credentials", force: :cascade do |t|
    t.integer  "hotel_id"
    t.string   "ssid"
    t.string   "password"
    t.boolean  "active",        default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "security_type"
  end

  add_index "hotel_wifi_credentials", ["hotel_id"], name: "index_hotel_wifi_credentials_on_hotel_id", using: :btree

  create_table "hotels", force: :cascade do |t|
    t.string   "name",                         limit: 100
    t.string   "alternate_name",               limit: 100
    t.string   "oyo_id",                       limit: 20,                                  null: false
    t.text     "summary"
    t.text     "description"
    t.text     "location_description"
    t.string   "keywords",                     limit: 255
    t.integer  "priority",                     limit: 8
    t.string   "clientele",                    limit: 100
    t.string   "map_link",                     limit: 100
    t.integer  "rating"
    t.string   "website",                      limit: 100
    t.text     "meta_description"
    t.string   "email",                        limit: 255
    t.string   "phone",                        limit: 255
    t.string   "landmark",                     limit: 255
    t.text     "directions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                                   default: 1
    t.integer  "category",                                 default: 1
    t.integer  "cluster_id"
    t.string   "plot_number",                  limit: 255
    t.string   "street",                       limit: 255
    t.string   "city",                         limit: 255
    t.string   "state",                        limit: 255
    t.string   "country",                      limit: 255
    t.string   "pincode",                      limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.binary   "new_oyo"
    t.binary   "featured"
    t.integer  "transformed_by_id"
    t.integer  "mintariff"
    t.boolean  "send_manager_details",                     default: false
    t.string   "primary_contact",              limit: 255
    t.string   "trip_advisor_url",             limit: 255
    t.integer  "operation_manager_id"
    t.integer  "hostess_manager_id"
    t.integer  "training_manager_id"
    t.integer  "board_type"
    t.integer  "hoarding"
    t.integer  "over_sellable_rooms",                      default: 0
    t.string   "landline",                     limit: 20
    t.string   "manager_name",                 limit: 255
    t.integer  "lead_type"
    t.datetime "activation_date"
    t.string   "oyo_email",                    limit: 255
    t.integer  "tablet_status"
    t.integer  "created_by"
    t.boolean  "only_prepaid",                             default: false
    t.integer  "bd_manager_id"
    t.integer  "discount",                                 default: 0,                     null: false
    t.integer  "mini_cluster_id"
    t.string   "short_description"
    t.boolean  "ota_listed",                               default: false
    t.string   "holiday_iq_url"
    t.integer  "hotel_type"
    t.time     "checkin_time"
    t.time     "checkout_time"
    t.json     "status_track",                             default: [],                                 array: true
    t.integer  "total_rooms",                              default: 0
    t.string   "ta_emails"
    t.string   "billing_entity"
    t.string   "hotel_logo"
    t.integer  "country_id"
    t.integer  "currency_id"
    t.json     "nearby_json"
    t.date     "training_date"
    t.time     "calling_active_time",                      default: '2000-01-01 12:30:00'
    t.integer  "city_id"
    t.json     "desired_pricing_split"
    t.integer  "migrated_from_hotel_id"
    t.string   "flagship_transition_category"
    t.string   "prev_oyo_id"
    t.string   "boundary"
    t.boolean  "wifi_autoconnect"
    t.integer  "wifi_device_type"
  end

  add_index "hotels", ["category"], name: "index_hotels_on_category", using: :btree
  add_index "hotels", ["cluster_id"], name: "index_hotels_on_cluster_id", using: :btree
  add_index "hotels", ["hotel_type"], name: "index_hotels_on_hotel_type", using: :btree
  add_index "hotels", ["oyo_id"], name: "index_hotels_on_oyo_id", unique: true, using: :btree
  add_index "hotels", ["pincode"], name: "index_hotels_on_pincode", using: :btree
  add_index "hotels", ["prev_oyo_id"], name: "index_hotels_on_prev_oyo_id", using: :btree
  add_index "hotels", ["status", "latitude", "longitude"], name: "index_hotels_on_status_and_latitude_and_longitude", using: :btree
  add_index "hotels", ["status", "priority"], name: "index_hotels_on_status_and_priority", using: :btree

  create_table "house_keeping_audits", force: :cascade do |t|
    t.integer  "hotel_id",                        null: false
    t.integer  "room_id",                         null: false
    t.datetime "started_at",                      null: false
    t.datetime "finished_at",                     null: false
    t.integer  "creator_id",                      null: false
    t.integer  "negative_resp_count", default: 0
    t.json     "response"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "house_keeping_audits", ["hotel_id"], name: "index_house_keeping_audits_on_hotel_id", using: :btree
  add_index "house_keeping_audits", ["negative_resp_count"], name: "index_house_keeping_audits_on_negative_resp_count", using: :btree
  add_index "house_keeping_audits", ["room_id"], name: "index_house_keeping_audits_on_room_id", using: :btree

  create_table "hubs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "zone_id"
    t.integer  "hub_head_id"
  end

  add_index "hubs", ["zone_id"], name: "index_hubs_on_zone_id", using: :btree

  create_table "image_sizes", force: :cascade do |t|
    t.string   "image_type"
    t.integer  "image_id"
    t.string   "resize_type"
    t.float    "resized_size_in_kb"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "image_sizes", ["image_type", "image_id", "resize_type"], name: "index_image_sizes_on_image_type_and_image_id_and_resize_type", unique: true, using: :btree

  create_table "kitchens", force: :cascade do |t|
    t.integer  "hotel_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  create_table "legs", force: :cascade do |t|
    t.integer  "city_id",                         null: false
    t.text     "itinerary"
    t.integer  "package_id",                      null: false
    t.integer  "no_of_nights",    default: 0,     null: false
    t.boolean  "booked_by_guest", default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "legs", ["city_id"], name: "index_legs_on_city_id", using: :btree
  add_index "legs", ["package_id"], name: "index_legs_on_package_id", using: :btree

  create_table "localities", force: :cascade do |t|
    t.string   "name"
    t.integer  "type"
    t.string   "type_specification"
    t.float    "lat"
    t.float    "long"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",             default: 1
    t.integer  "priority"
    t.json     "description",        default: {}
  end

  add_index "localities", ["city_id"], name: "index_localities_on_city_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.integer  "event_type"
    t.string   "event_value"
    t.integer  "created_by_id"
    t.json     "meta_data",     default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meal_bookings", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "meal_plan_type"
    t.integer  "number_of_persons"
    t.integer  "price_per_person"
    t.integer  "oyo_commission"
    t.date     "from"
    t.date     "till"
    t.integer  "status"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "meal_plan_sub_type", default: 0
  end

  add_index "meal_bookings", ["booking_id"], name: "index_meal_bookings_on_booking_id", using: :btree

  create_table "meal_menus", force: :cascade do |t|
    t.integer  "menu_type"
    t.json     "menu_content"
    t.integer  "meal_plan_id"
    t.string   "salesforce_id", limit: 20
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "meal_menus", ["meal_plan_id"], name: "index_meal_menus_on_meal_plan_id", using: :btree
  add_index "meal_menus", ["salesforce_id"], name: "index_meal_menus_on_salesforce_id", using: :btree

  create_table "meal_plans", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "plan_type"
    t.boolean  "non_veg_available"
    t.integer  "veg_price"
    t.integer  "non_veg_price"
    t.integer  "oyo_commission"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "ep_price_reduction"
    t.boolean  "is_active"
    t.string   "salesforce_id",      limit: 20
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "plan_sub_type",                 default: 0
  end

  add_index "meal_plans", ["hotel_id"], name: "index_meal_plans_on_hotel_id", using: :btree
  add_index "meal_plans", ["salesforce_id"], name: "index_meal_plans_on_salesforce_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "sent_by_id"
    t.integer  "sms_type_id"
    t.string   "number",       limit: 255
    t.text     "content"
    t.string   "status",       limit: 255
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country_code", limit: 255
    t.integer  "provider"
    t.integer  "mask"
    t.string   "providers"
  end

  add_index "messages", ["booking_id"], name: "index_messages_on_booking_id", using: :btree
  add_index "messages", ["created_at"], name: "index_created_ats_on_messages", using: :btree
  add_index "messages", ["sms_type_id"], name: "index_messages_on_sms_type_id", using: :btree

  create_table "micro_market_associations", force: :cascade do |t|
    t.integer "item_id"
    t.string  "item_type"
    t.integer "micro_market_id"
  end

  add_index "micro_market_associations", ["item_type", "item_id"], name: "index_micro_market_associations_on_item_type_and_item_id", using: :btree
  add_index "micro_market_associations", ["micro_market_id", "item_type", "item_id"], name: "index_mma_on_micro_market_id_and_item_type_and_item_id", unique: true, using: :btree

  create_table "micro_markets", force: :cascade do |t|
    t.integer  "city_id",                 null: false
    t.string   "name",                    null: false
    t.string   "mm_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "emails",     default: [],              array: true
  end

  add_index "micro_markets", ["emails"], name: "index_micro_markets_on_emails", using: :gin
  add_index "micro_markets", ["mm_id"], name: "index_micro_markets_on_mm_id", using: :btree

  create_table "mini_clusters", force: :cascade do |t|
    t.string   "name",                  null: false
    t.integer  "cluster_id",            null: false
    t.integer  "status"
    t.integer  "priority"
    t.string   "keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",       limit: 20
  end

  add_index "mini_clusters", ["cluster_id"], name: "index_mini_clusters_on_cluster_id", using: :btree

  create_table "misc_data", force: :cascade do |t|
    t.text     "object"
    t.text     "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "new_contracts", force: :cascade do |t|
    t.float    "rs"
    t.integer  "ft"
    t.integer  "ft_double"
    t.integer  "ft_triple"
    t.integer  "mgft"
    t.integer  "mgft_double"
    t.integer  "mgft_triple"
    t.integer  "mg_rooms"
    t.float    "early_checkin_host_share"
    t.float    "late_checkout_host_share"
    t.integer  "rooms",                                   null: false
    t.boolean  "active",                   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "new_hotel_contract_details", force: :cascade do |t|
    t.integer  "new_contract_id"
    t.integer  "hotel_id"
    t.date     "valid_from",      null: false
    t.date     "valid_till",      null: false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "signed_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "new_hotel_contract_details", ["created_by_id"], name: "index_new_hotel_contract_details_on_created_by_id", using: :btree
  add_index "new_hotel_contract_details", ["hotel_id"], name: "index_new_hotel_contract_details_on_hotel_id", using: :btree
  add_index "new_hotel_contract_details", ["new_contract_id"], name: "index_new_hotel_contract_details_on_new_contract_id", using: :btree
  add_index "new_hotel_contract_details", ["signed_by_id"], name: "index_new_hotel_contract_details_on_signed_by_id", using: :btree
  add_index "new_hotel_contract_details", ["updated_by_id"], name: "index_new_hotel_contract_details_on_updated_by_id", using: :btree

  create_table "news_feeds", force: :cascade do |t|
    t.integer  "item_id",                          null: false
    t.string   "item_type",                        null: false
    t.integer  "category",                         null: false
    t.json     "meta_data",                        null: false
    t.integer  "concerned_hotel_ids", default: [],              array: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "feed_status",         default: 1
  end

  add_index "news_feeds", ["category"], name: "index_news_feeds_on_category", using: :btree
  add_index "news_feeds", ["concerned_hotel_ids"], name: "index_news_feeds_on_concerned_hotel_ids", using: :gin

  create_table "online_travel_agents", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.float    "percentage"
    t.string   "contract",                   limit: 255
    t.string   "website",                    limit: 255
    t.integer  "user_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "onlinetravelagent_ref_code"
    t.integer  "status",                                 default: 0
    t.string   "email"
    t.string   "contact_number"
  end

  add_index "online_travel_agents", ["user_profile_id"], name: "index_online_travel_agents_on_user_profile_id", using: :btree

  create_table "open_room_rec", force: :cascade do |t|
  end

  create_table "orr_neg_requests", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "guest_id"
    t.integer  "hotel_id"
    t.integer  "cluster_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "requester_id",                  null: false
    t.integer  "receiver_id",                   null: false
    t.integer  "sales_agent_id",                null: false
    t.date     "checkin",                       null: false
    t.date     "checkout",                      null: false
    t.integer  "status",                        null: false
    t.integer  "occupancy",        default: [],              array: true
    t.float    "negotiated_rates", default: [],              array: true
    t.json     "meta_data",        default: {}
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "source_referral"
  end

  add_index "orr_neg_requests", ["cluster_id"], name: "index_orr_neg_requests_on_cluster_id", using: :btree
  add_index "orr_neg_requests", ["hotel_id"], name: "index_orr_neg_requests_on_hotel_id", using: :btree
  add_index "orr_neg_requests", ["receiver_id"], name: "index_orr_neg_requests_on_receiver_id", using: :btree
  add_index "orr_neg_requests", ["requester_id"], name: "index_orr_neg_requests_on_requester_id", using: :btree
  add_index "orr_neg_requests", ["source_type", "source_id"], name: "index_orr_neg_requests_on_source_type_and_source_id", using: :btree

  create_table "ota_hotel_commisions", force: :cascade do |t|
    t.integer  "online_travel_agent_id"
    t.integer  "hotel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "from_date"
    t.date     "to_date"
    t.integer  "percentage",             default: 0
  end

  add_index "ota_hotel_commisions", ["hotel_id"], name: "index_ota_hotel_commisions_on_hotel_id", using: :btree
  add_index "ota_hotel_commisions", ["online_travel_agent_id"], name: "index_ota_hotel_commisions_on_online_travel_agent_id", using: :btree

  create_table "ota_logs", force: :cascade do |t|
    t.string   "ota_booking_id"
    t.string   "ota_hotel_name"
    t.datetime "booking_date"
    t.integer  "booking_id"
    t.integer  "hotel_id"
    t.integer  "ota_id"
    t.integer  "user_profile_id"
    t.json     "guest_detail"
    t.json     "booking_detail"
    t.json     "room_detail"
    t.json     "checkin_detail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "status_note"
    t.datetime "booking_created_at"
  end

  create_table "oyo_commission_invoices", force: :cascade do |t|
    t.integer  "hotel_id",                         null: false
    t.integer  "month",                            null: false
    t.integer  "year",                             null: false
    t.float    "oyo_commission",     default: 0.0, null: false
    t.boolean  "completed"
    t.datetime "last_calculated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oyo_commission_invoices", ["hotel_id"], name: "index_oyo_commission_invoices_on_hotel_id", using: :btree
  add_index "oyo_commission_invoices", ["month", "year", "hotel_id"], name: "index_oyo_commission_invoices_on_month_and_year_and_hotel_id", unique: true, using: :btree

  create_table "packages", force: :cascade do |t|
    t.string   "name",                                null: false
    t.integer  "agent_id",                            null: false
    t.integer  "guest_id",                            null: false
    t.integer  "no_of_nights",                        null: false
    t.integer  "status",          default: 0,         null: false
    t.string   "code",                                null: false
    t.integer  "occupancy",       default: [0, 0, 0],              array: true
    t.integer  "micro_market_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "packages", ["agent_id"], name: "index_packages_on_agent_id", using: :btree
  add_index "packages", ["code"], name: "index_packages_on_code", using: :btree
  add_index "packages", ["guest_id"], name: "index_packages_on_guest_id", using: :btree

  create_table "payment_transacs", force: :cascade do |t|
    t.integer  "guest_id"
    t.integer  "booking_id"
    t.integer  "refund_request_id"
    t.integer  "amount"
    t.integer  "advance"
    t.string   "billing_address",           limit: 255
    t.string   "payment_mode",              limit: 255
    t.string   "bank_ref_num",              limit: 255
    t.string   "pg_type",                   limit: 255
    t.string   "bankcode",                  limit: 255
    t.integer  "status"
    t.datetime "time_transaction_success"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "txnid",                     limit: 255
    t.string   "merchant_error",            limit: 255
    t.string   "merchant_status",           limit: 255
    t.integer  "merchant"
    t.string   "card_type",                 limit: 255
    t.string   "issuing_bank",              limit: 255
    t.string   "billing_name",              limit: 255
    t.string   "mihpayid",                  limit: 255
    t.string   "user_ip",                   limit: 255
    t.integer  "payment_type"
    t.boolean  "payment_verified",                      default: false
    t.datetime "time_processed_by_gateway"
    t.integer  "created_by_id"
    t.integer  "currency_id"
    t.integer  "user_currency_id"
    t.float    "user_currency_amount"
    t.float    "currency_conversion_ratio"
    t.integer  "upm_id"
    t.json     "reason",                                default: {}
    t.json     "metadata",                              default: {}
    t.boolean  "sap_sync"
    t.boolean  "is_visible",                            default: true
    t.integer  "parent_transac_id"
    t.integer  "approved_by_id"
    t.string   "edc_hardware_id"
    t.boolean  "alcott_sap_sync"
  end

  add_index "payment_transacs", ["booking_id"], name: "index_payment_transacs_on_booking_id", using: :btree
  add_index "payment_transacs", ["created_at"], name: "index_payment_transacs_on_created_at", using: :btree
  add_index "payment_transacs", ["edc_hardware_id"], name: "index_payment_transacs_on_edc_hardware_id", using: :btree
  add_index "payment_transacs", ["guest_id"], name: "index_payment_transacs_on_guest_id", using: :btree
  add_index "payment_transacs", ["refund_request_id"], name: "index_payment_transacs_on_refund_request_id", using: :btree

  create_table "personas", force: :cascade do |t|
    t.json     "city_source",     default: {}
    t.json     "date",            default: {}
    t.json     "bookings",        default: {}
    t.json     "amount",          default: {}
    t.json     "discount",        default: {}
    t.json     "roomnights",      default: {}
    t.json     "length_of_stay",  default: {}
    t.json     "flag_variable",   default: {}
    t.json     "feedback",        default: {}
    t.json     "bookings_issue",  default: {}
    t.json     "bookings_area",   default: {}
    t.json     "browsing_data",   default: {}
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_profile_id"
    t.json     "booked_info",     default: {}
    t.json     "processed_info",  default: {}
  end

  add_index "personas", ["user_profile_id"], name: "index_personas_on_user_profile_id", unique: true, using: :btree

  create_table "pricing_rules", force: :cascade do |t|
    t.integer  "category",                                                   null: false
    t.json     "other_data"
    t.integer  "markup_type",                                                null: false
    t.decimal  "markup_value",         precision: 12, scale: 3,              null: false
    t.integer  "domain_type",                                                null: false
    t.integer  "domain_ids",                                    default: [], null: false, array: true
    t.integer  "excluded_domain_type"
    t.integer  "excluded_domain_ids",                                                     array: true
    t.datetime "created_at"
    t.datetime "expired_at"
    t.date     "start_date",                                                 null: false
    t.date     "end_date",                                                   null: false
    t.integer  "frequency",                                     default: 0
  end

  add_index "pricing_rules", ["domain_type", "domain_ids"], name: "index_pricing_rules_on_domain_type_and_domain_ids", using: :btree
  add_index "pricing_rules", ["end_date", "start_date"], name: "index_pricing_rules_on_end_date_and_start_date", using: :btree
  add_index "pricing_rules", ["excluded_domain_type", "excluded_domain_ids"], name: "index_on_excluded_domains", using: :btree

  create_table "property_announcements", force: :cascade do |t|
    t.string   "caption",                 null: false
    t.text     "description",             null: false
    t.date     "start_date",              null: false
    t.date     "end_date",                null: false
    t.integer  "status",      default: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "property_announcements", ["end_date"], name: "index_property_announcements_on_end_date", using: :btree
  add_index "property_announcements", ["start_date"], name: "index_property_announcements_on_start_date", using: :btree
  add_index "property_announcements", ["status"], name: "index_property_announcements_on_status", using: :btree

  create_table "property_setups", force: :cascade do |t|
    t.integer  "hotel_id",               null: false
    t.integer  "flag",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_standups", force: :cascade do |t|
    t.integer  "hotel_id",     null: false
    t.datetime "started_at",   null: false
    t.datetime "completed_at", null: false
    t.json     "meta_data"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "property_standups", ["hotel_id"], name: "index_property_standups_on_hotel_id", using: :btree
  add_index "property_standups", ["started_at"], name: "index_property_standups_on_started_at", using: :btree

  create_table "provisional_buyouts", force: :cascade do |t|
    t.integer  "hotel_id"
    t.decimal  "mg_orr_so",                precision: 8, scale: 2,              null: false
    t.decimal  "mg_orr_do",                precision: 8, scale: 2,              null: false
    t.decimal  "mg_orr_to",                precision: 8, scale: 2,              null: false
    t.decimal  "orr_so",                   precision: 8, scale: 2
    t.decimal  "orr_do",                   precision: 8, scale: 2
    t.decimal  "orr_to",                   precision: 8, scale: 2
    t.date     "valid_from",                                                    null: false
    t.date     "valid_till",                                                    null: false
    t.integer  "mg_rooms",                                         default: [], null: false, array: true
    t.decimal  "advance_percent",          precision: 5, scale: 2,              null: false
    t.decimal  "owner_share_percent",      precision: 5, scale: 2,              null: false
    t.decimal  "penalty_percent",          precision: 5, scale: 2,              null: false
    t.float    "early_checkin_host_share",                                      null: false
    t.float    "late_checkout_host_share",                                      null: false
    t.integer  "request_state",                                                 null: false
    t.string   "notes"
    t.json     "metadata",                                         default: {}
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.date     "request_valid_till"
  end

  add_index "provisional_buyouts", ["hotel_id"], name: "index_provisional_buyouts_on_hotel_id", using: :btree

  create_table "purge_histories", force: :cascade do |t|
    t.integer  "hotel_id",    null: false
    t.integer  "action_type", null: false
    t.integer  "crime_type"
    t.integer  "who_dun_it",  null: false
    t.json     "meta_data"
    t.datetime "created_at"
  end

  add_index "purge_histories", ["action_type"], name: "index_purge_histories_on_action_type", using: :btree
  add_index "purge_histories", ["crime_type"], name: "index_purge_histories_on_crime_type", using: :btree
  add_index "purge_histories", ["hotel_id"], name: "index_purge_histories_on_hotel_id", using: :btree
  add_index "purge_histories", ["who_dun_it"], name: "index_purge_histories_on_who_dun_it", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.text     "description"
    t.integer  "type"
    t.integer  "priority"
    t.json     "applicable_to"
    t.string   "negative_response_text", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reception_lobbies", force: :cascade do |t|
    t.integer  "hotel_id",   null: false
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  create_table "recon_payment_cycles", force: :cascade do |t|
    t.integer  "hotel_id",                          null: false
    t.integer  "recon_cycle_type",  default: 3,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_process",   default: 0
    t.integer  "recovery_type",     default: 0
    t.boolean  "purge_lock",        default: false
    t.boolean  "recon_at_checkout", default: true
    t.text     "notes"
  end

  add_index "recon_payment_cycles", ["hotel_id"], name: "index_recon_payment_cycles_on_hotel_id", unique: true, using: :btree
  add_index "recon_payment_cycles", ["recon_cycle_type"], name: "index_recon_payment_cycles_on_recon_cycle_type", using: :btree
  add_index "recon_payment_cycles", ["recovery_type"], name: "index_recon_payment_cycles_on_recovery_type", using: :btree

  create_table "reconciliation_invoices", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "month"
    t.integer  "year"
    t.integer  "amount"
    t.float    "service_tax"
    t.float    "total_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invoice_no"
    t.integer  "reconciliation_id"
  end

  create_table "reconciliations", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "total_room_nights",                                      default: 0
    t.float    "total_host_revenue",                                     default: 0.0
    t.float    "total_host_share",                                       default: 0.0
    t.float    "total_oyo_share",                                        default: 0.0
    t.float    "total_source_share",                                     default: 0.0
    t.float    "payment_to_host",                                        default: 0.0
    t.float    "payment_to_oyo",                                         default: 0.0
    t.float    "payment_to_source",                                      default: 0.0
    t.integer  "month"
    t.integer  "year"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_revenue",                                          default: 0.0
    t.float    "total_host_share_first_cycle",                           default: 0.0
    t.float    "total_tax_payable_to_host",                              default: 0.0
    t.float    "total_booking_advance",                                  default: 0.0
    t.float    "total_deduction",                                        default: 0.0
    t.float    "bills",                                                  default: 0.0
    t.float    "extras",                                                 default: 0.0
    t.datetime "calculated_at"
    t.boolean  "completed",                                              default: false
    t.boolean  "calculating"
    t.string   "file_name"
    t.boolean  "new_contract"
    t.integer  "oyo_bills",                                              default: 0
    t.integer  "valid_mg"
    t.integer  "ghost_amount",                                           default: 0
    t.integer  "projected_mg",                                           default: 0
    t.integer  "projected_urn",                                          default: 0
    t.integer  "previous_month_recovery",                                default: 0
    t.text     "notes_extras"
    t.text     "notes_total_deduction"
    t.integer  "ghost_amount_peak_buyout",                               default: 0
    t.boolean  "sap_sync"
    t.float    "total_payable_host_share",                               default: 0.0,   null: false
    t.float    "total_host_meal_share",                                  default: 0.0,   null: false
    t.float    "total_oyo_meal_share",                                   default: 0.0,   null: false
    t.float    "incentives"
    t.string   "notes_incentives"
    t.float    "additional_cancellation_income"
    t.decimal  "penalty_amount",                 precision: 8, scale: 2
  end

  add_index "reconciliations", ["hotel_id"], name: "index_reconciliations_on_hotel_id", using: :btree
  add_index "reconciliations", ["month", "year", "hotel_id"], name: "index_reconciliations_on_month_and_year_and_hotel_id", unique: true, using: :btree

  create_table "redeemed_coupons", force: :cascade do |t|
    t.integer "coupon_id"
    t.integer "booking_id"
    t.integer "user_id"
    t.inet    "redeem_ip"
    t.string  "coupon_code"
    t.boolean "booking_status_valid"
  end

  add_index "redeemed_coupons", ["booking_id"], name: "index_redeemed_coupons_on_booking_id", using: :btree
  add_index "redeemed_coupons", ["coupon_code", "booking_status_valid"], name: "redeemed_coupons_code_and_status", using: :btree
  add_index "redeemed_coupons", ["coupon_id"], name: "index_redeemed_coupons_on_coupon_id", using: :btree
  add_index "redeemed_coupons", ["user_id"], name: "index_redeemed_coupons_on_user_id", using: :btree

  create_table "referral_aliases", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "valid_from"
    t.datetime "valid_till"
    t.string   "alias_name"
    t.json     "meta_data"
    t.boolean  "can_share",  default: false
    t.integer  "max_usage",  default: 0
  end

  add_index "referral_aliases", ["alias_name", "user_id"], name: "index_referral_aliases_on_alias_name_and_user_id", using: :btree

  create_table "refunds", force: :cascade do |t|
    t.integer  "guest_id"
    t.integer  "payment_transac_id"
    t.integer  "initiated_by_id"
    t.string   "ref_id",             limit: 255
    t.string   "request_id",         limit: 255
    t.string   "bank_ref_no",        limit: 255
    t.integer  "status"
    t.decimal  "amount",                         precision: 12, scale: 2
    t.string   "message",            limit: 255
    t.string   "error_code",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action",             limit: 255
    t.string   "verified_status",    limit: 255
    t.string   "description",        limit: 120
    t.boolean  "sap_sync"
    t.boolean  "active",                                                  default: true
    t.boolean  "alcott_sap_sync"
  end

  add_index "refunds", ["active"], name: "index_refunds_on_active", using: :btree
  add_index "refunds", ["guest_id"], name: "index_refunds_on_guest_id", using: :btree
  add_index "refunds", ["initiated_by_id"], name: "index_refunds_on_initiated_by_id", using: :btree
  add_index "refunds", ["payment_transac_id"], name: "index_refunds_on_payment_transac_id", using: :btree
  add_index "refunds", ["ref_id"], name: "index_refunds_on_ref_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "assigned_by_id"
    t.integer  "assigned_to_id"
    t.integer  "assigned_for_id"
    t.string   "description",     limit: 255
    t.string   "workflow_state",  limit: 255, default: "created"
    t.json     "meta_data"
    t.integer  "sla",             limit: 2
    t.integer  "category",                    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "booking_id"
    t.text     "comments"
    t.string   "resolution"
  end

  add_index "requests", ["assigned_by_id"], name: "index_requests_on_assigned_by_id", using: :btree
  add_index "requests", ["assigned_for_id"], name: "index_requests_on_assigned_for_id", using: :btree
  add_index "requests", ["assigned_to_id"], name: "index_requests_on_assigned_to_id", using: :btree

  create_table "responses", force: :cascade do |t|
    t.integer  "audit_id"
    t.integer  "question_id"
    t.string   "answer",      limit: 255
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_url",               default: [], array: true
  end

  add_index "responses", ["item_id"], name: "index_responses_on_item_id", using: :btree

  create_table "restrictions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.boolean  "enforcable",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "restrictions", ["name"], name: "rahul_temp_rest", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "role_name"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_amenities_lists", force: :cascade do |t|
    t.string   "name",        limit: 40, null: false
    t.text     "description"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_amenities_lists_rooms", force: :cascade do |t|
    t.integer  "room_id",                null: false
    t.integer  "room_amenities_list_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "room_amenities_lists_rooms", ["room_amenities_list_id"], name: "index_room_amenities_lists_rooms_on_room_amenities_list_id", using: :btree
  add_index "room_amenities_lists_rooms", ["room_id"], name: "index_room_amenities_lists_rooms_on_room_id", using: :btree

  create_table "room_pricings", force: :cascade do |t|
    t.integer  "price_single"
    t.integer  "price_double"
    t.integer  "price_extra_person"
    t.string   "name",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency_id"
  end

  create_table "room_types", force: :cascade do |t|
    t.text     "description"
    t.integer  "person_allowed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "name"
    t.integer  "extra_person_allowed"
    t.integer  "extra_bed_allowed"
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name",                     limit: 40
    t.text     "description"
    t.string   "number",                   limit: 255
    t.string   "floor",                    limit: 255
    t.string   "size",                     limit: 255
    t.integer  "hotel_id",                                         null: false
    t.integer  "room_type_id",                                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
    t.integer  "status"
    t.integer  "state",                                default: 0, null: false
    t.integer  "status_subtype",                       default: 0
    t.integer  "number_of_beds"
    t.integer  "hotel_wifi_credential_id"
    t.string   "parent_room_number"
  end

  add_index "rooms", ["hotel_id"], name: "index_rooms_on_hotel_id", using: :btree
  add_index "rooms", ["hotel_wifi_credential_id"], name: "index_rooms_on_hotel_wifi_credential_id", using: :btree
  add_index "rooms", ["room_type_id"], name: "index_rooms_on_room_type_id", using: :btree
  add_index "rooms", ["state", "status"], name: "index_rooms_on_state_and_status", using: :btree

  create_table "run_sale_rec", force: :cascade do |t|
  end

  create_table "sap_error_logs", force: :cascade do |t|
    t.integer  "error_type"
    t.integer  "item_id"
    t.string   "call_type"
    t.integer  "delayed_job_id"
    t.integer  "prerequisite_delayed_job_ids",                          array: true
    t.json     "error_details"
    t.string   "url_string"
    t.string   "xml_string"
    t.datetime "retry_successful_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sap_response"
    t.boolean  "single_call"
    t.json     "queue_data"
    t.integer  "sap_company_type",             default: 0, null: false
  end

  add_index "sap_error_logs", ["call_type"], name: "index_sap_error_logs_on_call_type", using: :btree
  add_index "sap_error_logs", ["delayed_job_id"], name: "index_sap_error_logs_on_delayed_job_id", using: :btree
  add_index "sap_error_logs", ["error_type"], name: "index_sap_error_logs_on_error_type", using: :btree
  add_index "sap_error_logs", ["item_id"], name: "index_sap_error_logs_on_item_id", using: :btree

  create_table "section_items", force: :cascade do |t|
    t.string   "deal_name"
    t.string   "display_name"
    t.string   "description"
    t.integer  "deal_type"
    t.integer  "status"
    t.integer  "priority"
    t.datetime "start_date"
    t.datetime "end_date"
    t.json     "meta_data"
    t.string   "image_url"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.text     "allowed_channel", default: ["Android App", "IOS App"], null: false, array: true
    t.integer  "country_id",      default: 1
    t.float    "latitude",        default: 0.0
    t.float    "longitude",       default: 0.0
    t.float    "radius",          default: 100.0
    t.integer  "section_id",      default: 1
    t.string   "image_url_web"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title"
    t.integer  "priority"
    t.integer  "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "allowed_channels", default: ["Android App", "IOS App"], null: false, array: true
    t.string   "html"
    t.integer  "country_ids",                                                        array: true
    t.integer  "max_items"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.boolean  "show_title",       default: false
    t.integer  "scroll_type"
    t.integer  "widget_type"
  end

  create_table "service_bills", force: :cascade do |t|
    t.integer  "hotel_service_id"
    t.integer  "created_by_id"
    t.integer  "modified_by_id"
    t.date     "due_date"
    t.float    "bill_amount"
    t.boolean  "status"
    t.date     "pay_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_bills", ["hotel_service_id"], name: "index_service_bills_on_hotel_service_id", using: :btree

  create_table "shiftings", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "from_hotel_id"
    t.integer  "to_hotel_id"
    t.integer  "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "agent_id"
    t.integer  "status",         default: 0,  null: false
    t.integer  "type",           default: 0,  null: false
    t.json     "metadata",       default: {}
    t.integer  "executed_by_id"
  end

  add_index "shiftings", ["booking_id", "from_hotel_id", "to_hotel_id", "status"], name: "uniqueness_index_for_shiftings", unique: true, using: :btree
  add_index "shiftings", ["booking_id"], name: "index_shiftings_on_booking_id", using: :btree
  add_index "shiftings", ["from_hotel_id"], name: "index_shiftings_on_from_hotel_id", using: :btree
  add_index "shiftings", ["status"], name: "index_shiftings_on_status", using: :btree
  add_index "shiftings", ["to_hotel_id"], name: "index_shiftings_on_to_hotel_id", using: :btree

  create_table "social_auths", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "uid",        limit: 255
    t.string   "auth_token", limit: 255
    t.integer  "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_auths", ["provider", "uid"], name: "index_social_auths_on_provider_and_uid", using: :btree
  add_index "social_auths", ["user_id"], name: "index_social_auths_on_user_id", using: :btree

  create_table "state_vat_categories", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "food_vat_category_id"
    t.float    "vat"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "state_vat_categories", ["food_vat_category_id"], name: "index_state_vat_categories_on_food_vat_category_id", using: :btree
  add_index "state_vat_categories", ["state_id"], name: "index_state_vat_categories_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.string   "alcott_tin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vat_no"
  end

  add_index "states", ["country_id"], name: "index_states_on_country_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.string   "tag_name",      limit: 255, null: false
    t.integer  "taggable_id",               null: false
    t.string   "taggable_type", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_name"], name: "taggings_idx_tag_name", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_type_and_taggable_id", using: :btree
  add_index "taggings", ["taggable_type", "tag_name"], name: "index_taggings_on_taggable_type_and_tag_name", using: :btree

  create_table "tags", id: false, force: :cascade do |t|
    t.string   "name",        limit: 255,                 null: false
    t.string   "description", limit: 255
    t.string   "image_name",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "metadata",                default: {}
    t.boolean  "auto_update",             default: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "category"
    t.integer  "status"
    t.integer  "urgency"
    t.text     "request"
    t.text     "response"
    t.integer  "amount"
    t.integer  "team"
    t.integer  "assigned_to_id"
    t.integer  "assigned_by_id"
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "team_name"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temp1", id: false, force: :cascade do |t|
    t.string  "phone", limit: 255
    t.integer "count"
  end

  create_table "ticket_categories", force: :cascade do |t|
    t.string   "label"
    t.string   "label_display"
    t.boolean  "active",        default: true
    t.integer  "parent_id"
    t.string   "uid"
    t.integer  "type"
    t.integer  "questions",     default: [],                array: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "uses",          default: [],                array: true
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "source"
    t.string   "status"
    t.string   "category"
    t.integer  "freshdesk_ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "priority"
    t.integer  "followed_up_count",   default: 0
    t.string   "follow_up_ids",       default: [], array: true
    t.json     "meta_data",           default: {}
    t.integer  "instance_source",     default: 1
    t.integer  "category_id"
  end

  add_index "tickets", ["resource_type", "resource_id"], name: "index_tickets_on_resource_type_and_resource_id", using: :btree
  add_index "tickets", ["source"], name: "index_tickets_on_source", using: :btree

  create_table "travel_agents", force: :cascade do |t|
    t.string   "travelagent_ref_code", limit: 255
    t.string   "name",                 limit: 255
    t.integer  "discount"
    t.integer  "user_profile_id"
    t.string   "billing_name",         limit: 255
    t.text     "billing_address"
    t.string   "contract",             limit: 255
    t.integer  "credit_limit"
    t.boolean  "allow_credit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commission",                       default: 0
    t.integer  "commission_type",                  default: 0
    t.string   "fax"
    t.integer  "payment_mode"
    t.string   "credit_period"
    t.integer  "category"
    t.string   "city"
    t.string   "state"
    t.string   "contact_number"
    t.string   "email"
    t.boolean  "show_original_name",               default: false
    t.integer  "status",                           default: 0
    t.string   "pin_code"
    t.integer  "agent_type",                       default: 0
    t.json     "commission_slabs"
    t.integer  "payment_via",                      default: 0,     null: false
    t.json     "commission_struct",                default: {}
  end

  add_index "travel_agents", ["agent_type"], name: "index_travel_agents_on_agent_type", using: :btree
  add_index "travel_agents", ["travelagent_ref_code"], name: "index_travel_agents_on_travelagent_ref_code", using: :btree
  add_index "travel_agents", ["user_profile_id"], name: "index_travel_agents_on_user_profile_id", using: :btree

  create_table "user_device_identifiers", force: :cascade do |t|
    t.integer  "device_identifier_id"
    t.integer  "user_profile_id"
    t.integer  "signup_count"
    t.integer  "status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "authentication_token"
    t.string   "phonebook_sync_time"
  end

  add_index "user_device_identifiers", ["authentication_token"], name: "index_user_device_identifiers_on_authentication_token", using: :btree
  add_index "user_device_identifiers", ["device_identifier_id"], name: "index_user_device_identifiers_on_device_identifier_id", using: :btree
  add_index "user_device_identifiers", ["user_profile_id", "device_identifier_id"], name: "device_identifier_idx", using: :btree
  add_index "user_device_identifiers", ["user_profile_id", "status"], name: "index_user_device_identifiers_on_user_profile_id_and_status", using: :btree

  create_table "user_feeds", force: :cascade do |t|
    t.integer  "news_feed_id",                    null: false
    t.integer  "user_profile_id",                 null: false
    t.integer  "status",          default: 0
    t.boolean  "is_pinned",       default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "user_feeds", ["news_feed_id"], name: "index_user_feeds_on_news_feed_id", using: :btree
  add_index "user_feeds", ["user_profile_id"], name: "index_user_feeds_on_user_profile_id", using: :btree

  create_table "user_filters", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.json     "tables_to_join"
    t.json     "filters_to_apply"
    t.json     "params_to_pass"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_payment_methods", force: :cascade do |t|
    t.integer  "provider"
    t.integer  "user_profile_id"
    t.string   "phone"
    t.string   "email"
    t.json     "meta_data"
    t.datetime "expiry_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_payment_methods", ["user_profile_id"], name: "index_user_payment_methods_on_user_profile_id", using: :btree

  create_table "user_phonebook_block_invite", force: :cascade do |t|
    t.string "phone"
    t.string "device_id"
  end

  add_index "user_phonebook_block_invite", ["device_id"], name: "index_user_phonebook_block_invite_on_device_id", using: :btree
  add_index "user_phonebook_block_invite", ["phone"], name: "index_user_phonebook_block_invite_on_phone", using: :btree

  create_table "user_phonebook_blocked", id: false, force: :cascade do |t|
    t.string "phone",        null: false
    t.string "country_code", null: false
  end

  add_index "user_phonebook_blocked", ["phone"], name: "index_user_phonebook_blocked_on_phone", using: :btree
  add_index "user_phonebook_blocked", ["phone"], name: "user_phonebook_blocked_unique", unique: true, using: :btree

  create_table "user_phonebook_email", force: :cascade do |t|
    t.integer  "user_id",           null: false
    t.string   "contact_name",      null: false
    t.string   "contact_email"
    t.string   "device_contact_id", null: false
    t.string   "revision_id",       null: false
    t.text     "extended_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "device_id",         null: false
  end

  add_index "user_phonebook_email", ["user_id", "device_id", "contact_email"], name: "user_email_unique", unique: true, using: :btree
  add_index "user_phonebook_email", ["user_id"], name: "index_user_phonebook_email_on_user_id", using: :btree

  create_table "user_phonebook_export", force: :cascade do |t|
    t.integer  "user_id",            null: false
    t.string   "contact_name",       null: false
    t.string   "phone"
    t.string   "raw_phone"
    t.integer  "contact_id"
    t.string   "device_contact_id",  null: false
    t.string   "revision_id",        null: false
    t.datetime "user_invited_at"
    t.datetime "invitation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "device_id",          null: false
    t.integer  "country_code",       null: false
  end

  add_index "user_phonebook_export", ["phone"], name: "index_user_phonebook_export_on_phone", using: :btree
  add_index "user_phonebook_export", ["user_id", "device_id", "phone"], name: "user_phone_unique", unique: true, using: :btree
  add_index "user_phonebook_export", ["user_id"], name: "index_user_phonebook_export_on_user_id", using: :btree

  create_table "user_phonebook_invite_daily", force: :cascade do |t|
    t.string  "phone"
    t.integer "invite_count", default: 0
  end

  add_index "user_phonebook_invite_daily", ["phone"], name: "index_user_phonebook_invite_daily_on_phone", using: :btree
  add_index "user_phonebook_invite_daily", ["phone"], name: "user_phonebook_invite_unique", unique: true, using: :btree

  create_table "user_profiles", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "phone",           limit: 255
    t.string   "email",           limit: 255
    t.string   "address",         limit: 255
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.integer  "sex"
    t.integer  "status",                      default: 1
    t.text     "registration_id",             default: [],              array: true
    t.integer  "team"
    t.integer  "agent_id"
    t.string   "country_code",    limit: 255
    t.integer  "country_id",                  default: 1,  null: false
    t.integer  "currency_id"
    t.integer  "devise_role",                 default: 0,  null: false
    t.string   "image_url"
  end

  add_index "user_profiles", ["devise_role", "email"], name: "devise_email_up", using: :btree
  add_index "user_profiles", ["devise_role", "phone"], name: "devise_phone_up", using: :btree
  add_index "user_profiles", ["email"], name: "index_user_profiles_on_email", using: :btree
  add_index "user_profiles", ["phone"], name: "index_user_profiles_on_phone", using: :btree
  add_index "user_profiles", ["role"], name: "index_user_profiles_on_role", using: :btree
  add_index "user_profiles", ["team"], name: "index_user_profiles_on_team", using: :btree

  create_table "user_profilings", force: :cascade do |t|
    t.integer  "guest_id"
    t.json     "booking_data",  default: {}
    t.string   "basecity"
    t.json     "browsing_data", default: {}
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "user_reviews", force: :cascade do |t|
    t.integer  "hotel_id",                    null: false
    t.datetime "display_time"
    t.text     "review_text"
    t.string   "username",                    null: false
    t.integer  "user_id"
    t.integer  "priority"
    t.integer  "rating",                      null: false
    t.boolean  "status",       default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                     limit: 255, default: ""
    t.string   "encrypted_password",        limit: 255, default: "",    null: false
    t.string   "reset_password_token",      limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",        limit: 255
    t.string   "last_sign_in_ip",           limit: 255
    t.string   "authentication_token",      limit: 255
    t.integer  "role"
    t.integer  "status",                                default: 1
    t.integer  "team"
    t.integer  "user_profile_id"
    t.boolean  "verified_phone"
    t.boolean  "verified_email"
    t.string   "phone",                     limit: 255
    t.string   "country_code",              limit: 255
    t.string   "login_token"
    t.string   "referal_alias"
    t.integer  "referrer_id"
    t.string   "encrypted_otp_secret"
    t.string   "encrypted_otp_secret_iv"
    t.string   "encrypted_otp_secret_salt"
    t.integer  "consumed_timestep"
    t.boolean  "otp_required_for_login"
    t.boolean  "password_changed_once",                 default: false
    t.integer  "referrer_alias_id"
    t.integer  "devise_role",                           default: 0,     null: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["devise_role", "email"], name: "devise_email", unique: true, where: "(email IS NOT NULL)", using: :btree
  add_index "users", ["devise_role", "phone"], name: "devise_phone", unique: true, where: "(phone IS NOT NULL)", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", using: :btree
  add_index "users", ["referal_alias"], name: "index_referal_alias_on_users", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["status"], name: "users_status", using: :btree
  add_index "users", ["user_profile_id"], name: "index_users_on_user_profile_id", unique: true, using: :btree

  create_table "vendor_accounts", force: :cascade do |t|
    t.integer  "item_id",                                                          null: false
    t.string   "item_type",                                                        null: false
    t.text     "allowed_view_hotel_tags",                          default: [],                 array: true
    t.text     "blocked_view_hotel_tags",                          default: [],                 array: true
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.boolean  "show_original_name",                               default: false
    t.boolean  "credit_allowed",                                   default: false
    t.decimal  "discount",                precision: 12, scale: 3, default: 0.0
    t.integer  "discount_type",                                    default: 0
    t.integer  "prepaid_credit_limit",                             default: 0
    t.integer  "postpaid_credit_limit",                            default: 0
    t.integer  "billing_cycle_days"
    t.integer  "settlement_period_days"
    t.integer  "grace_period_days"
    t.date     "last_billed_date"
    t.decimal  "comission_prepaid",       precision: 12, scale: 3, default: 0.0
    t.decimal  "comission_postpaid",      precision: 12, scale: 3, default: 0.0
  end

  create_table "vendor_bookings", force: :cascade do |t|
    t.integer  "vendor_id",                           null: false
    t.integer  "leg_id",                              null: false
    t.date     "from_date",                           null: false
    t.date     "to_date",                             null: false
    t.float    "amount",                default: 0.0, null: false
    t.float    "minimum_prepay_amount", default: 0.0, null: false
    t.integer  "status",                default: 0,   null: false
    t.string   "code",                                null: false
    t.integer  "micro_market_id"
    t.text     "notes"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "vendor_bookings", ["code"], name: "index_vendor_bookings_on_code", using: :btree
  add_index "vendor_bookings", ["leg_id"], name: "index_vendor_bookings_on_leg_id", using: :btree
  add_index "vendor_bookings", ["micro_market_id"], name: "index_vendor_bookings_on_micro_market_id", using: :btree
  add_index "vendor_bookings", ["vendor_id"], name: "index_vendor_bookings_on_vendor_id", using: :btree

  create_table "vendor_credits", force: :cascade do |t|
    t.integer  "vendor_account_id"
    t.string   "txnid",                               null: false
    t.string   "source_txn_id",                       null: false
    t.integer  "amount",                              null: false
    t.integer  "payment_type",                        null: false
    t.integer  "category",                            null: false
    t.text     "additional_details"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "created_by_id",      default: 122283
  end

  add_index "vendor_credits", ["vendor_account_id"], name: "index_vendor_credits_on_vendor_account_id", using: :btree

  create_table "vendor_edc_mappings", force: :cascade do |t|
    t.integer  "vendor_id",                               null: false
    t.string   "imei",                                    null: false
    t.integer  "status",                                  null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "edc_hardware_id"
    t.string   "merchant_store_pos_code"
    t.boolean  "use_pinelabs_api",        default: false
    t.json     "metadata"
    t.string   "vendor_type"
  end

  add_index "vendor_edc_mappings", ["vendor_id"], name: "index_vendor_edc_mappings_on_vendor_id", using: :btree

  create_table "vendor_user_details", force: :cascade do |t|
    t.integer "user_profile_id"
    t.integer "vendor_id"
    t.string  "vendor_type"
    t.integer "role",            default: 0
    t.json    "meta_data"
    t.boolean "active",          default: true
  end

  add_index "vendor_user_details", ["user_profile_id"], name: "index_vendor_user_details_on_user_profile_id", using: :btree
  add_index "vendor_user_details", ["vendor_id"], name: "index_vendor_user_details_on_vendor_id", using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",            limit: 100,             null: false
    t.string   "code",            limit: 20,              null: false
    t.integer  "currency_id"
    t.integer  "vendor_type",                             null: false
    t.string   "phone",           limit: 15,              null: false
    t.string   "email",           limit: 50
    t.string   "website",         limit: 50
    t.string   "company_name",    limit: 50
    t.string   "street"
    t.integer  "cluster_id",                              null: false
    t.integer  "micro_market_id",                         null: false
    t.integer  "city_id",                                 null: false
    t.integer  "zipcode",                                 null: false
    t.integer  "sales_agent_id",                          null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "status",                      default: 0
  end

  add_index "vendors", ["city_id"], name: "index_vendors_on_city_id", using: :btree
  add_index "vendors", ["cluster_id"], name: "index_vendors_on_cluster_id", using: :btree
  add_index "vendors", ["code"], name: "index_vendors_on_code", unique: true, using: :btree
  add_index "vendors", ["sales_agent_id"], name: "index_vendors_on_sales_agent_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255, null: false
    t.integer  "item_id",                    null: false
    t.string   "event",          limit: 255, null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["created_at"], name: "index_test_rahul", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  add_index "versions", ["item_type", "whodunnit"], name: "index_versions_on_item_type_and_whodunnit", using: :btree

  create_table "vip_unshiftable_users", force: :cascade do |t|
    t.string   "coupon_code"
    t.integer  "email_sent_count"
    t.string   "email_from"
    t.integer  "user_profile_id",  null: false
    t.boolean  "send_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vip_unshiftable_users", ["user_profile_id"], name: "index_vip_unshiftable_users_on_user_profile_id", using: :btree

  create_table "wallet_transacs", force: :cascade do |t|
    t.integer  "amount",                             null: false
    t.integer  "merchant",                           null: false
    t.string   "uniq_id"
    t.integer  "status",                             null: false
    t.string   "reference_id"
    t.boolean  "credit",             default: false
    t.integer  "wallet_id",                          null: false
    t.integer  "payment_transac_id"
    t.integer  "created_by_id",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency_id"
  end

  add_index "wallet_transacs", ["payment_transac_id"], name: "index_wallet_transacs_on_payment_transac_id", using: :btree
  add_index "wallet_transacs", ["uniq_id"], name: "index_wallet_transacs_on_uniq_id", using: :btree
  add_index "wallet_transacs", ["wallet_id"], name: "index_wallet_transacs_on_wallet_id", using: :btree

  create_table "wallets", force: :cascade do |t|
    t.integer  "status",                default: 1
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "expirable_balance"
    t.float    "non_expirable_balance"
    t.date     "next_flush_time"
    t.string   "type",                  default: "ConsumerWallet"
    t.integer  "currency_id"
  end

  add_index "wallets", ["currency_id"], name: "index_wallets_on_currency_id", using: :btree
  add_index "wallets", ["user_id"], name: "index_wallets_on_user_id", using: :btree

  create_table "zones", force: :cascade do |t|
    t.string  "name"
    t.integer "country_id"
  end

  add_index "zones", ["country_id"], name: "index_zones_on_country_id", using: :btree

  add_foreign_key "cities", "hubs"
  add_foreign_key "food_order_items", "food_vendors"
  add_foreign_key "hotel_floor_orrs", "hotels"
  add_foreign_key "hotel_management_details", "hotels"
  add_foreign_key "hotel_room_blocks", "hotels"
  add_foreign_key "hotel_wifi_credentials", "hotels"
  add_foreign_key "hotels", "hotels", column: "migrated_from_hotel_id"
  add_foreign_key "hubs", "zones"
  add_foreign_key "legs", "cities"
  add_foreign_key "legs", "packages"
  add_foreign_key "meal_bookings", "bookings"
  add_foreign_key "meal_menus", "meal_plans"
  add_foreign_key "meal_plans", "hotels"
  add_foreign_key "personas", "user_profiles"
  add_foreign_key "rooms", "hotel_wifi_credentials"
  add_foreign_key "state_vat_categories", "food_vat_categories"
  add_foreign_key "state_vat_categories", "states"
  add_foreign_key "states", "countries"
  add_foreign_key "vendor_bookings", "legs"
  add_foreign_key "vendor_bookings", "micro_markets"
  add_foreign_key "vendor_bookings", "vendors"
  add_foreign_key "vip_unshiftable_users", "user_profiles"
end
