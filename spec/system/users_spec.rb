# frozen_string_literal: true

require 'rails_helper'

describe 'userのテスト' do
  let(:user) { FactoryBot.create(:user) }

  describe '詳細画面のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: login_user.email
      fill_in 'user[password]', with: login_user.password
      click_button 'ログイン'

      visit user_path(user)
    end

    context '表示の確認' do
      let(:login_user) { user }
      it 'editリンクが存在するか' do
        expect(page).to have_link nil, href: edit_user_path(user)
      end
      it 'followsリンクが存在するか' do
        expect(page).to have_link nil, href: follows_user_path(user)
      end
      it 'followersリンクが存在するか' do
        expect(page).to have_link nil, href: followers_user_path(user)
      end
      it 'searchリンクが存在するか' do
        expect(page).to have_link nil, href: search_users_path
      end
      it 'likesリンクが存在するか' do
        expect(page).to have_link nil, href: likes_user_path(user)
      end
    end
  end

  describe '詳細画面の遷移テスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
    context 'follows画面への遷移' do
      it '遷移できるか' do
        visit follows_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/follows')
      end
    end
    context 'followers画面への遷移' do
      it '遷移できるか' do
        visit followers_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/followers')
      end
    end
    context 'search画面への遷移' do
      it '遷移できるか' do
        visit search_users_path
        expect(current_path).to eq('/users/search')
      end
    end
    context 'likes画面への遷移' do
      it '遷移できるか' do
        visit likes_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/likes')
      end
    end
  end
  
  describe '編集画面のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: login_user.email
      fill_in 'user[password]', with: login_user.password
      click_button 'ログイン'

      visit edit_user_path(user)
    end
    context '表示の確認' do
      let(:login_user) { user }
      it '編集前のnameとemailがフォームに表示(セット)されている' do
        expect(page).to have_field 'user[name]', with: user.name
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
      it '退会リンクが存在するか' do
        expect(page).to have_link '退会する'
      end
    end
    context '更新処理に関するテスト' do
      let(:login_user) { user }
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'user[name]', with: Faker::Lorem.characters(number:5)
        fill_in 'user[body]', with: Faker::Lorem.characters(number:10)
        fill_in 'user[email]', with: Faker::Internet.email
        click_button '変更を保存'
        expect(page).to have_current_path user_path(user)
      end
    end
  end
  
  describe 'search画面のテスト' do
    before do
      visit search_users_path
    end
    context '表示の確認' do
      it '検索ボタンが表示される' do
        expect(page).to have_button '検索'
      end
    end
  end

end
