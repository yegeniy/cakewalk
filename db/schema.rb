# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100614192252) do

  create_table "edges", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.string   "direction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "point_id"
    t.integer  "to_point_id"
  end

  create_table "markers", :force => true do |t|
    t.decimal "lat"
    t.decimal "lng"
    t.string  "found", :limit => 100
    t.string  "left",  :limit => 100
  end

  create_table "points", :force => true do |t|
    t.string "name",     :limit => 50
    t.string "address",  :limit => 100
    t.string "address2", :limit => 100
    t.string "city",     :limit => 50
    t.string "state",    :limit => 20
    t.string "zip",      :limit => 9
    t.string "lat",      :limit => 20
    t.string "lng",      :limit => 20
  end

end
