require 'rails_helper'

RSpec.describe 'Capturing a ticket', type: :feature do
 before do
   @organization = create(:organization)
   @region = create(:region)
   @resource_category = create(:resource_category)
   @ticket = create(:ticket, region: @region, resource_category: @resource_category)
   @user = create(:user, :organization_approved)
 end

 it 'captures a ticket' do
   visit root_path
   log_in_as(@user)
   click_on "Tickets"
   click_on "#{@ticket.name}"
   click_on "Capture"

   expect(current_path).to eq dashboard_path
 end
end
