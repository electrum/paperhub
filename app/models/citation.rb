class Citation < ActiveRecord::Base
  set_primary_key :citation_id

  belongs_to :citing_paper, :class_name => 'Paper'
  belongs_to :cited_paper, :class_name => 'Paper'
end
