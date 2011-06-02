class Paper < ActiveRecord::Base
  self.primary_key = :paper_id

  has_many :outgoing_citations, :class_name => 'Citation', :foreign_key => :citing_paper_id
  has_many :incoming_citations, :class_name => 'Citation', :foreign_key => :cited_paper_id
  has_many :cited_papers, :class_name => 'Paper', :through => :outgoing_citations
  has_many :citing_papers, :class_name => 'Paper', :through => :incoming_citations
  has_many :contributions, :dependent => :destroy
  has_many :authors, :through => :contributions, :order => 'contributions.position'

  validates_length_of :title, :minimum => 10
  validates_length_of :abstract, :minimum => 50
  validates_format_of :year, :with => /\A(19|20)\d\d\z/, :if => 'year.present?'
end
