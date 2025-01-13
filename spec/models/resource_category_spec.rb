require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
  it "exists" do
    ResourceCategory.new
  end

  it "has a name" do
    resource_category = ResourceCategory.new
    expect(resource_category).to respond_to(:name)
  end
end
