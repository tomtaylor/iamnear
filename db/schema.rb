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

ActiveRecord::Schema.define(:version => 20090307145011) do

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "image_url"
    t.string   "publisher"
    t.decimal  "latitude",   :precision => 20, :scale => 17
    t.decimal  "longitude",  :precision => 20, :scale => 17
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospitals", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.decimal  "latitude",   :precision => 20, :scale => 17
    t.decimal  "longitude",  :precision => 20, :scale => 17
    t.boolean  "emergency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "megaliths", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.decimal  "latitude",   :precision => 20, :scale => 17
    t.decimal  "longitude",  :precision => 20, :scale => 17
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_offices", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.decimal  "latitude",   :precision => 20, :scale => 17
    t.decimal  "longitude",  :precision => 20, :scale => 17
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pubs", :force => true do |t|
    t.string   "name"
    t.decimal  "latitude",   :precision => 20, :scale => 17
    t.decimal  "longitude",  :precision => 20, :scale => 17
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rocket_strikes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "latitude",    :precision => 20, :scale => 17
    t.decimal  "longitude",   :precision => 20, :scale => 17
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "swimming_pools", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "latitude",    :precision => 20, :scale => 17
    t.decimal  "longitude",   :precision => 20, :scale => 17
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end