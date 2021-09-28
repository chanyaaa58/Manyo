class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  before_destroy :destroy_action
  before_update :update_action

  before_validation { email.downcase! }
    validates :name, length:{ in: 1..30 }
    validates :email, length:{ in: 1..255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 6 }

  private
  def destroy_action
    if User.where(admin: true).count == 1 && self.admin
      throw :abort
    end
  end

  def update_action
    if User.where(admin: true).count == 1 && user.present? && self.admin == false
      throw :abort
    end
  end
end