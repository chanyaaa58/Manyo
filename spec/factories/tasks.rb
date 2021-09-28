FactoryBot.define do
  # 作成するテストデータ1つ目は「task」
  factory :task do
    list { 'test_list' }
    detail { 'test_detail' }
    expired_at { DateTime.now + 5 }
    status { '完了' }
    priority {'高'}
    # association :basic_user
  end
  # 作成するテストデータ2つ目は「second_task」
  factory :second_task, class: Task do
    list { 'test_list2' }
    detail { 'test_detail2' }
    expired_at { DateTime.now + 10 }
    status { '未着手' }
    priority {'中'}
    # association :admin_user
  end
end