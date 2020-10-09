class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  before_destroy :check_last_update_admin
  before_update :check_last_update_admin
  before_destroy :check_can_destroy_admin
  before_update :check_can_change_admin

  private
  def check_last_update_admin
    if self.admin? && User.where(admin: "true").count == 1
      # return false　ではなく throw :abort
      throw :abort
    end
  end
  def check_can_change_admin
    if User.where(admin: true).count == 1 && self.admin_change == [true, false]
      errors.add :base, '管理者が一人以上必要なため、権限の変更はできません'
      throw(:abord)
    #   throw :abort if User.where(admin: true).count == 1 && admin == false
    end
  end
end
