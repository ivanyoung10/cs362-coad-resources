require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "exists" do
    Ticket.new
  end

  it "has a name" do
    ticket = Ticket.new
    expect(ticket).to respond_to(:name)
  end
end
