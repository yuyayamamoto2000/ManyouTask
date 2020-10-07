class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  before_destroy :check_last_update_admin
  before_update :check_last_update_admin

  private
  def check_last_update_admin
    if self.admin? && User.all.where(admin: "true").count == 1
      # return false　ではなく throw :abort
      throw :abort
    end
  end
end
