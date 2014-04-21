require 'spec_helper'

describe User do
  context "without email or password" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest).with_message("password can't be blank") }
    it { should ensure_length_of(:password).is_at_least(6)}
  end

  context "user instance methods" do
    let(:user) { FactoryGirl.build(:user) }
    it "should identify a correct password" do
      expect(user.is_password?('123456')).to be_true
    end

    it "should identify a false password" do
      expect(user.is_password?('abcdef')).to be_false
    end
  end

  context "User class methods" do
    before do
      FactoryGirl.create(:user)
    end

    it "should find a user with correct credentials" do
      expect(User.find_by_credentials('example@peppermint.com', '123456')).to_not be_nil
    end

    it "should find a user with correct credentials" do
      expect(User.find_by_credentials('example@peppermint.com', '23456')).to be_nil
    end
  end

  context "associations" do
    it "add associations"
  end
end
