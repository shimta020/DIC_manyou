class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: {minimum: 6}, on: :create

  has_secure_password

  before_destroy :alert_at_delete_last_admin
  before_update :alert_at_update_last_admin

  has_many :tasks, dependent: :destroy

  def alert_at_delete_last_admin
    if self.admin? && User.where(admin: :true).count == 1
      errors.add(:base, "最低1ユーザーは管理者権限を持つ必要があります。")
      throw :abort
    end
  end
  def alert_at_update_last_admin
    if self.admin == false && User.where(admin: :true).count == 1
      errors.add(:base, "最低1ユーザーは管理者権限を持つ必要があります。")
      throw :abort
    end
  end
end
