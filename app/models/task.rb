class Task < ApplicationRecord
  with_options presence: true do
    validates :list, length:{ in: 1..30 }
    validates :detail, length:{ in: 1..100 }
  end
    enum priority: { 高: 0, 中: 1, 低: 2 }

end