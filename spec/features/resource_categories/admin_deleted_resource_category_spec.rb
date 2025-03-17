require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do
  before do
    @resource_category = create(:resource_category)
    @user = create(:user, :admin)
  end

  it 'it can be deleted from the home screen' do
    visit root_path

    log_in_as(@user)

    click_on 'Categories'

    expect(current_path).to eq resource_categories_path

    click_on @resource_category.name

    click_on 'Delete'

    expect(current_path).to eq resource_categories_path
    expect(page.body).to have_text("#{@resource_category.name} was deleted")

  end
end
