require 'rails_helper'

RSpec.describe 'Releasing a ticket by an', type: :feature do
  before do
    @organization = create(:organization)
    @region = create(:region)
    @resource_category = create(:resource_category)
    @ticket = create(:ticket, region: @region, resource_category: @resource_category)
    @user = create(:user, :organization_approved)
  end

  it 'releases a ticket' do
    visit root_path
    log_in_as(@user)
    click_on "Tickets"
    click_on "#{@ticket.name}"
    click_on "Capture"
    click_on "Tickets"
    click_on "#{@ticket.name}"
    click_on "Release"

    expect(current_path).to eq dashboard_path
  end
end
