require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do
  before do
    @organization = create(:organization)
    @user = create(:user, :organization_approved)
    @res_cat = create(:resource_category, name: "rescatname1")

    deliver_now_double = double()
    allow(deliver_now_double).to receive(:deliver_now)
    admin = double()
    allow(admin).to receive(:new_organization_application).and_return(deliver_now_double)
    allow(UserMailer).to receive(:with).and_return(admin)
  end

  it "it can be created" do
    visit root_path

    click_on 'Give Help'
    click_on 'Apply Now'

    fill_in 'Email', with: 'email@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'

    find_by_id('commit').click

    click_on 'Create Application'
    
    choose 'organization_liability_insurance_true'
    all(:radio_button, 'I Agree').each(&:choose)
    fill_in 'What is your name? (Last, First)', with: 'Howard, Todd'
    fill_in 'Organization Name', with: 'Bethesda'
    fill_in 'What is your title? (if applicable)', with: 'Big T'
    fill_in 'What is your direct phone number? Cell phone is best.', with: '+1-111-111-2313'
    fill_in 'Who may we contact regarding your organization\'s application if we are unable to reach you?',
    with: 'me'
    fill_in 'What is a good secondary phone number we may reach your organization at?', with: '+2-222-222-1414'
    fill_in 'What is your Organization\'s email?', with: 'email@bethesda.com'
    # find_by_id('organization_resource_category_ids_3').check
    check 'organization_resource_category_ids_1'
    # find(:css, "#rescatname1").set(true)
    fill_in 'Description', with: 'wicked cool description'
    choose 'organization_transportation_maybe'

    click_on 'commit'

    expect(page.body).to have_text('Application Submitted')
    expect(current_path).to eq organization_application_submitted_path
  end
end
