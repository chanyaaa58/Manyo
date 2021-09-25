class User < ApplicationRecord
  before_validation { email.downcase! }
    validates :name, length:{ in: 1..30 }
    validates :email, length:{ in: 1..255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 6 }
end