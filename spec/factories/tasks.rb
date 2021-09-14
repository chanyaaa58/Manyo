FactoryBot.define do
    factory :task do
      list { 'test_list' }
      detail { 'test_detail' }
    end
    factory :second_task, class: Task do
        list { 'test_list2' }
        detail { 'test_detail2' }
    end
  end