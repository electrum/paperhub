class RenameLogicalPk < ActiveRecord::Migration
  def self.up
    rename_index :bookmarks_pk, :bookmarks_pk_uniq
    rename_index :citations_pk, :citations_pk_uniq
    rename_index :contributions_pk, :contributions_pk_uniq
  end

  def self.down
    rename_index :bookmarks_pk_uniq, :bookmarks_pk
    rename_index :citations_pk_uniq, :citations_pk
    rename_index :contributions_pk_uniq, :contributions_pk
  end

  def self.rename_index(old_name, new_name)
    execute "ALTER INDEX #{old_name} RENAME TO #{new_name}"
  end
end
