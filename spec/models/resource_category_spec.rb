require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:resCat) {ResourceCategory.new}

  it "exists" do
    ResourceCategory.new
  end

  it "has a name" do
    expect(resCat).to respond_to(:name)
  end

  it "has a active" do
    expect(resCat).to respond_to(:active)
  end
end
