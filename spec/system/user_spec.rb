require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録のテスト' do
    before do
      FactoryBot.create(:user)
    end
    context 'ユーザーを新規作成した場合' do
      it '登録したユーザーが表示される' do
        visit new_user_path
        fill_in '名前',	with: 'admin0test1'
        fill_in 'メールアドレス',	with: 'admin0test1@example.com'
        fill_in 'パスワード', with: 'admin0test1'
        fill_in '確認用パスワード', with: 'admin0test1'
        click_on 'アカウント作成する'
        expect(page).to have_content 'admin0'
      end
    end
    context 'ユーザーがログインせずにタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit new_user_path
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content 'パスワード'
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      FactoryBot.create(:user)
      visit new_session_path
      fill_in 'メールアドレス',	with: "admin0test1@example.com"
      fill_in 'パスワード',	with: 'admin0test1'
      click_on 'ログイン', match: :first
    end
    context 'ログインした場合' do
      it '自分の詳細画面に飛べる' do
        click_on 'マイページ'
        expect(page).to have_content 'のページ'
        expect(page).to have_content 'admin'
      end
    end
    context 'ログインした場合' do
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        visit user_path(5)
        expect(page).to have_content 'アクセスできません'
      end
    end
    context 'ログインした場合' do
      it 'ログアウトできる' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      visit new_session_path
      FactoryBot.create(:user)
    end
    context '管理ユーザーの場合' do
      it '管理画面にアクセスできること' do
        fill_in 'メールアドレス',	with: "admin0test1@example.com"
        fill_in 'パスワード',	with: 'admin0test1'
        click_on 'ログイン'
        sleep 2.0
        click_on 'ユーザー一覧', match: :first
        expect(page).to have_content 'ユーザー一覧'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザの新規登録ができること' do
        fill_in 'メールアドレス',	with: "admin0test1@example.com"
        fill_in 'パスワード',	with: 'admin0test1'
        click_on 'ログイン'
        click_on 'ユーザー一覧', match: :first
        sleep 2.0
        click_on '新規ユーザー登録'
        fill_in '名前',	with: 'Test10'
        fill_in 'メールアドレス',	with: 'test10@example.com'
        check '管理者権限'
        fill_in 'パスワード', with: 'test10'
        fill_in '確認用パスワード', with: 'test10'
        click_on '登録する'
        expect(page).to have_content '登録しました'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザの詳細画面にアクセスできること' do
        fill_in 'メールアドレス',	with: "admin0test1@example.com"
        fill_in 'パスワード',	with: 'admin0test1'
        click_on 'ログイン'
        click_on 'ユーザー一覧', match: :first
        sleep 2.0
        click_on '詳細', match: :first
        expect(page).to have_content 'マイページ'
        expect(page).to have_content '管理者権限'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザの編集画面にアクセスできること' do
        fill_in 'メールアドレス',	with: "admin0test1@example.com"
        fill_in 'パスワード',	with: 'admin0test1'
        click_on 'ログイン'
        click_on 'ユーザー一覧', match: :first
        click_on '編集', match: :first
        fill_in '名前',	with: 'admin0101'
        click_on '更新する'
        expect(page).to have_content '更新しました'
      end
    end
    context '管理ユーザーの場合' do
      it 'ユーザの削除ができること' do
        fill_in 'メールアドレス',	with: "admin0test1@example.com"
        fill_in 'パスワード',	with: 'admin0test1'
        click_on 'ログイン'
        sleep 2.0
        click_on 'ユーザー一覧', match: :first
        expect do
          page.accept_confirm do
            click_on '削除', match: :first
          end
        end
        expect(page).to have_content '削除'
      end
    end
    before do
      visit new_session_path
      FactoryBot.create(:second_user)
    end
      context '一般ユーザーの場合' do
        it '管理画面にアクセスできないこと' do
          fill_in 'メールアドレス',	with: "test04@example.com"
          fill_in 'パスワード',	with: 'test04'
          click_on 'ログイン'
          click_on 'ユーザー一覧'
          expect(page).to have_content 'アクセスできません'
        end
      end
    end
end