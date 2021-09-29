FactoryBot.define do
# 作成するテストデータ1つ目は「admin_user」
  factory :admin_user, class: User do
    name { 'admin_name' }
    email { 'admin@mail.jp' }
    password { '444444' }
    password_confirmation { '444444' }
    admin {true}
  end
# 作成するテストデータ2つ目は「basic_user」
  factory :basic_user, class: User do
    name { 'basic_name' }
    email { 'basic@mail.jp' }
    password { '555555' }
    password_confirmation { '555555' }
#   admin {false}
  end
end