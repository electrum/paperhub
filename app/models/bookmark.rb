class Bookmark < ActiveRecord::Base
  set_primary_key :bookmark_id

  belongs_to :user
  belongs_to :paper
end
