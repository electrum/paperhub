class Contribution < ActiveRecord::Base
  self.primary_key = :contribution_id

  belongs_to :paper
  belongs_to :author
end
