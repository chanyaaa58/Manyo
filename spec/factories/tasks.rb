FactoryBot.define do
  # 作成するテストデータ1つ目は「task」
  factory :task do
    list { 'test_list' }
    detail { 'test_detail' }
    expired_at { '2021/09/22' }
    status { '完了' }
    priority {'高'}
  end
  # 作成するテストデータ2つ目は「second_task」
  factory :second_task, class: Task do
    list { 'test_list2' }
    detail { 'test_detail2' }
    expired_at { '2021/09/25' }
    status { '未着手' }
    priority {'中'}
  end
end