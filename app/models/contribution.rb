class Contribution < ActiveRecord::Base
  set_primary_key :contribution_id

  belongs_to :paper
  belongs_to :author
end
