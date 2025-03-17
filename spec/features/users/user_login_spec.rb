require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
  before do
    @user = create(:user, :admin)
  end

  it 'logs in a user' do
    log_in_as(@user)
    expect(page).to have_content('Signed in successfully')
  end
end
