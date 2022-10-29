require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
  FactoryBot.create(:task)
  FactoryBot.create(:second_task)
end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[list]", with:"掃除"
        fill_in "task[detail]", with:"床"
        click_on "登録する"
        expect(page).to have_content '掃除'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:task) { FactoryBot.create(:task, list: '掃除', detail: '床') }
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
      expect(page).to have_content '掃除'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
          assert Task.all.order(created_at: "desc")
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, list: '勉強', detail: 'プログラミング')
        visit task_path(task.id)
        expect(page).to have_content '詳細'
      end
    end
  end
end