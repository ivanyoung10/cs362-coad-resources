require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do
  before do
    @organization = create(:organization)
    @user = create(:user, :organization_approved)
  end

  it "it can be created" do
    visit root_path

    click_on 'Give Help'
    click_on 'Apply Now'

    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: 'example@example.password'
    fill_in 'Password confirmation', with: 'example@example.password'
    
    
    find_by_id('commit').click
    expect(page.body).to have_text('To organize and deploy community resources in an efficient')

    # not sure where to go from here sense I can't see the page after making a new account due to the captcha

    # click_on 'Dashboard'
    # expect(current_path).to eq dashboard_path
    # expect(page.body).to have_text('Edit Organization')
    
  end
end
