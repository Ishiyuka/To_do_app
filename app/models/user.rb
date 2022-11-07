class User < ApplicationRecord
  before_validation { email.downcase! }
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_many :tasks, dependent: :destroy
end
