require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タイトル', with: "1"
        fill_in '詳細', with: "1"
        fill_in '終了期限', with: Time.new(2022-11-01)
        select '未着手', from: 'ステータス'
        select '高', from: '優先順位'
        click_on "登録する"
        expect(page).to have_content '1'
      end
    end
  end

  describe '一覧表示機能' do
    # let!(:task) { FactoryBot.create(:task, list: '掃除', detail: '床') }
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
      expect(page).to have_content '1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_table')
        expect(task_list[0]).to have_content "3"
        expect(task_list[1]).to have_content "2"
        expect(task_list[2]).to have_content "1"
      end
    end

    context '終了期限でソートするというリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        click_link "終了期限"
        sleep 2.0
        task_list = all('.task_table')
        expect(task_list[0]).to have_content "1"
        expect(task_list[1]).to have_content "2"
        expect(task_list[2]).to have_content "3"
      end
    end
    context '優先順位でソートするボタンを押した場合' do
      it '優先順位が高い順になったタスク一覧が表示される' do
        click_link "優先順位"
        sleep 2.0
        task_list = all('.task_table')
        expect(task_list[0]).to have_content "高"
        expect(task_list[1]).to have_content "中"
        expect(task_list[2]).to have_content "低"
      end
    end
  end

  describe "検索機能" do
    # let!(:task){ FactoryBot.create(:task) }
    # let!(:second_task){ FactoryBot.create(:second_task) }
    before do
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in "task_search[list]", with: 'タスク'
        click_on "検索"
        expect(page).to have_content '1'
        expect(page).to have_content '2'
        expect(page).to have_content '3'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '完了', from: 'task_search[status]'
        click_on "検索"
        expect(page).to have_content '3'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in "task_search[list]", with: 'タスク'
        select '着手中', from: 'task_search[status]'
        click_on "検索"
        expect(page).to have_content '2'
      end
    end
  end


  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task.id)
        expect(page).to have_content '1'
      end
    end
  end
end