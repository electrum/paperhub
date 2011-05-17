class Source < ActiveRecord::Base
  self.primary_key = :source_id

  belongs_to :paper
end
