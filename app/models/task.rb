class Task < ApplicationRecord
  with_options presence: true do
    validates :list, length:{ in: 1..30 }
    validates :detail, length:{ in: 1..100 }
  end
end