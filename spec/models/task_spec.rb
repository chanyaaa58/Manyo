require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'listが空欄の場合' do
      it 'バリデーションが通らない' do
        task = Task.new(list: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end

    context 'detailが空欄の場合' do
      it 'バリデーションが通らない' do
        task = Task.new(list: '失敗テスト', detail: '')
        expect(task).not_to be_valid
      end
    end

    context 'listとdetailに内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(list: '成功テスト', detail: '成功テスト')
        expect(task).to be_valid
      end
    end
  end
end