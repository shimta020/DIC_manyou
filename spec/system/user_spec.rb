require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:admin_user)
  end
  describe 'ユーザー登録' do
    context 'ユーザー登録を行った時' do
      it 'ユーザーの新規登録ができる' do
        visit new_user_path
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on '新規作成'
        expect(page).to have_content 'testさんのプロフィール'
      end
    end
    context 'ユーザー登録をせずにタスク一覧へ移動した時' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Log In Form'
      end
    end
  end
  describe 'セッション機能' do
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'general@example.com'
      fill_in 'session[password]', with: 'password'
      click_on 'Log in'
    end
    context 'ログインフォームに作成したユーザーデータを入力すると' do
      it 'ログインできる' do
        expect(page).to have_content 'ようこそgeneral_userさん'
      end
    end
    context 'ログイン後' do
      it 'プロフィールページにアクセスできる' do
        click_on 'Profile'
        expect(page).to have_content 'general_userさんのプロフィール'
      end
    end
    context '一般ユーザーが他人の詳細画面に飛ぶと' do
      it 'タスク一覧画面に遷移する' do
        user = User.find_by(name: 'admin_user')
        visit user_path(user.id)
        expect(page).to have_content '他人のプロフィールは見れないよ！'
      end
    end
    context 'Logoutをクリックすると' do
      it 'ログアウトできる' do
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理者画面について' do
    context '管理ユーザーでログインした場合' do
      before do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'Log in'
        user = User.find_by(name: 'admin_user')
        click_on '管理者画面へ'
      end
      it '管理者画面にアクセスできる' do
        expect(page).to have_content 'ユーザー一覧'
      end
      it 'ユーザーの新規登録ができる' do
        click_on 'ユーザー新規作成'
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'Create account'
        expect(page).to have_content 'ユーザーが1人増えました〜'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        # click_link '詳細', href: admin_user_path(1)
        click_on '詳細',match: :first
        expect(page).to have_content 'general_user'
      end
      it 'ユーザー情報の編集ができる' do
        click_on '編集',match: :first
        fill_in 'user[name]', with: 'name_change'
        check 'user[admin]'
        click_on 'Update account'
        expect(page).to have_content 'name_changeさんのプロフィールを編集しました'
      end
      it 'ユーザーの削除ができる' do
        page.accept_confirm do
          click_on '削除',match: :first
        end
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
    context '一般ユーザーでログインした場合' do
      it '管理者画面へはアクセスできない' do
        visit new_session_path
        fill_in 'session[email]', with: 'general@example.com'
        fill_in 'session[password]', with: 'password'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセス出来ません!!!'
      end
    end
  end
end