require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) { Ticket.new(id: 123) }

  describe "attribute tests" do
    it "exists" do
      Ticket.new
    end

    it "has a name" do
      expect(ticket).to respond_to(:name)
    end

    it "has a description" do
      expect(ticket).to respond_to(:description)
    end

    it "has a phone" do
      expect(ticket).to respond_to(:phone)
    end

    it "has a closed" do
      expect(ticket).to respond_to(:closed)
    end

    it "has a closed at" do
      expect(ticket).to respond_to(:closed_at)
    end

    it "belongs to a region" do
      should belong_to(:region)
    end

    it "belongs to a resource category" do 
      should belong_to(:resource_category)
    end

    it "belongs to a organization" do 
      should belong_to(:organization).optional
    end
  end

  describe "validation tests" do 
    it "validates presence of name" do
      expect(ticket).to validate_presence_of(:name)
    end

    it "validates name length" do
      expect(ticket).to validate_length_of(:name).is_at_most(255)
      expect(ticket).to validate_length_of(:name).is_at_least(1)
    end

  end

  describe "member function tests" do
    it "converts to string" do
      expect(ticket.to_s).to eq "Ticket 123"
    end
  end
  
  describe "scope tests" do
    it "scopes closed tickets" do 
      region = Region.create!(name: "region1")
      resource = ResourceCategory.create!(name: "resource1")

      ticket = Ticket.create!(
        name: "ticket",
        phone: "+1-555-555-1212",
        region_id: region.id,
        resource_category_id: resource.id,
        closed: true
      )

      expect(Ticket.closed).to include(ticket)
      expect(Ticket.open).to_not include(ticket)
  
    end

  end

end
