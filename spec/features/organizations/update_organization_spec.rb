require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do
  before do
    @organization = create(:organization)
    @user = create(:user, :organization_approved)
  end

  it "it can be created" do
    visit root_path

    log_in_as(@user)

    click_on 'Edit Organization'
    
    fill_in 'Name', with: 'Cool Org'
    fill_in 'Phone', with: '+1-111-111-1234'
    # can't fill in because it's a number counter?????
    # fill_in 'Email', with: 'exemplary@example.com'
    fill_in 'Description', with: 'The coolest org around'

    click_on 'Update Resource'

    # the update code doesn't work
    # but this is where the tests would go
    # neither the website nor db entry for
    # a signed in org actually get updated
  end
end
