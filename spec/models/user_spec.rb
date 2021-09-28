# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe '#create' do
    it "新規登録できるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
    it "nameがない場合は登録できないこと" do
      user = build(:user, name: nil)
      user.valid?
    end
    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
    end
    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
    end
  end
end