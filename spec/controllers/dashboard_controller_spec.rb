# Rowan
require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { create(:user) }
  
  describe 'as a logged out user' do
    it 'tests index' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
    
  end

  describe 'as a logged in user' do
    before do
      sign_in user
    end

    it 'sets the correct status options' do
      get :index
      expect(controller.instance_variable_get(:@status_options)).to eq(['Open'])
    end
  end

  describe 'as a admin' do
    let(:admin) { create(:user, :admin) }

    before do
      sign_in admin
    end

    it 'tests index' do
      get :index
      expect(controller.instance_variable_get(:@status_options)).to eq(['Open', 'Captured', 'Closed'])
    end
  end

  describe 'as an organization' do
    let(:organization) { create(:organization, :approved) }
    let(:org_user) { create(:user, organization: organization) }

    before do
      sign_in org_user
    end

    it 'tests index' do
      get :index
      expect(controller.instance_variable_get(:@status_options)).to eq(['Open', 'My Captured', 'My Closed'])
    end
  end

end
