require 'rails_helper'
#Mine
RSpec.describe User, type: :model do

  let (:user) {User.new}

  it "exists" do
    User.new
  end

  describe "attribute tests" do

    it "has a email" do
      expect(user).to respond_to(:email)
    end

    it "has a encrypted password" do
      expect(user).to respond_to(:encrypted_password)
    end

    it "has a reset password token" do
      expect(user).to respond_to(:reset_password_token)
    end

    it "has a reset password sent at" do
      expect(user).to respond_to(:reset_password_sent_at)
    end

    it "has a confirmation token" do
      expect(user).to respond_to(:confirmation_token)
    end

    it "has a confirmation at" do
      expect(user).to respond_to(:confirmed_at)
    end

    it "has a confirmation sent at" do
      expect(user).to respond_to(:confirmation_sent_at)
    end

    it "has a unconfirmed email" do
      expect(user).to respond_to(:unconfirmed_email)
    end

    it "has a role" do
      expect(user).to respond_to(:role)
    end

    it "belongs to a organization" do
      should belong_to(:organization).optional
    end

  end

  describe "validation tests" do

    it "validates presence of email" do
      expect(user).to validate_presence_of(:email)
    end

    it "validates presence of password" do
      expect(user).to validate_presence_of(:password)
    end

    it "validates email length" do
      expect(user).to validate_length_of(:email).is_at_least(1)
      expect(user).to validate_length_of(:email).is_at_most(255)
    end

    it "validates password length" do
      expect(user).to validate_length_of(:password).is_at_least(7)
      expect(user).to validate_length_of(:password).is_at_most(255)
    end

    it "validates uniqueness of email" do
      expect(user).to validate_uniqueness_of(:email).case_insensitive
    end

    it "validates email formatting" do
      expect(user).to allow_value("valid@example.com").for(:email)
      expect(user).not_to allow_value("invalid_email").for(:email)
      expect(user).not_to allow_value("invalid@.com").for(:email)
      expect(user).not_to allow_value("invalid@com").for(:email)
      expect(user).not_to allow_value("@").for(:email)
    end


  end

  describe "member function tests" do
    
    it "converts to string" do
      expect(user.to_s).to eq ""
      #I tink dis right
    end

    it "sets default role to organization" do
      expect(user.set_default_role).to eq "organization"
    end

  end

end
