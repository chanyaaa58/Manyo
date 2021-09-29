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
    # if User.where(admin: true).count == 1 && self.admin == false
    @admin_users = User.where(admin: true)
    # 権限持っている人は複数いるかも。今ログインしている人は一番上ではないかも
    if (@admin_users.count == 1 && @admin_users.first == self) && self.admin == false
      #errors.add バリデーションメッセージの役割
      errors.add :base, "管理者が一人も居ない状態にはできません！"
      throw :abort
    end
  end
end