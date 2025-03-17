require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do
  before do
    @resource_category = create(:resource_category)
    @region = create(:region)
    @ticket = create(:ticket, resource_category: @resource_category, region: @region)
    @user = create(:user, :admin)
  end

  it 'closes the ticket' do
    log_in_as(@user)
    click_on "#{@ticket.name}"
    click_on 'Close'
    expect(current_path).to eq dashboard_path
  end
end
