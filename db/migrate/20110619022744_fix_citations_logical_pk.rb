class FixCitationsLogicalPk < ActiveRecord::Migration
  def self.up
    remove_index :citations, :name => :citations_pk_uniq
    add_index :citations, [:citing_paper_id, :cited_paper_id], :unique => true, :name => :citations_pk_uniq
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
