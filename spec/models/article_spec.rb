# frozen_string_literal: true

require 'rails_helper'

describe 'create' do
  
  it "新規投稿できるか" do
    expect(FactoryBot.build(:article)).to be_valid
  end
  it "titleがない場合は投稿できないこと" do
    article = build(:article, title: nil)
    article.valid?
  end
  it "videoがない場合は投稿できないこと" do
    article = build(:article, video: nil)
    article.valid?
  end
  
end