require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do
  before do
    @organization = create(:organization, :organization_approved)
    @user = create(:user, :organization_approved)
  end

  it "it can be created" do
    visit root_path

    log_in_as(@user)

    click_on 'Edit Organization'

    # puts page.html

    fill_in 'Name', with: 'coolest org ever'
    fill_in 'Phone', with: '111-666-7777'
    fill_in 'Email', with: 'email@example.com'
    fill_in 'Description', with: 'we are SO COOL'

    click_on 'commit'
    
    expect(page.body).to have_text('coolest org ever')
  end
end
