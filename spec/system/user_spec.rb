require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do

  def login
    visit new_session_path
    #basic_userのemailとパスワードを入力して
    fill_in 'session[email]', with: 'basic@mail.jp'
    fill_in 'session[password]', with:'555555'
    #ログインボタンを押したらログインできるか確認
    click_button 'Log in'
  end

  def login_admin
    visit new_session_path
    #admin_userのemailとパスワードを入力して
    fill_in 'session[email]', with: 'admin@mail.jp'
    fill_in 'session[password]', with:'444444'
    #ログインボタンを押したらログインできるか確認
    click_button 'Log in'
  end

  describe '​ユーザ登録のテスト​' do
    context '​ユーザのデータがなくログインしていない場合​' do
      it '​ユーザー新規登録ができる​' do
        visit new_user_path
        fill_in 'user[name]', with: 'basic_name'
        fill_in 'user[email]', with: 'basic@mail.jp'
        fill_in 'user[password]', with: '555555'
        fill_in 'user[password_confirmation]', with: '555555'
        click_button '登録'
        expect(page).to have_content 'basic@mail.jp'
      end

      it '​ログインしていない時はログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '​セッション機能のテスト​' do
    before do
      @basic_user = FactoryBot.create(:basic_user)
    end

    context 'ユーザーのデータがあってログインしていない場合' do
      it 'ログインができる' do
        visit new_session_path
        fill_in 'session[email]', with: 'basic@mail.jp'
        fill_in 'session[password]', with:'555555'
        click_button 'Log in'
        expect(current_path).to eq user_path(id: @basic_user.id)
      end
    end

    context "ユーザーのデータがあってログインしている場合" do
      it '自分の詳細画面(マイページ)に飛べる' do
        login
        visit user_path(id: @basic_user.id)
        expect(current_path).to eq user_path(id: @basic_user.id)
      end

      it '一般ユーザーが他人の詳細画面に飛ぶとタスク一覧ページに遷移する' do
        login
        @admin_user = FactoryBot.create(:admin_user)
        visit user_path(id: @admin_user.id)
        expect(page).to have_content "権限がありません"
      end

      it 'ログアウトができる' do
        login
        visit user_path(id: @basic_user.id)
        click_on 'ログアウト'
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe '​管理画面のテスト​' do
    before do
      @basic_user = FactoryBot.create(:basic_user)
      @admin_user = FactoryBot.create(:admin_user)
    end

    context '一般ユーザーでログインしている場合' do
      it '管理画面にアクセスできない' do
        login
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセスできません"
      end
    end

    context '管理者権限でログインしている場合' do
      before do
        login_admin
      end

      it '管理画面にアクセスできる' do
        visit admin_users_path
        expect(page).to have_content "Manyoユーザー一覧"
      end

      it '管理ユーザーはユーザーの新規登録ができる' do
        visit admin_users_path
        click_on '新規ユーザー登録'
        fill_in 'user[name]', with: 'basic_name'
        fill_in 'user[email]', with: 'basic@mail.jp'
        fill_in 'user[password]', with:'555555'
        fill_in 'user[password_confirmation]', with:'555555'
        click_button '登録'
        visit admin_users_path
        expect(page).to have_content 'basic_name'
      end

      it '管理ユーザーはユーザの詳細画面にアクセスできる' do
        visit admin_users_path
        click_on '詳細', match: :first
        expect(current_path).to eq admin_user_path(id: @basic_user.id)
      end

      it '管理ユーザはユーザの編集画面からユーザを編集できる' do
        visit edit_admin_user_path(id: @basic_user.id)
        fill_in 'user[name]', with: 'sample_name'
        fill_in 'user[email]', with: 'sample@mail.jp'
        fill_in 'user[password]', with:'666666'
        fill_in 'user[password_confirmation]', with:'666666'
        click_button '更新'
        expect(page).to have_content 'sample_name'
      end

      it '管理ユーザはユーザの削除をできること' do
        visit admin_users_path
        sleep 0.3
        page.accept_confirm do
          click_on '削除', match: :first
        end
        expect(page).to have_content 'admin_name'
        expect(current_path).to_not have_content 'basic_name'
      end
    end
  end
end