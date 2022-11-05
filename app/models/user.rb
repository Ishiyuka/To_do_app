class User < ApplicationRecord
  before_validation { email.downcase! }
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :tasks
end
