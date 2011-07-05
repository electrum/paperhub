class RenameSourceType < ActiveRecord::Migration
  def self.up
    rename_column :sources, :type, :filetype
  end

  def self.down
    rename_column :sources, :filetype, :type
  end
end
