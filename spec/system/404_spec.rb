require 'rails_helper'
describe '404エラーについて' do
  before do
    user = FactoryBot.create(:user)
    visit new_session_path
    fill_in "session[email]", with: "general@example.com"
    fill_in "session[password]", with: "password"
    click_on "Log in"
    visit tasks_path
    FactoryBot.create(:task, user: user)
  end
  context 'taskが見つからない場合' do
    it 'レスポンスに404番を返す' do
      visit task_path(2)
      expect(page).to have_content("Couldn't find Task with 'id'=2")
    end
  end
end