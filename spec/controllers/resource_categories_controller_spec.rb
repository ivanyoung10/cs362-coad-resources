require 'rails_helper'

#Ivan

#  PATCH    /resource_categories/:id/activate(.:format)               resource_categories#activate -- DONE
#  PATCH    /resource_categories/:id/deactivate(.:format)             resource_categories#deactivate -- DONE
#  GET      /resource_categories(.:format)                            resource_categories#index --DONE
#  POST     /resource_categories(.:format)                            resource_categories#create --DONE
#  GET      /resource_categories/new(.:format)                        resource_categories#new --Done
#  GET      /resource_categories/:id/edit(.:format)                   resource_categories#edit --Done
#  GET      /resource_categories/:id(.:format)                        resource_categories#show --DONE
#  PATCH    /resource_categories/:id(.:format)                        resource_categories#update --DONE
#  PUT      /resource_categories/:id(.:format)                        resource_categories#update --DONE
#  DELETE   /resource_categories/:id(.:format)                        resource_categories#destroy --DONE

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

    it { 
      edit_rc = FactoryBot.create(:resource_category)
      expect(get(:edit, params: { id: edit_rc.id })).to redirect_to new_user_session_path
    }

    it { 
        region = FactoryBot.create(:region)
        resource_category = FactoryBot.create(:resource_category)
        ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)

        get :show, params: { id: resource_category.id }
        expect(response).to redirect_to new_user_session_path
    }

    it {
      resource_category = FactoryBot.create(:resource_category)
      new_name = { name: "Updated Resource Category Name" }
    
      put :update, params: { id: resource_category.id, resource_category: new_name }
      resource_category.reload
    
      expect(response).to redirect_to new_user_session_path
    } 

    it {
      resource_category = FactoryBot.create(:resource_category)
      new_name = { name: "Updated Resource Category Name" }
    
      patch :update, params: { id: resource_category.id, resource_category: new_name }
      resource_category.reload
    
      expect(response).to redirect_to new_user_session_path
    } 

    it {
      resource_category = FactoryBot.create(:resource_category)
      patch :activate, params: { id: resource_category.id}
    
      expect(response).to redirect_to new_user_session_path
    } 

    it {
      resource_category = FactoryBot.create(:resource_category)
      patch :deactivate, params: { id: resource_category.id}
    
      expect(response).to redirect_to new_user_session_path
    } 

    it {
      resource_category = FactoryBot.create(:resource_category)
      
      delete :destroy, params: { id: resource_category.id }
      
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

    it { 
      edit_rc = FactoryBot.create(:resource_category)
      expect(get(:edit, params: { id: edit_rc.id })).to redirect_to dashboard_path
    }

    it { 
        region = FactoryBot.create(:region)
        resource_category = FactoryBot.create(:resource_category)
        ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)
        
        get :show, params: { id: resource_category.id }
        expect(response).to redirect_to dashboard_path
    }

    it {
      resource_category = FactoryBot.create(:resource_category)
      new_name = { name: "Updated Resource Category Name" }
    
      put :update, params: { id: resource_category.id, resource_category: new_name }
      resource_category.reload
    
      expect(response).to redirect_to dashboard_path
    } 

    it {
      resource_category = FactoryBot.create(:resource_category)
      new_name = { name: "Updated Resource Category Name" }
    
      patch :update, params: { id: resource_category.id, resource_category: new_name }
      resource_category.reload
    
      expect(response).to redirect_to dashboard_path
    } 

    it {
      resource_category = FactoryBot.create(:resource_category)
      patch :activate, params: { id: resource_category.id}
    
      expect(response).to redirect_to dashboard_path
    } 

    it {
      resource_category = FactoryBot.create(:resource_category)
      patch :deactivate, params: { id: resource_category.id}
    
      expect(response).to redirect_to dashboard_path
    }
    
    it {
      resource_category = FactoryBot.create(:resource_category)
      
      delete :destroy, params: { id: resource_category.id }
      
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
    it { 
      edit_rc = FactoryBot.create(:resource_category)
      expect(get(:edit, params: { id: edit_rc.id })).to be_successful
    }

    it { 
        region = FactoryBot.create(:region)
        resource_category = FactoryBot.create(:resource_category)
        ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)
        
        get :show, params: { id: resource_category.id }
        expect(response).to be_successful
    }

    it {
      resource_category = FactoryBot.create(:resource_category)
      new_name = { name: "Updated Resource Category Name" }
    
      put :update, params: { id: resource_category.id, resource_category: new_name }
      resource_category.reload
    
      expect(resource_category.name).to eq("Updated Resource Category Name")
      expect(response).to redirect_to resource_category
    } 

    it {
      resource_category = FactoryBot.create(:resource_category)
      new_name = { name: "Updated Resource Category Name" }
    
      patch :update, params: { id: resource_category.id, resource_category: new_name }
      resource_category.reload
    
      expect(resource_category.name).to eq("Updated Resource Category Name")
      expect(response).to redirect_to resource_category
    }

    it {
      resource_category = FactoryBot.create(:resource_category)
      patch :activate, params: { id: resource_category.id}
    
      expect(response).to redirect_to resource_category
    }

    it {
      resource_category = FactoryBot.create(:resource_category)
      patch :deactivate, params: { id: resource_category.id}
    
      expect(response).to redirect_to resource_category
    }

    it {
      resource_category = FactoryBot.create(:resource_category)
      
      delete :destroy, params: { id: resource_category.id }
      
      expect(response).to redirect_to resource_categories_path
    }

  end
end
