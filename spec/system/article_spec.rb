require 'rails_helper'

describe "投稿一覧のテスト" do
  let(:article) { FactoryBot.create(:article) }
  
  before do
    visit articles_path
  end
  
  context '表示の確認' do
    it 'searchリンク' do
      expect(page).to have_link nil, href: search_articles_path
    end
    it '投稿されたものが表示されているか' do
      #how to write
    end
  end
end

describe "詳細画面のテスト" do
  let(:article) { FactoryBot.create(:article) }
  before do
    visit article_path(article)
  end
end
