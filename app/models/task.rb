class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings, source: :label
  with_options presence: true do
    validates :list, length:{ in: 1..30 }
    validates :detail, length:{ in: 1..100 }
  end
    enum status: {未着手: 0, 着手中: 1, 完了: 2}
    enum priority: { 高: 0, 中: 1, 低: 2 }

    #タイトルとステータス掛け合わせの検索の場合のscopeはなくてもok
    # scope :search_by_list_and_status, -> { where('list LIKE ?', "%#{params[:list]}%").where(status: params[:status])} 
    #タイトルのあいまい検索だけの場合のscope
    scope :search_by_list, -> (list) { where('list LIKE ?', "%#{ list }%") }
    #ステータス検索のだけの場合のscope
    scope :search_by_status, -> (status) { where(status: status) }
end