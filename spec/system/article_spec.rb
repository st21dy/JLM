require 'rails_helper'

describe "index画面のテスト" do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@email.com') }
  let(:article_a) { FactoryBot.create(:article, user: user_a) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: "a@email.com"
    fill_in 'user[password]', with: "password"
    click_button 'ログイン'
      
    visit articles_path
  end

  context "表示の確認" do
    it "searchリンクが表示される" do
      expect(page).to have_link nil, href: search_articles_path
    end
  end
end

describe "search画面のテスト" do
  before do
    visit search_articles_path
  end
  context "表示の確認" do
    it "検索ボタンが表示される" do
      expect(page).to have_button '検索'
    end
  end
end

describe "new画面のテスト" do
  before do
    visit new_article_path
  end
  context "表示の確認" do
    it "投稿ボタンが表示される" do
      expect(page).to have_button '投稿'
    end
  end
end

describe "edit画面のテスト" do
  let(:article) { FactoryBot.create(:article) }

  before do
    visit edit_article_path(article)
  end
  context "表示の確認" do
    it '編集前のtitle/body/captionがフォームに表示(セット)されている' do
      expect(page).to have_field 'article[title]', with: article.title
      expect(page).to have_field 'article[body]', with: article.body
      expect(page).to have_field 'article[caption]', with: article.caption
    end
    it "編集ボタンが表示される" do
      expect(page).to have_button '編集'
    end
  end
end
