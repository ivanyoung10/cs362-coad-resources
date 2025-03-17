require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do
  before do
    @region = create(:region)
    @resource_category = create(:resource_category)
    @ticket = create(:ticket, region: @region, resource_category: @resource_category)
    @user = create(:user, :admin)
  end

  it 'it can be deleted from the home screen' do
    visit root_path
    log_in_as(@user)
    click_on "#{@ticket.name}"
    click_on 'Delete'
    expect(current_path).to eq dashboard_path

  end
end
