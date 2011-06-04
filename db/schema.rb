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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110604001837) do

  create_table "authors", :primary_key => "author_id", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookmarks", :primary_key => "bookmark_id", :force => true do |t|
    t.integer  "user_id"
    t.integer  "paper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["user_id", "paper_id"], :name => "bookmarks_pk", :unique => true

  create_table "citations", :primary_key => "citation_id", :force => true do |t|
    t.integer  "citing_paper_id", :null => false
    t.integer  "cited_paper_id",  :null => false
    t.text     "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "citations", ["cited_paper_id", "cited_paper_id"], :name => "citations_pk", :unique => true

  create_table "contributions", :primary_key => "contribution_id", :force => true do |t|
    t.integer  "paper_id",                    :null => false
    t.integer  "author_id",                   :null => false
    t.integer  "position",                    :null => false
    t.string   "organization", :limit => 100
    t.string   "email",        :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contributions", ["paper_id", "author_id"], :name => "contributions_pk", :unique => true
  add_index "contributions", ["paper_id", "position"], :name => "contributions_position_uniq", :unique => true

  create_table "papers", :primary_key => "paper_id", :force => true do |t|
    t.string   "title",      :limit => 250, :null => false
    t.text     "abstract"
    t.text     "keywords"
    t.integer  "year"
    t.integer  "month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :primary_key => "source_id", :force => true do |t|
    t.integer  "paper_id",                  :null => false
    t.string   "type",       :limit => 10
    t.string   "url",        :limit => 250
    t.string   "md5",        :limit => 32
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :primary_key => "user_id", :force => true do |t|
    t.string   "username",        :limit => 20,  :null => false
    t.string   "password_digest", :limit => 100, :null => false
    t.string   "email",           :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "bookmarks", "papers", :name => "bookmarks_paper_id_fk", :primary_key => "paper_id"
  add_foreign_key "bookmarks", "users", :name => "bookmarks_user_id_fk", :primary_key => "user_id"

  add_foreign_key "citations", "papers", :name => "citations_cited_paper_id_fk", :column => "cited_paper_id", :primary_key => "paper_id"
  add_foreign_key "citations", "papers", :name => "citations_citing_paper_id_fk", :column => "citing_paper_id", :primary_key => "paper_id"

  add_foreign_key "contributions", "authors", :name => "contributions_author_id_fk", :primary_key => "author_id"
  add_foreign_key "contributions", "papers", :name => "contributions_paper_id_fk", :primary_key => "paper_id"

  add_foreign_key "sources", "papers", :name => "sources_paper_id_fk", :primary_key => "paper_id"

end
