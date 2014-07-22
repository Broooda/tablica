
  enable_extension "plpgsql"


  create_table "holidays", force: true do |t|
    t.datetime "StartDate"
    t.datetime "EndDate"
    t.text     "Description"
    t.string   "Status"
    t.text     "Reason"

  create_table "default_work_times", force: true do |t|
    t.string "week", default: [], array: true
  end


  create_table "holidays", force: true do |t|
    t.datetime "startdate"
    t.datetime "enddate"
    t.text     "description"
    t.string   "status"
    t.text     "reason"

    t.datetime "created_at"
    t.datetime "updated_at"
  end




  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"

    t.string   "name"
    t.string   "surname"
    t.integer  "default_work_time_id"
    t.boolean  "admin"

  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree


end
