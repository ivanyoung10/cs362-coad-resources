require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "exists" do
    Organization.new
  end

  it "has a name" do
    organization = Organization.new
    expect(organization).to respond_to(:name)
  end

end
