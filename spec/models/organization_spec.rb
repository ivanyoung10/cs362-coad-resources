# Rowan
require 'rails_helper'

RSpec.describe Organization, type: :model do

  let (:org) { FactoryBot.build(:organization) }

  it "exists" do
    Organization.new
  end

  it "has a name" do
    expect(org).to respond_to(:name)
  end

  it "has a status" do
    expect(org).to respond_to(:status)
  end

  it "has a phone" do
    expect(org).to respond_to(:phone)
  end

  it "has a email" do
    expect(org).to respond_to(:email)
  end

  it "has a description" do
    expect(org).to respond_to(:description)
  end

  it "has a primary name" do
    expect(org).to respond_to(:primary_name)
  end

  it "has a secondary name" do
    expect(org).to respond_to(:secondary_name)
  end

  it "has a secondary phone" do
    expect(org).to respond_to(:secondary_phone)
  end

  it "has a transportation" do
    expect(org).to respond_to(:transportation)
  end

  it "has many users" do
    should have_many(:users)
  end

  it "has many tickets" do
    should have_many(:tickets)
  end

  it "has many and belongs to many resource categories" do
    should have_and_belong_to_many(:resource_categories)
  end


  describe "validation tests" do
    it "validates presence" do
      expect(org).to validate_presence_of(:email)
      expect(org).to validate_presence_of(:name)
      expect(org).to validate_presence_of(:phone)
      expect(org).to validate_presence_of(:status)
      expect(org).to validate_presence_of(:primary_name)
      expect(org).to validate_presence_of(:secondary_name)
      expect(org).to validate_presence_of(:secondary_phone)
    end

    it "validates email basics" do
      expect(org).to validate_length_of(:email).is_at_least(1)
      expect(org).to validate_length_of(:email).is_at_most(255)
      expect(org).to validate_uniqueness_of(:email).case_insensitive()
    end

    it "validates email formatting" do
      expect(org).to allow_value("valid@example.com").for(:email)
      expect(org).not_to allow_value("invalid_email").for(:email)
      expect(org).not_to allow_value("invalid@.com").for(:email)
      expect(org).not_to allow_value("invalid@com").for(:email)
      expect(org).not_to allow_value("@").for(:email)
    end

    it "validates name" do 
      expect(org).to validate_length_of(:name).is_at_least(1)
      expect(org).to validate_length_of(:name).is_at_most(255)
      expect(org).to validate_uniqueness_of(:name).case_insensitive()
    end

    it "validates description length" do
      expect(org).to validate_length_of(:description).is_at_most(1020)
    end
  end


  describe "member function tests" do
    it "tests approve" do
      org.approve
      expect(org.status).to eq "approved"
    end

    it "tests reject" do
      org.reject
      expect(org.status).to eq "rejected"
    end

    it "sets default status" do
      org.set_default_status
      expect(org.status).to eq "submitted"

      org.approve
      org.set_default_status
      expect(org.status).to_not eq "submitted"
    end

    it "converts to string" do
      expect(org.to_s).to eq org.name
    end
  end
end
