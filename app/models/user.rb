class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_validation { email.downcase! }
    validates :name, length:{ in: 1..30 }
    validates :email, length:{ in: 1..255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: true
    validates :admin, presence: true
  has_secure_password
  validates :password, length: { minimum: 6 }
end