class User < ApplicationRecord
  has_secure_password 
  after_create -> { Rails.logger.info("New User created!") }
  before_save { self.email = email.downcase }


  validates :name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,uniqueness: { case_sensitive: false },length: { maximum: 105 },format: { with: VALID_EMAIL_REGEX }


end
