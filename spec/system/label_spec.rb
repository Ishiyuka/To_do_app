require 'rails_helper'

RSpec.describe 'ラベル機能', type: :system do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:label) { FactoryBot.create(:label) }
    let!(:second_label) { FactoryBot.create(:second_label) }
    let!(:labelling) { FactoryBot.create(:labelling, task: task, label: label) }
    before do
      visit new_session_path
      fill_in 'メールアドレス',	with: "admin0test1@example.com"
      fill_in 'パスワード',	with: "admin0test1"
      click_on 'ログイン'
      visit tasks_path
    end

  describe 'ラベル登録機能' do
    context 'タスクを新規作成する時、ラベルを選択した場合' do
      it 'ラベルが登録される' do
        visit new_task_path
        fill_in 'タスク',	with: 'タスク1'
        fill_in '詳細',	with: '課題'
        fill_in '終了期限', with: "2022-11-11"
        select '未着手', from: 'ステータス'
        select '高', from: '優先順位'
        sleep 2.0
        check 'label1'
        click_on '登録する'
        expect(page).to have_content 'label1'
      end
    end

    context 'タスクを新規作成する時、ラベルを複数選択した場合' do
      it 'ラベルが登録される' do
        visit new_task_path
        fill_in 'タスク',	with: 'タスク2'
        fill_in '詳細',	with: '買い物'
        fill_in '終了期限', with: "2022-11-11"
        select '着手中', from: 'ステータス'
        select '中', from: '優先順位'
        check 'label1'
        check 'label2'
        click_on '登録する'
        expect(page).to have_content 'label1'
        expect(page).to have_content 'label2'
      end
    end
  end

  describe 'ラベル編集機能' do
    context 'タスク編集時にラベルを変更する場合' do
      it '変更したラベルにて登録する' do
        click_on '編集'
        sleep 2.0
        check 'label1'
        check 'label2'
        click_on '更新する'
        page.save_screenshot 'sc_1.png'
        expect(page).to have_content '編集しました'
      end
    end
  end

  describe 'ラベル検索機能' do
    context 'ラベル検索をした場合' do
      it "検索したラベルと一致するタスクが表示される" do
        select 'label1', from: 'task_search[label_id]'
        click_on "検索"
        expect(page).to have_content 'label1'
      end
    end
  end
end