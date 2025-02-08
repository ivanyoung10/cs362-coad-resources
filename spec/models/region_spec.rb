require 'rails_helper'
RSpec.describe Region, type: :model do

  let (:region) { FactoryBot.build(:region) }

  describe "attribute tests" do

    it "exists" do
      Region.new
    end

    it "has a name" do
      expect(region).to respond_to(:name)
    end

    it "has many tickets" do
      should have_many(:tickets)
    end

  end

  describe "validation tests" do

    it "validates presence of name" do
      expect(region).to validate_presence_of(:name)
    end

    it "validates length of name" do
      expect(region).to validate_length_of(:name).is_at_least(1)
      expect(region).to validate_length_of(:name).is_at_most(255)
    end

    it "validates uniqueness of name" do
      expect(region).to validate_uniqueness_of(:name).case_insensitive
    end

  end

  describe "member function tests" do
    
    # I don't think this should be a factory?
    it "sets name to Unspecified if blank" do
      region = Region.unspecified
      expect(region.name).to eq 'Unspecified'

    end

    # the to_s test that was here was redundant with an attribute test,
    # I think it's closer to being a function test so I moved it down here
    it "makes name a string" do
      region = build_stubbed(:region, name: 'Mt Hood')
      expect(region.to_s).to eq 'Mt Hood'
    end
  end
end