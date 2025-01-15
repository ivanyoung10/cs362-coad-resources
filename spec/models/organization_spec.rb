require 'rails_helper'

RSpec.describe Organization, type: :model do

  let (:org) { Organization.new}

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

  it "has a rejection_reason" do
    expect(org).to respond_to(:rejection_reason)
  end

  it "has a phone" do
    expect(org).to respond_to(:phone)
  end

  it "has a libality insurance" do
    expect(org).to respond_to(:liability_insurance)
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

  it "has a title" do
    expect(org).to respond_to(:title)
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
  

end
