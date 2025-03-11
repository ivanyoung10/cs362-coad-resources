require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do
  before do
    @region = create(:region)
    @user = create(:user, :admin)
  end

  it "tests deleting region from the home screen" do
    visit root_path

    log_in_as(@user)

    click_on 'Regions'
    click_on @region.name

    click_on 'Delete'

    expect(current_path).to eq regions_path
    expect(page.body).to have_text("Region #{@region.name} was deleted")
  end
end
