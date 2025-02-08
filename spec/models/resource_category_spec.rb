# Rowan
require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
  let (:resCat) { FactoryBot.build(:resource_category) }


  it "exists" do
    ResourceCategory.new
  end

  it "has a name" do
    expect(resCat).to respond_to(:name)
  end

  it "has a active" do
    expect(resCat).to respond_to(:active)
  end

  it "has and belongs to many organizations" do
    should have_and_belong_to_many(:organizations)
  end

  it "has many tickets" do
    should have_many(:tickets)
  end


  describe "validation tests" do
    it "validates name presence" do
      expect(resCat).to validate_presence_of(:name)
    end

    it "validates name length" do
      expect(resCat).to validate_length_of(:name).is_at_least(1)
      expect(resCat).to validate_length_of(:name).is_at_most(255)
    end

    it "validates name uniqueness" do
      expect(resCat).to validate_uniqueness_of(:name).case_insensitive()
    end
  end


  describe "member function tests" do
    it "activates category" do
      resCat.activate
      expect(resCat.active).to eq true
    end

    it "deactivates category" do
      resCat.deactivate
      expect(resCat.active).to eq false
    end

    it "tests inactive?" do
      resCat.activate
      expect(resCat.inactive?).to eq false

      resCat.deactivate
      expect(resCat.inactive?).to eq true
    end

    it "converts to string" do
      expect(resCat.to_s).to eq resCat.name
    end
  end

  describe "static function tests" do
    it "creates new unspecified if not already present" do
      result = ResourceCategory.unspecified
      expect(result.name).to eq('Unspecified')
    end
  
    it "returns existing unspecified" do
      existing_category = create(:resource_category, :unspecified)
  
      result = ResourceCategory.unspecified
      expect(result).to eq(existing_category)
    end
  
    it "does not create duplicates" do
      ResourceCategory.unspecified
      ResourceCategory.unspecified
  
      expect(ResourceCategory.where(name: 'Unspecified').count).to eq(1)
    end
  end


  describe "scope tests" do
    it "checks active scope" do
      resource_cat = create(:resource_category, active: true)

      expect(ResourceCategory.active).to include(resource_cat)
      expect(ResourceCategory.inactive).to_not include(resource_cat)
    end

    it "checks inactive scope" do
      resource_cat = create(:resource_category, active: false)
    
      expect(ResourceCategory.active).to_not include(resource_cat)
      expect(ResourceCategory.inactive).to include(resource_cat)
    end

  end
end
