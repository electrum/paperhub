class CreatePapers < ActiveRecord::Migration
  def self.up
    create_table :papers, :primary_key => :paper_id do |t|
      t.string :title, :limit => 250, :null => false
      t.text :abstract
      t.text :keywords
      t.integer :year
      t.integer :month
      t.timestamps
    end

    create_table :authors, :primary_key => :author_id do |t|
      t.string :name, :limit => 100, :null => false
      t.timestamps
    end

    create_table :contributions, :primary_key => :contribution_id do |t|
      t.integer :paper_id, :null => false
      t.integer :author_id, :null => false
      t.integer :position, :null => false
      t.string :organization, :limit => 100
      t.string :email, :limit => 100
      t.timestamps
    end
    add_index :contributions, [:paper_id, :author_id], :unique => true, :name => 'contributions_pk'
    add_index :contributions, [:paper_id, :position], :unique => true, :name => 'contributions_position_uniq'
    add_foreign_key :contributions, :papers, :primary_key => :paper_id
    add_foreign_key :contributions, :authors, :primary_key => :author_id

    create_table :citations, :primary_key => :citation_id do |t|
      t.integer :citing_paper_id, :null => false
      t.integer :cited_paper_id, :null => false
      t.text :reference
      t.timestamps
    end
    add_index :citations, [:cited_paper_id, :cited_paper_id], :unique => true, :name => 'citations_pk'
    add_foreign_key :citations, :papers, :column => :citing_paper_id, :primary_key => :paper_id
    add_foreign_key :citations, :papers, :column => :cited_paper_id, :primary_key => :paper_id

    create_table :sources, :primary_key => :source_id do |t|
      t.integer :paper_id, :null => false
      t.string :type, :limit => 10
      t.string :url, :limit => 250
      t.string :md5, :limit => 32
      t.integer :size
      t.timestamps
    end
    add_foreign_key :sources, :papers, :primary_key => :paper_id
  end

  def self.down
    drop_table :sources
    drop_table :citations
    drop_table :contributions
    drop_table :authors
    drop_table :papers
  end
end
