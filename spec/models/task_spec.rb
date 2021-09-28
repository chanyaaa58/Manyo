require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  before do
    @user = FactoryBot.create(:basic_user)
  end
  describe 'バリデーションのテスト' do
    context 'listが空欄の場合' do
      it 'バリデーションが通らない' do
        task = Task.new(list: '', detail: '失敗テスト', user: @user)
        expect(task).not_to be_valid
      end
    end

    context 'detailが空欄の場合' do
      it 'バリデーションが通らない' do
        task = Task.new(list: '失敗テスト', detail: '', user: @user)
        expect(task).not_to be_valid
      end
    end

    context 'listとdetailに内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(list: '成功テスト', detail: '成功テスト', user: @user)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    #　テストをやる前にやっておきたいことを定義しておく
    # taskという変数に対して、FactoryBotのテンプレートで定義したDBの登録情報を格納することができる
    let!(:task) { FactoryBot.create(:task, list: 'task', user: @user) }
    let!(:second_task) { FactoryBot.create(:second_task, list: "sample", user: @user) }

    context 'scopeメソッドでタスク名のあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search_by_list('task')).to include(task)
        expect(Task.search_by_list('task')).not_to include(second_task)
        expect(Task.search_by_list('task').count).to eq 1
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_by_status('完了')).to include(task)
        expect(Task.search_by_status('完了')).not_to include(second_task)
        expect(Task.search_by_status('完了').count).to eq 1
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_by_list('task')).to include(task)
        expect(Task.search_by_status('完了')).not_to include(second_task)
        expect(Task.search_by_list('task').count).to eq 1
      end
    end
  end
end