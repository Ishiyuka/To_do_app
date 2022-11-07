class User < ApplicationRecord
  before_destroy :admin_exist_check
  before_update :admin_update_exist
  before_validation { email.downcase! }
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_many :tasks, dependent: :destroy

  private

  def admin_exist_check
    if User.where(admin:true).count == 1 && self.admin == true
    throw(:abort)
    end
  end

  def admin_update_exist
    if User.where(admin: true).count == 1 && self.admin == false
    throw(:abort)
    end
  end
end
