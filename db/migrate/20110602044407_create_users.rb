class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :primary_key => :user_id do |t|
      t.string :username, :limit => 20, :null => false
      t.string :password_digest, :limit => 100, :null => false
      t.string :email, :limit => 100, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
