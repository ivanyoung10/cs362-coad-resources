require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do
  before do
    @region = create(:region)
    @user = create(:user, :admin)
  end

  it 'it can be created from the home screen' do
    visit root_path

    log_in_as(@user)

    click_on 'Regions'
    click_on 'Add Region'

    fill_in 'Name', with: 'Test Name'
    click_on 'Add Region'

    expect(current_path).to eq regions_path

    expect(page.body).to have_text('Test Name')
  end
end
