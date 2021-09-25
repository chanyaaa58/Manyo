class User < ApplicationRecord
  before_validation { email.downcase! }
  with_options presence: true do
    validates :name, length:{ in: 1..30 }
    validates :email, length:{ in: 1..255 }
  end
  validates :email,format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end