require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(list: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end

    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(list: '失敗テスト', detail: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(list: '掃除', detail: '床')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, list: 'タスク1', status:'未着手') }
    let!(:second_task) { FactoryBot.create(:second_task, list: 'タスク2', status:'着手中')}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_list('タスク1')).to include(task)
        expect(Task.search_list('タスク1')).not_to include(second_task)
        expect(Task.search_list('タスク1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('未着手')).to include (task)
        expect(Task.search_status('未着手')).not_to include (second_task)
        expect(Task.search_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_list('タスク2')).to include(second_task)
        expect(Task.search_status('着手中')).to include(second_task)
        expect(Task.search_list('タスク2')).not_to include(task)
        expect(Task.search_status('着手中')).not_to include(task)
        expect(Task.search_list('タスク2').count).to eq 1
        expect(Task.search_status('着手中').count).to eq 1
      end
    end
  end
end