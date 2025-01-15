require 'rails_helper'

RSpec.describe User, type: :model do

  let (:usr) {User.new}

  it "exists" do
    User.new
  end

  it "has a email" do
    expect(usr).to respond_to(:email)
  end

  it "has a encrypted password" do
    expect(usr).to respond_to(:encrypted_password)
  end

  it "has a reset password token" do
    expect(usr).to respond_to(:reset_password_token)
  end

  it "has a reset password sent at" do
    expect(usr).to respond_to(:reset_password_sent_at)
  end

  it "has a confirmation token" do
    expect(usr).to respond_to(:confirmation_token)
  end

  it "has a confirmation at" do
    expect(usr).to respond_to(:confirmed_at)
  end

  it "has a confirmation sent at" do
    expect(usr).to respond_to(:confirmation_sent_at)
  end

  it "has a unconfirmed email" do
    expect(usr).to respond_to(:unconfirmed_email)
  end

  it "has a role" do
    expect(usr).to respond_to(:role)
  end

  it "belongs to a organization" do
    should belong_to(:organization).optional
  end

end
