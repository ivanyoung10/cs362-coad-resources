require 'rails_helper'

#Ivan

#  PATCH    /resource_categories/:id/activate(.:format)               resource_categories#activate
#  PATCH    /resource_categories/:id/deactivate(.:format)             resource_categories#deactivate
#  GET      /resource_categories(.:format)                            resource_categories#index --DONE
#  POST     /resource_categories(.:format)                            resource_categories#create --DONE
#  GET      /resource_categories/new(.:format)                        resource_categories#new 
#  GET      /resource_categories/:id/edit(.:format)                   resource_categories#edit
#  GET      /resource_categories/:id(.:format)                        resource_categories#show
#  PATCH    /resource_categories/:id(.:format)                        resource_categories#update
#  PUT      /resource_categories/:id(.:format)                        resource_categories#update
#  DELETE / resource_categories/:id(.:format)                        resource_categories#destroy

RSpec.describe ResourceCategoriesController, type: :controller do
  describe 'as a logged out user' do
    let(:resource_category) { FactoryBot.create(:resource_category) }
    let(:user) { create(:user) }

    it { expect(get(:index)).to redirect_to new_user_session_path }
    it { expect(get(:new)).to redirect_to new_user_session_path }
    it {
      post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
      expect(response).to redirect_to new_user_session_path
    }
  end

  describe 'as a logged in user' do
    let(:resource_category) { FactoryBot.create(:resource_category) }
    let(:user) { create(:user) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to redirect_to dashboard_path }

    it { expect(get(:new)).to redirect_to dashboard_path }
    
    it {
      post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
      expect(response).to redirect_to dashboard_path
    }
  end

  describe 'as an admin' do
    let(:resource_category) { FactoryBot.create(:resource_category) }
    let(:user) { create(:user, :admin) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to be_successful }
    it { expect(get(:new)).to be_successful }
    it {
      post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
      expect(response).to redirect_to resource_categories_path
    }
  end
end
