require 'rails_helper'

RSpec.describe 'Approving an organization', type: :feature do
  before do
    @organization = create(:organization)
    @user = create(:user, :admin)
  end

  it "it can be approved" do
    visit root_path

    log_in_as(@user)

    click_on 'Organizations'
    click_on 'Pending'
    click_on @organization.name
    click_on 'Approve'
    click_on 'Approved'

    expect(page.body).to have_text("#{@organization.name}")
  end
end
