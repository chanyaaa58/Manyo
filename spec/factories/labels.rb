FactoryBot.define do
  # 作成するテストデータ1つ目は「label」
  factory :label, class: Label do
    name { 'test_label' }
  end
  # 作成するテストデータ1つ目は「second_label」
  factory :second_label, class: Label do
    name { 'test_label2' }
  end
end