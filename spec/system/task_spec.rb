require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
  # タスクをbeforeで先に作っておく

  def login
    visit new_session_path
    #basic_userのemailとパスワードを入力して
    fill_in 'session[email]', with: 'basic@mail.jp'
    fill_in 'session[password]', with:'555555'
    # fill_in 'session[email]', with: 'basic@mail.jp'
    # fill_in 'session[password]', with: '555555'
    #ログインボタンを押したらログインできるか確認
    click_button 'Log in'
  end

  before do
    @basic_user = FactoryBot.create(:basic_user)
    @admin_user = FactoryBot.create(:admin_user)
    FactoryBot.create(:task, user: @basic_user)
    FactoryBot.create(:second_task,  user: @admin_user)
    #dbの中にadmin_userを作成
    # FactoryBot.create(:admin_user, name: 'admin_name')
    #dbの中にbasic_userを作成
    # FactoryBot.create(:basic_user, name: 'basic_name')
    #Taskをdbの中に2つ作成
    # FactoryBot.create(:task, user: basic_user, list: 'test_list')
    # FactoryBot.create(:second_task, user: basic_user, list: 'test_list2')
    #ログイン画面に遷移できるか確認
  end

  #ログインしている状態からテストを開始
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
       # 1.new_task_pathに遷移する（新規作成ページに遷移する）
       login
        visit new_task_path
        # 2.新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクリストと詳細をそれぞれ入力する
        #「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        #「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task[list]', with: 'お手洗い'
        fill_in 'task[detail]', with: 'test_detail'

        # step3追加条件
        # 終了期限の設定において、プルダウン選択式の為、fill_in '', withではなく、select '', fromを使う
        select '2022', from: 'task_expired_at_1i'
        select '9', from: 'task_expired_at_2i'
        select '22', from: 'task_expired_at_3i'
      #  select '20', from: 'task_expired_at_4i'
      #  select '00', from: 'task_expired_at_5i'
        select '完了', from: 'task_status'
        select '高', from: 'task_priority'
        # 3.「登録」というvalue（表記文字）のあるボタンをクリックする
        #「登録」というvalue（表記文字）のあるボタンをclickする処理を書く
        click_button '登録'
        # 4.clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたら、ユーザーはタスク詳細画面を見に行くだろうという想定）
        # タスク詳細ページに、テストコードで作成したデータがタスク（test_list）が詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'お手洗い'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        # task = FactoryBot.create(:task, list: 'task')
        # タスク一覧ページ（index）に遷移
        # visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        login
        visit tasks_path
        expect(page).to have_content 'test_list'
        # expect(page).to have_content 'test_list2'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    # step2追加テスト
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        login
        FactoryBot.create(:second_task, user: @basic_user)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_list'
        expect(task_list[1]).to have_content 'test_list2'
      end
    end
    # step3追加テスト
    context ' 終了期限でソートするというリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        login
        FactoryBot.create(:second_task, user: @basic_user)
        visit tasks_path
        click_on '終了期限で並び替え'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_list2'
        expect(task_list[1]).to have_content 'test_list'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        login
        task = FactoryBot.create(:task, user: @basic_user)
        # task = FactoryBot.create(:second_task)
        visit task_path(task.id)
        expect(page).to have_content 'test_list'
      end
    end
  end
  # step3追加テスト
  describe '検索機能' do
    context 'タスク名であいまい検索をした場合' do
      it "検索ワードを含むタスク名でソートされる" do
        login
        visit tasks_path
        # タスク名の一部「test」という文字列をfill_in（入力）する処理を書く
        # 'list'はタスク登録画面のtext_field名（検証ツール参照）
        fill_in 'list', with: 'test'
        click_button '検索'
        expect(page).to have_content 'test'
      end
    end

    context 'ステータス検索をした場合' do
      it "ステータス「未着手」「着手中」「完了」の内、完全一致するタスクでソートされる" do
        login
        visit tasks_path
        select "完了", from: 'status'
        click_button '検索'
        expect(page).to have_content '完了'
      end
    end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索ワードをタスク名に含み、かつステータスと完全一致するタスクでソートされる" do
        login
        visit tasks_path
        fill_in "list", with: 'test'
        select "完了", from: 'status'
        click_button '検索'
        expect(page).to have_content 'test'
        expect(page).to have_content '完了'
      end
    end

    context '優先順位が高い順で並び替えというリンクを押した場合' do
      it '優先順位が高い順に並んでいる' do
        login
        FactoryBot.create(:second_task, user: @basic_user)
        visit tasks_path
        click_on '優先順位が高い順で並び替え'
        # binding.irb
        sleep 0.3
        task_list = all('.task_priority')
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
      end
    end
  end
end