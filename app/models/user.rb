require 'bcrypt'

class User < ActiveRecord::Base
  self.primary_key = :user_id

  has_many :bookmarks

  attr_reader :password

  validates_length_of :password, :in => 6..20, :if => :new_or_password_changed?
  validates_confirmation_of :password
  validates_presence_of :password_digest
  validates_presence_of :password_confirmation, :if => :new_or_password_changed?

  validates_length_of :username, :in => 3..20
  validates_format_of :username, :with => /\A[a-z][a-z0-9]+\z/
  validates_uniqueness_of :username

  validates_length_of :email, :maximum => 100
  validates_format_of :email, :with => /\A([^@\s]+)@(([-a-z0-9]+\.)+[a-z]{2,})\z/i

  def new_or_password_changed?
    new_record? || password_digest_changed?
  end

  # Returns self if the password is correct, otherwise false.
  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password ? self : false
  end

  # Encrypts the password into the password_digest attribute.
  def password=(unencrypted_password)
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(unencrypted_password)
  end

  def self.authenticate(username, unencrypted_password)
    user = find_by_username(username)
    user && user.authenticate(unencrypted_password)
  end

  def bookmarked_paper?(paper)
    bookmarks.where(:paper_id => paper.id).exists?
  end

  def to_param
    username
  end
end
