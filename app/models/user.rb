class User < ApplicationRecord
  has_secure_password
  has_many :jokes
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}
  
  
end
