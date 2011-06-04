class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks, :primary_key => :bookmark_id do |t|
      t.integer :user_id
      t.integer :paper_id
      t.timestamps
    end
    add_index :bookmarks, [:user_id, :paper_id], :unique => true, :name => 'bookmarks_pk'
    add_foreign_key :bookmarks, :users, :primary_key => :user_id
    add_foreign_key :bookmarks, :papers, :primary_key => :paper_id
  end

  def self.down
    drop_table :bookmarks
  end
end
