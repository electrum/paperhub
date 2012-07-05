class Citation < ActiveRecord::Base
  self.primary_key = :citation_id

  belongs_to :citing_paper, :class_name => 'Paper'
  belongs_to :cited_paper, :class_name => 'Paper'
end
