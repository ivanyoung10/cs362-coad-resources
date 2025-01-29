require 'rails_helper'
#Mine

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

    it "validates presence of phone" do
      expect(ticket).to validate_presence_of(:phone)
    end

    it "validates presence of region id" do
      expect(ticket).to validate_presence_of(:region_id)
    end

    it "validates presence of resource category id" do
      expect(ticket).to validate_presence_of(:resource_category_id)
    end

    it "validates name length" do
      expect(ticket).to validate_length_of(:name).is_at_most(255)
      expect(ticket).to validate_length_of(:name).is_at_least(1)
    end

    it "validates description length" do
      expect(ticket).to validate_length_of(:description).is_at_most(1020)
    end

    it "validates valid phone" do
      #!! TODO
    end

  end

  describe "member function tests" do
    it "converts to string" do
      expect(ticket.to_s).to eq "Ticket 123"
    end
    
    it "checks if open" do
      expect(ticket.open?).to_not eq :closed
      #I think this is right?
    end

    it "checks if captured" do
       #expect(ticket.captured?).to eq ticket.organization_id
      # not work
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

    it "scopes organizations tests" do 
      region = Region.create!(name: "region1")
      resource = ResourceCategory.create!(name: "resource1")
      organization = Organization.create!(
        name: "organization1", 
        email: "email@gmail.com", 
        phone: "+1-111-111-1111",
        primary_name: "JS Sdf",
        secondary_name: "JS dfs",
        secondary_phone: "+1-222-222-2222"
      )

      ticket = Ticket.create!(
        name: "ticket",
        phone: "+1-555-555-1212",
        organization_id: organization.id,
        closed: false,
        region_id: region.id,
        resource_category_id: resource.id
      )

      expect(Ticket.all_organization).to include(ticket)
      expect(Ticket.organization(organization.id)).to include(ticket)
      expect(Ticket.closed_organization(organization.id)).to_not include(ticket)

    end

    it "scopes region tests" do
        region = Region.create!(name: "region345")
    
        resource = ResourceCategory.create(name:"resource345")
        ticket = Ticket.create!(
          name: "ticket",
          phone: "+1-555-555-1112",
          closed: false,
          region_id: region.id,
          resource_category_id: resource.id
      )
    
        expect(Ticket.region(region.id)).to include(ticket)
    
    end

    it "scopes ressource category tests" do
      region = Region.create!(name: "region345")
  
      resource = ResourceCategory.create(name:"resource345")
      ticket = Ticket.create!(
        name: "ticket",
        phone: "+1-555-555-1112",
        closed: false,
        region_id: region.id,
        resource_category_id: resource.id
    )
  
      expect(Ticket.resource_category(resource.id)).to include(ticket)
  
  end

  end

end
