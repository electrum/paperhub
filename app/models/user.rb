class User < ActiveRecord::Base
  self.primary_key = :user_id

  has_many :bookmarks

  has_secure_password

  validates_length_of :password, :in => 6..20, :if => :new_or_password_changed?
  validates_presence_of :password_confirmation, :if => :new_or_password_changed?

  validates_length_of :username, :in => 3..20
  validates_format_of :username, :with => /\A[a-z][a-z0-9]+\z/
  validates_uniqueness_of :username

  validates_length_of :email, :maximum => 100
  validates_format_of :email, :with => /\A([^@\s]+)@(([-a-z0-9]+\.)+[a-z]{2,})\z/i

  def new_or_password_changed?
    new_record? || password_digest_changed?
  end

  def self.authenticate(username, unencrypted_password)
    find_by_username(username).try(:authenticate, unencrypted_password)
  end

  def bookmarked_paper?(paper)
    bookmarks.where(:paper_id => paper.id).exists?
  end

  def to_param
    username
  end
end
