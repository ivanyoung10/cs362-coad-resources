require 'rails_helper'

RSpec.describe 'Viewing a list of all users', type: :feature do
  before do
    @user = create(:user, :admin)
    @test_user1 = create(:user, email: "testuser1@example.com")
  end

  it "can be viewed" do
    visit root_path    
    log_in_as(@user)

    visit('/users/')

    expect(page.body).to have_text('testuser1@example.com')
  end
end