require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
  # タスクをbeforeで先に作っておく
  before do
    FactoryBot.create(:task, list: 'test_list')
    FactoryBot.create(:second_task, list: 'test_list2')
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
       # 1.new_task_pathに遷移する（新規作成ページに遷移する）
         visit new_task_path
         # 2.新規登録内容を入力する
         #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクリストと詳細をそれぞれ入力する
         #「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
         #「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
         fill_in 'task[list]', with: 'test_list'
         fill_in 'task[detail]', with: 'test_detail'

         # step3追加条件
         # 終了期限の設定において、プルダウン選択式の為、fill_in '', withではなく、select '', fromを使う
         select '2021', from: 'task_expired_at_1i'
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
         expect(page).to have_content 'test_list'
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
        visit tasks_path
        expect(page).to have_content 'test_list'
        expect(page).to have_content 'test_list2'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    # step2追加テスト
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_list2'
        expect(task_list[1]).to have_content 'test_list'
      end
    end
    # step3追加テスト
    context ' 終了期限でソートするというリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        visit tasks_path
        click_on '終了期限で並び替え'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '2021/09/25'
        expect(task_list[1]).to have_content '2021/09/22'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
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
        visit tasks_path
        select "完了", from: 'status'
        click_button '検索'
        expect(page).to have_content '完了'
      end
    end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索ワードをタスク名に含み、かつステータスと完全一致するタスクでソートされる" do
        visit tasks_path
        fill_in "list", with: 'test'
        select "完了", from: 'status'
        click_button '検索'
        expect(page).to have_content 'test'
        expect(page).to have_content '完了'
      end
    end
  end
end