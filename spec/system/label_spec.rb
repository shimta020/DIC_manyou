require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  before do
    user = FactoryBot.create(:user)
    visit new_session_path
    fill_in "session[email]", with: "general@example.com"
    fill_in "session[password]", with: "password"
    click_on "Log in"
    visit tasks_path
    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user)
    FactoryBot.create(:third_task, user: user)
  end
  describe 'ラベル管理について' do
    context '管理者がラベルを新規作成した場合' do
      it '作成したラベルが表示される' do

      end
    end
    context '管理者以外がラベル作成ページにアクセスしようとした場合' do
      it 'タスク一覧画面に遷移する' do

      end
    end
    context '管理者がラベルを削除した場合' do
      it 'ラベルが削除される' do

      end
    end
  end
  describe 'ラベルの利用について' do
    context 'タスク新規作成時' do
      it '既存のラベルをタスクに紐付けることができる' do

      end
    end
  end
  describe 'ラベル付きのタスクに対して' do
    context '編集機能によって' do
      it 'ラベルを付与することができる' do

      end
      it 'ラベルをタスクから取り除くことができる' do

      end
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクに紐づいたラベルが表示される' do

      end
    end
    context 'ラベル名で検索をした場合' do
      it 'そのラベルを持つタスクのみが表示される' do
        
      end
    end
  end
end