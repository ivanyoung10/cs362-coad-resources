require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:tick) {Ticket.new}

  it "exists" do
    Ticket.new
  end

  it "has a name" do
    expect(tick).to respond_to(:name)
  end

  it "has a description" do
    expect(tick).to respond_to(:description)
  end

  it "has a phone" do
    expect(tick).to respond_to(:phone)
  end

  it "has a closed" do
    expect(tick).to respond_to(:closed)
  end

  it "has a closed at" do
    expect(tick).to respond_to(:closed_at)
  end

  it "has a name" do
    expect(tick).to respond_to(:name)
  end


end
