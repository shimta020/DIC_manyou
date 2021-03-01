require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'ラベルモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'ラベル名が空の場合' do
        it 'バリデーションにひっかる' do
          label = Label.new(label_name: '')
          expect(label).not_to be_valid
        end
      end
      context 'ラベル名前が10文字以下の場合' do
        it 'ラベルが新規作成される' do
          label = Label.new(label_name: '作成成功')
          expect(label).to be_valid
        end
      end
    end
  end
end
