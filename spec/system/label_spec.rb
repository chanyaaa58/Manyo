require 'rails_helper'

RSpec.describe 'ラベル管理機能', type: :system do

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
    @label = FactoryBot.create(:label)
    @second_label = FactoryBot.create(:second_label)
    FactoryBot.create(:task, user: @basic_user)
    FactoryBot.create(:second_task,  user: @admin_user)
  end

  describe 'ラベル追加機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクにラベルを付けられる' do
        login
        visit new_task_path
        fill_in 'task[list]', with: 'test_list'
        fill_in 'task[detail]', with: 'test_detail'
        select '2022', from: 'task_expired_at_1i'
        select '9', from: 'task_expired_at_2i'
        select '30', from: 'task_expired_at_3i'
        select '完了', from: 'task_status'
        select '高', from: 'task_priority'
        check "task_label_ids_#{(@label.id)}"
        check "task_label_ids_#{(@second_label.id)}"
        click_button '登録'
        # タスク一覧ページに、今作成したタスクの2つのラベルが一覧画面に戻ってきた時にhave_contentされているか（含まれているか）を確認（期待）
        expect(page).to have_content 'test_label'
        expect(page).to have_content 'test_label2'
      end
    end
  end

  describe 'ラベル検索機能' do
    context 'ラベルで検索した場合' do
      it '検索したラベルが紐づいているタスクが表示される' do
        login
        visit tasks_path
        select 'test_label', from: 'label_id'
        click_button '検索'
        expect(page).to have_content 'test_label'
      end
    end
  end
end

