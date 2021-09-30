User.create!(name: "管理者1",
            email: "admin@example.jp",
            password: "test01",
            password_confirmation: "test01",
            admin: true)

User.create!(name: "管理者2",
            email: "admin2@example.jp",
            password: "test02",
            password_confirmation: "test02",
            admin: true)

User.create!(name: "一般ユーザー1",
            email: "user1@example.jp",
            password: "test03",
            password_confirmation: "test03",
            admin: false)

User.create!(name: "一般ユーザー2",
            email: "user2@example.jp",
            password: "test04",
            password_confirmation: "test04",
            admin: false)

User.create!(name: "一般ユーザー3",
            email: "user3@example.jp",
            password: "test05",
            password_confirmation: "test05",
            admin: false)

User.create!(name: "一般ユーザー4",
            email: "user4@example.jp",
            password: "test06",
            password_confirmation: "test06",
            admin: false)

User.create!(name: "一般ユーザー5",
            email: "user5@example.jp",
            password: "test07",
            password_confirmation: "test07",
            admin: false)

User.create!(name: "一般ユーザー6",
            email: "user6@example.jp",
            password: "test08",
            password_confirmation: "test08",
            admin: false)

User.create!(name: "一般ユーザー7",
            email: "user7@example.jp",
            password: "test09",
            password_confirmation: "test09",
            admin: false)

User.create!(name: "一般ユーザー8",
            email: "user8@example.jp",
            password: "test10",
            password_confirmation: "test10",
            admin: false)


Label.create!(name: 'そら')

Label.create!(name: 'パパ')

Label.create!(name: 'ママ')

Label.create!(name: 'たこちゃん')

Label.create!(name: 'けいちゃん')

Label.create!(name: 'よこちゃん')

Label.create!(name: '勉強')

Label.create!(name: '趣味')

Label.create!(name: '仕事')

Label.create!(name: 'その他')