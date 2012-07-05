class Bookmark < ActiveRecord::Base
  self.primary_key = :bookmark_id

  belongs_to :user
  belongs_to :paper
end
