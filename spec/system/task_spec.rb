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
        fill_in 'task[title]', with: 'test'
        fill_in 'task[content]', with: 'test'
        fill_in 'task[deadline]', with: '2021-01-01'.to_date
        select '未着手', from: 'task[status]'
        click_on '登録する'
        expect(page).to have_content '作成完了！'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test2'
        expect(task_list[1]).to have_content 'test1'
      end
    end
    context 'タスクを終了期限順にソートするを押した場合' do
      it '終了期限の近いもの順に並ぶ' do
        visit tasks_path
        click_on 'タスクを終了期限順にソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test1'
        expect(task_list[1]).to have_content 'test2'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit task_path(task.id)
        expect(page).to have_content 'task'
       end
     end
  end
end