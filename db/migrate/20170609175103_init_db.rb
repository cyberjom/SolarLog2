class InitDb < ActiveRecord::Migration[5.1]
  def change
    create_table "activities", force: :cascade do |t|
      t.integer  "project_id"
      t.date     "activity_date",                               null: false
      t.integer  "activity_type_id"
      t.string   "description",      limit: 500, default: ""
      t.text     "tech_note"
      t.integer  "operator_id"
      t.boolean  "active_flag",                  default: true, null: false
      t.datetime "created_at",                                  null: false
      t.datetime "updated_at",                                  null: false
      t.text     "cause_note"
      t.text     "damage_note"
      t.text     "repair_note"
    end

    create_table "activity_types", force: :cascade do |t|
      t.string   "caption",     limit: 200, default: "",   null: false
      t.string   "caption_en",  limit: 200, default: ""
      t.string   "description", limit: 500, default: ""
      t.boolean  "active_flag",             default: true, null: false
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
    end

    add_index "activity_types", ["caption"], name: "index_activity_types_on_caption", unique: true, using: :btree

    create_table "alarms", force: :cascade do |t|
      t.integer  "project_id"
      t.date     "alarm_date",                             null: false
      t.string   "description", limit: 500, default: ""
      t.text     "tech_note"
      t.boolean  "active_flag",             default: true, null: false
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
    end

    create_table "albums", force: :cascade do |t|
      t.integer  "project_id"
      t.integer  "activity_id"
      t.string   "description", limit: 500, default: ""
      t.boolean  "system_flag",             default: false, null: false
      t.datetime "created_at",                              null: false
      t.datetime "updated_at",                              null: false
    end

    create_table "audits", force: :cascade do |t|
      t.integer  "auditable_id"
      t.string   "auditable_type"
      t.integer  "associated_id"
      t.string   "associated_type"
      t.integer  "user_id"
      t.string   "user_type"
      t.string   "username"
      t.string   "action"
      t.text     "audited_changes"
      t.integer  "version",         default: 0
      t.string   "comment"
      t.string   "remote_address"
      t.string   "request_uuid"
      t.datetime "created_at"
    end

    add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
    add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
    add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
    add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
    add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

    create_table "billings", force: :cascade do |t|
      t.integer  "project_id"
      t.date     "letter_date",                                 null: false
      t.date     "meter_reading_date",                          null: false
      t.integer  "month_period"
      t.integer  "year_period"
      t.integer  "sell_unit"
      t.decimal  "fit_rate",           precision: 5,  scale: 2
      t.decimal  "amount",             precision: 10, scale: 2
      t.integer  "recent_reading"
      t.datetime "created_at",                                  null: false
      t.datetime "updated_at",                                  null: false
    end

    create_table "brands", force: :cascade do |t|
      t.string   "name",        limit: 100,                null: false
      t.boolean  "active_flag",             default: true, null: false
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
    end

    add_index "brands", ["name"], name: "index_brands_on_name", unique: true, using: :btree

    create_table "cable_types", force: :cascade do |t|
      t.string   "name",           limit: 100,                null: false
      t.string   "conductor_type", limit: 30
      t.decimal  "area"
      t.decimal  "resistance"
      t.boolean  "active_flag",                default: true, null: false
      t.datetime "created_at",                                null: false
      t.datetime "updated_at",                                null: false
    end

    create_table "customers", force: :cascade do |t|
      t.string   "firstname",   limit: 100, default: "",   null: false
      t.string   "lastname",    limit: 100
      t.boolean  "active_flag",             default: true, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "customers", ["firstname", "lastname"], name: "index_customers_on_firstname_and_lastname", unique: true, using: :btree

    create_table "devices", force: :cascade do |t|
      t.integer  "user_id"
      t.string   "uuid"
      t.string   "token"
      t.string   "note"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    add_index "devices", ["user_id"], name: "index_devices_on_user_id", unique: true, using: :btree

    create_table "document_attachments", force: :cascade do |t|
      t.integer  "document_id"
      t.string   "description", limit: 500, default: ""
      t.string   "file"
      t.boolean  "active_flag",             default: true, null: false
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
    end

    create_table "document_types", force: :cascade do |t|
      t.string   "caption",     limit: 200, default: "",   null: false
      t.string   "caption_en",  limit: 200, default: ""
      t.string   "description", limit: 500, default: ""
      t.boolean  "active_flag",             default: true, null: false
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
    end

    add_index "document_types", ["caption"], name: "index_document_types_on_caption", unique: true, using: :btree

    create_table "documents", force: :cascade do |t|
      t.integer  "project_id"
      t.integer  "activity_id"
      t.integer  "document_type_id"
      t.string   "description",      limit: 500, default: ""
      t.text     "info"
      t.boolean  "active_flag",                  default: true, null: false
      t.datetime "created_at",                                  null: false
      t.datetime "updated_at",                                  null: false
    end

    create_table "energy_days", force: :cascade do |t|
      t.date     "logger_date",                                      null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "project_id"
      t.integer  "inverter_id"
      t.integer  "pv_string_id"
      t.integer  "logger_sec"
      t.integer  "logger_type"
      t.decimal  "power_avg",               precision: 10, scale: 2
      t.decimal  "power_max",               precision: 10, scale: 2
      t.decimal  "energy",                  precision: 10, scale: 2
      t.decimal  "energy_sum",              precision: 10, scale: 2
      t.integer  "inverter_connected_time"
      t.integer  "inverter_avg_temp"
      t.integer  "inverter_max_temp"
      t.decimal  "irradiance_avg",          precision: 10, scale: 2
      t.decimal  "irradiance_max",          precision: 10, scale: 2
      t.decimal  "target_irradiance",       precision: 10, scale: 2
      t.decimal  "target_energy",           precision: 10, scale: 2
      t.decimal  "target_energy_sum",       precision: 10, scale: 2
      t.decimal  "irradiance",              precision: 10, scale: 2
    end
    
    create_table "energy_logs", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "log_at"
      t.date     "logger_date",                                      null: false
      t.integer  "day"  
      t.integer  "month"
      t.integer  "year"
      t.integer  "hour"
      t.integer  "min"
      t.integer  "sec"
      t.string   "billing_month",       limit: 6, default: ""
      t.integer  "project_id"
      t.integer  "device_id"
      t.integer  "device_type"
      t.integer  "pv_string_id"
      t.integer  "logger_sec"
      t.integer  "logger_type"
      t.integer  "power",                       default: 0
      t.integer  "power_avg"
      t.integer  "power_min"                 
      t.integer  "power_max"
      t.integer  "energy",                      default: 0                  
      t.integer  "energy_sum"
      t.boolean  "sky_photo_flag",          default: false
      t.string   "sky_photo",              limit: 2, default: ""
      t.boolean  "rain_flag",               default: false,  null: false
      t.decimal  "rain_rate",               precision: 10, scale: 2
      t.decimal  "rain_24h",                precision: 10, scale: 2
      t.integer  "uv_index"
      t.decimal  "wind_speed",              precision: 10, scale: 2
      t.decimal  "wind_gust",               precision: 10, scale: 2
      t.string   "wind_direction",          limit: 2, default: ""
      t.integer  "humidity"
      t.decimal  "pressure",                precision: 10, scale: 2
      t.decimal  "air_temperature",         precision: 10, scale: 2
      t.decimal  "global_insolation",       precision: 10, scale: 2
      t.string   "incident_insolation",     limit: 200, default: "" # W/sqm
      t.decimal  "ghi",                     precision: 10, scale: 2
      t.decimal  "ghi_avg",                 precision: 10, scale: 2
      t.decimal  "ghi_min",                 precision: 10, scale: 2
      t.decimal  "ghi_max",                 precision: 10, scale: 2    
      t.decimal  "ird",                     precision: 10, scale: 2
      t.decimal  "ird_avg",                 precision: 10, scale: 2
      t.decimal  "ird_min",                 precision: 10, scale: 2
      t.decimal  "ird_max",                 precision: 10, scale: 2
      t.decimal  "sim",                     precision: 10, scale: 2
      t.decimal  "sim_energy",              precision: 10, scale: 2
      t.decimal  "sim_energy_sum",          precision: 10, scale: 2
      t.decimal  "pr",                      precision: 10, scale: 2
      t.decimal  "ce",                      precision: 10, scale: 2      
    end

    create_table "energy_stats", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.date     "logger_date",                         null: false
      t.decimal  "sim_insolation",          precision: 10, scale: 2
      t.decimal  "sim_energy",              precision: 10, scale: 2
      t.string   "billing_month",           limit: 6, default: ""
      t.integer  "power_min"
      t.integer  "power_max"
      t.integer  "energy",                  default: 0                  
      t.decimal  "rain_hour",               precision: 10, scale: 2
      t.decimal  "rain_month",              precision: 10, scale: 2
      t.integer  "uv_index"
      t.decimal  "wind_speed",              precision: 10, scale: 2
      t.decimal  "wind_gust",               precision: 10, scale: 2
      t.string   "wind_direction",          limit: 2, default: ""
      t.integer  "humidity"
      t.decimal  "pressure",                precision: 10, scale: 2
      t.decimal  "air_temperature",         precision: 10, scale: 2
      t.decimal  "global_insolation",       precision: 10, scale: 2
      t.string   "incident_insolation",     limit: 200, default: "" # W/sqm
      t.decimal  "ghi_min",                 precision: 10, scale: 2
      t.decimal  "ghi_max",                 precision: 10, scale: 2    
      t.decimal  "ird_min",                 precision: 10, scale: 2
      t.decimal  "ird_max",                 precision: 10, scale: 2
      t.decimal  "pr",                      precision: 10, scale: 2
      t.decimal  "ce",                      precision: 10, scale: 2 
      t.integer  "day"  
      t.integer  "month"
      t.integer  "year"
    end
    
    create_table "enums", force: :cascade do |t|
      t.string   "human_code"
      t.string   "caption",      limit: 200, default: "",    null: false
      t.string   "caption_en",   limit: 200, default: ""
      t.integer  "position",                 default: 1
      t.boolean  "is_default",               default: false, null: false
      t.string   "abbr"
      t.string   "modelname"
      t.string   "filter_key"
      t.string   "parent_model"
      t.integer  "parent_id"
      t.text     "extras"
      t.integer  "position2",                default: 1
      t.string   "locale",                   default: "th"
      t.boolean  "active_flag",              default: true,  null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "enums", ["active_flag"], name: "index_enums_on_active_flag", using: :btree
    add_index "enums", ["caption"], name: "index_enums_on_caption", using: :btree
    add_index "enums", ["caption_en"], name: "index_enums_on_caption_en", using: :btree
    add_index "enums", ["created_at"], name: "index_enums_on_created_at", using: :btree
    add_index "enums", ["human_code"], name: "index_enums_on_human_code", using: :btree

    create_table "inverter_models", force: :cascade do |t|
      t.integer  "brand_id"
      t.string   "name",            limit: 100,                null: false
      t.integer  "mppt_num"
      t.integer  "modbus_speed"
      t.text     "modbus_command"
      t.text     "modbus_variable"
      t.text     "modbus_map"
      t.text     "modbus_field"
      t.boolean  "active_flag",                 default: true, null: false
      t.datetime "created_at",                                 null: false
      t.datetime "updated_at",                                 null: false
    end

    create_table "inverters", force: :cascade do |t|
      t.integer  "inverter_model_id"
      t.integer  "project_id"
      t.integer  "order_num"
      t.string   "name"
      t.string   "serial_no"
      t.integer  "modbus_no"
      t.date     "installation_date"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
    end

    create_table "locations", force: :cascade do |t|
      t.string   "caption",       limit: 200, default: "",   null: false
      t.string   "caption_en",    limit: 200
      t.text     "address_line1"
      t.text     "address_line2"
      t.string   "district",      limit: 100
      t.integer  "province_id"
      t.string   "zip_code",      limit: 10
      t.string   "telephone_no",  limit: 50
      t.string   "fax_no",        limit: 50
      t.text     "info"
      t.boolean  "active_flag",               default: true, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "locations", ["caption"], name: "index_locations_on_caption", unique: true, using: :btree

    create_table "nodes", force: :cascade do |t|
      t.string   "node_type",     limit: 1, default: "", null: false
      t.integer  "inverter_id"
      t.integer  "mppt_no"
      t.integer  "channel_no"
      t.integer  "node_id"
      t.integer  "order_num"
      t.string   "name"
      t.integer  "cable_type_id"
      t.float    "cable_length"
      t.datetime "created_at",                           null: false
      t.datetime "updated_at",                           null: false
    end

    create_table "operators", force: :cascade do |t|
      t.string   "firstname",   limit: 100, default: "",   null: false
      t.string   "lastname",    limit: 100
      t.boolean  "active_flag",             default: true, null: false
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
    end

    add_index "operators", ["firstname", "lastname"], name: "index_operators_on_firstname_and_lastname", unique: true, using: :btree

    create_table "panel_models", force: :cascade do |t|
      t.integer  "brand_id"
      t.string   "name",        limit: 100,                null: false
      t.decimal  "power"
      t.decimal  "width"
      t.decimal  "height"
      t.boolean  "active_flag",             default: true, null: false
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
    end

    create_table "panels", force: :cascade do |t|
      t.integer  "pv_string_id"
      t.integer  "panel_model_id"
      t.integer  "order_num"
      t.string   "serial_no"
      t.decimal  "power_rating"
      t.date     "installation_date"
      t.decimal  "latitude"
      t.decimal  "longitude"
      t.decimal  "direction"
      t.decimal  "incline_direction"
      t.decimal  "incline_altutude"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
    end

    create_table "photos", force: :cascade do |t|
      t.integer  "album_id"
      t.string   "description", limit: 500, default: ""
      t.string   "image"
      t.datetime "created_at",                              null: false
      t.datetime "updated_at",                              null: false
      t.boolean  "is_profile",              default: false
    end

    create_table "projects", force: :cascade do |t|
      t.integer  "location_id"
      t.integer  "logger_no"
      t.integer  "customer_id"
      t.string   "caption",            limit: 200,                          default: "",   null: false
      t.string   "caption_en",         limit: 200
      t.integer  "capacity",           limit: 8
      t.text     "info"
      t.boolean  "active_flag",                                             default: true, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.date     "scod"
      t.date     "cod"
      t.decimal  "latitude",                       precision: 10, scale: 6
      t.decimal  "longitude",                      precision: 10, scale: 6
      t.integer  "billing_cycle",                                           default: 16
      t.integer  "installed_capacity", limit: 8
      t.string   "flash_test_file"
      t.decimal  "fit_rate",                       precision: 5,  scale: 2
      t.string   "gps_key",            limit: 50
      t.integer  "system_type_id"
    end

    add_index "projects", ["logger_no"], name: "index_projects_on_logger_no", unique: true, using: :btree

    create_table "provinces", force: :cascade do |t|
      t.string   "caption",     limit: 200, default: "",   null: false
      t.string   "caption_en",  limit: 200, default: ""
      t.boolean  "active_flag",             default: true, null: false
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
    end

    add_index "provinces", ["caption"], name: "index_provinces_on_caption", unique: true, using: :btree

    create_table "pv_modules", force: :cascade do |t|
      t.integer  "project_id"
      t.string   "serial_no",   limit: 30,                                        null: false
      t.decimal  "pmax",                   precision: 5, scale: 1
      t.decimal  "voc",                    precision: 5, scale: 2
      t.decimal  "isc",                    precision: 5, scale: 3
      t.decimal  "vpm",                    precision: 5, scale: 2
      t.decimal  "ipm",                    precision: 5, scale: 3
      t.boolean  "active_flag",                                    default: true, null: false
      t.datetime "created_at",                                                    null: false
      t.datetime "updated_at",                                                    null: false
    end

    create_table "pv_strings", force: :cascade do |t|
      t.integer  "node_id"
      t.integer  "order_num"
      t.string   "name"
      t.integer  "cable_type_id"
      t.float    "cable_length"
      t.datetime "created_at",    null: false
      t.datetime "updated_at",    null: false
    end

    create_table "system_types", force: :cascade do |t|
      t.string   "caption",       limit: 100, null: false
      t.string   "icon_filename", limit: 100
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
    end

    create_table "users", force: :cascade do |t|
      t.string   "username",                           default: "",    null: false
      t.string   "email",                              default: "",    null: false
      t.string   "encrypted_password",                 default: "",    null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",                      default: 0,     null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet     "current_sign_in_ip"
      t.inet     "last_sign_in_ip"
      t.string   "firstname",              limit: 100, default: "",    null: false
      t.string   "lastname",               limit: 100
      t.boolean  "admin_flag",                         default: false, null: false
      t.boolean  "active_flag",                        default: true,  null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "customer_id"
    end

    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

    create_table "users_customers", id: false, force: :cascade do |t|
      t.integer  "user_id"
      t.integer  "customer_id"
      t.string   "role_type",   limit: 1, default: "",   null: false
      t.boolean  "active_flag",           default: true, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "users_customers", ["user_id", "customer_id"], name: "index_users_customers_on_user_id_and_customer_id", unique: true, using: :btree

    create_table "users_projects", id: false, force: :cascade do |t|
      t.integer  "user_id",                                  null: false
      t.integer  "project_id",                               null: false
      t.string   "permission_type", limit: 1, default: "",   null: false
      t.boolean  "active_flag",               default: true, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "role_type",       limit: 1, default: "",   null: false
    end

    add_index "users_projects", ["user_id", "project_id"], name: "index_users_projects_on_user_id_and_project_id", unique: true, using: :btree
    
    
  end
end
