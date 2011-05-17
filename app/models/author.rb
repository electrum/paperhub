class Author < ActiveRecord::Base
  self.primary_key = :author_id

  has_many :contributions
  has_many :papers, :through => :contributions
end
