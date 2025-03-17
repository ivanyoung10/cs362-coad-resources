require 'rails_helper'

RSpec.describe 'User registration', type: :feature do
  it 'allows a user to register' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Email address', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
