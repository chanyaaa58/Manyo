require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  it 'listが空ならバリデーションが通らない' do
    task = Task.new(list: '', detail: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'detailが空ならバリデーションが通らない' do
    task = Task.new(list: '失敗テスト', detail: '')
    expect(task).not_to be_valid
  end
      
  it 'listとdetailに内容が記載されていればバリデーションが通る' do
    task = Task.new(list: '成功テスト', detail: '成功テスト')
    expect(task).to be_valid
  end
end