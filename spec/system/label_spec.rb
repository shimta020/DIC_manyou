require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  before do
    admin = FactoryBot.create(:admin_user)
    visit new_session_path
    fill_in "session[email]", with: "admin@example.com"
    fill_in "session[password]", with: "password"
    click_on "Log in"
    FactoryBot.create(:task, user: admin)
    FactoryBot.create(:study_label)
    FactoryBot.create(:music_label)
  end
  
  describe 'ラベル管理について' do
    before do      
      click_on "管理者画面へ"
    end
    context '管理者がラベルを新規作成した場合' do
      it '作成したラベルが表示される' do
        visit new_label_path
        fill_in "label[label_name]", with: '新しく作成したラベル'
        click_on '登録する'
        expect(page).to have_content '新規ラベルを作成しました' && '新しく作成したラベル'
      end
    end
    context '管理者がラベルを削除した場合' do
      it 'ラベルが削除される' do
        visit labels_path
        page.accept_confirm do
          click_on '削除', match: :first
        end
        expect(page).to have_content 'ラベルを削除しました'
        expect(page).not_to have_content 'study'
      end
    end
  end

  describe '管理者以外のラベル機能制限' do
    before do
      general_user = FactoryBot.create(:user)
      visit new_session_path
      fill_in "session[email]", with: "general@example.com"
      fill_in "session[password]", with: "password"
      click_on "Log in"
    end
    context '一般ユーザーがラベル作成ページにアクセスしようとした場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_label_path
        expect(page).to have_content '管理者以外はアクセス出来ません!!!'
      end
    end
  end

  describe 'ラベルの利用について' do
    before do
      visit tasks_path
      click_on '新規作成'
      fill_in 'task[title]', with: 'テスト' 
      fill_in 'task[content]', with: 'サンプル' 
      fill_in 'task[deadline]', with: '2021-01-01'.to_date
      select '未着手', from: 'task[status]'
      select '低', from: 'task[priority]'
      check 'study'
      click_on '登録する'
    end
    context 'タスク新規作成時' do
      it '既存のラベルをタスクに紐付けることができる' do
        expect(page).to have_content '作成完了！' && 'study'
      end
    end
    context '編集機能によって' do
      it 'ラベルを付与することができる' do
        click_on '編集', match: :first
        check 'music'
        click_on '登録する'
        task_list = all('.task_rspec_row')
        expect(task_list[0]).to have_content 'music'
        expect(page).to have_content '編集完了!'
      end
      it 'ラベルをタスクから取り除くことができる' do
        click_on '編集', match: :first
        uncheck 'study'
        click_on '登録する'
        task_list = all('.task_rspec_row')
        expect(task_list[0]).not_to have_content 'study'
        expect(page).to have_content '編集完了!'
      end
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクに紐づいたラベルが表示される' do
        click_on '詳細',match: :first
        expect(page).to have_content 'study'
      end
    end
    context 'ラベル名で検索をした場合' do
      it 'そのラベルを持つタスクのみが表示される' do
        select 'study', from: 'label_id'
        click_on '検索'
        expect(page).not_to have_content 'test1'
      end
    end
  end
end