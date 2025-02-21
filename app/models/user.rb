class User < ApplicationRecord
  has_secure_password

  has_many :pictures

  validates :login_id,        presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
end
