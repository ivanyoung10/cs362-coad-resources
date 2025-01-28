require 'rails_helper'
#Mine
RSpec.describe Region, type: :model do

  let (:region) { Region.new }


  describe "attribute tests" do

    it "exists" do
      Region.new
    end

    it "has a name" do
      region = Region.new
      expect(region).to respond_to(:name)
    end

    it "has a string representation that is its name" do
      name = 'Mt. Hood'
      region = Region.new(name: name)
      result = region.to_s
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
    
    # it "sets name to Unspecified if blank" do
    #   expect(region.unspecified).to eq "Unspecified"
    # end

    it "sets region to string" do 
      region2 = Region.new(name: "Heaver")
      expect(region2.to_s).to eq "Heaver"
    end

  end
end

