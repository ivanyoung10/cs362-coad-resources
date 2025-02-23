# Rowan
require 'rails_helper'
# TYPE    URI Pattern                       FUNCTION

# GET    /regions(.:format)                 regions#index -- DONE
# POST   /regions(.:format)                 regions#create -- DONE
# GET    /regions/new(.:format)             regions#new -- DONE
# GET    /regions/:id/edit(.:format)        regions#edit -- DONE
# GET    /regions/:id(.:format)             regions#show -- DONE
# PATCH  /regions/:id(.:format)             regions#update -- DONE
# PUT    /regions/:id(.:format)             regions#update -- DONE
# DELETE /regions/:id(.:format)             regions#destroy -- DONE

RSpec.describe RegionsController, type: :controller do

  describe 'as a logged out user' do
    let(:user) { FactoryBot.create(:user) }

    it { expect(get(:index)).to redirect_to new_user_session_path }

    it {
      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to new_user_session_path
    }

    it {
      region = build(:region)
      allow(Region).to receive(:new).and_return(region)
      allow(region).to receive(:save).and_return(false)

      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to new_user_session_path
    }

    it { expect(get(:new)).to redirect_to new_user_session_path }

    it { 
      edit_region = FactoryBot.create(:region)
      expect(get(:edit, params: { id: edit_region.id })).to redirect_to new_user_session_path
    }

    it "tests show" do
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)

      get :show, params: { id: region.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "tests update PUTS" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }
    
      put :update, params: { id: region.id, region: new_name }
      region.reload
    
      expect(response).to redirect_to new_user_session_path
    end

    it "tests update fail state PUTS" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }

      allow_any_instance_of(Region).to receive(:update).and_return(false)

      put :update, params: { id: region.id, region: new_name }

      expect(response).to redirect_to new_user_session_path
    end

    it "tests update PATCH" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }
    
      patch :update, params: { id: region.id, region: new_name }
      region.reload
    
      expect(response).to redirect_to new_user_session_path
    end

    it "tests update fail state PATCH" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }

      allow_any_instance_of(Region).to receive(:update).and_return(false)

      patch :update, params: { id: region.id, region: new_name }

      expect(response).to redirect_to new_user_session_path
    end

    it "tests destroy" do
      region = FactoryBot.create(:region)
      
      delete :destroy, params: { id: region.id }
      
      expect(response).to redirect_to new_user_session_path
    end

  end

  #### =============================================================================================== ####

  describe 'as a logged in user' do
    let(:user) { FactoryBot.create(:user) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to redirect_to dashboard_path }

    it {
      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to dashboard_path
    }

    it {
      region = build(:region)
      allow(Region).to receive(:new).and_return(region)
      allow(region).to receive(:save).and_return(false)

      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to dashboard_path
    }

    it { expect(get(:new)).to redirect_to dashboard_path }

    it { 
      edit_region = FactoryBot.create(:region)
      expect(get(:edit, params: { id: edit_region.id })).to redirect_to dashboard_path
    }

    it "tests show" do
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)

      get :show, params: { id: region.id }
      expect(response).to redirect_to dashboard_path
    end

    it "tests update PUTS" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }
    
      put :update, params: { id: region.id, region: new_name }
      region.reload
    
      expect(response).to redirect_to dashboard_path
    end

    it "tests update fail state PUTS" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }

      allow_any_instance_of(Region).to receive(:update).and_return(false)

      put :update, params: { id: region.id, region: new_name }

      expect(response).to redirect_to dashboard_path
    end

    it "tests update PATCH" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }
    
      patch :update, params: { id: region.id, region: new_name }
      region.reload
    
      expect(response).to redirect_to dashboard_path
    end

    it "tests update fail state PATCH" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }

      allow_any_instance_of(Region).to receive(:update).and_return(false)

      patch :update, params: { id: region.id, region: new_name }

      expect(response).to redirect_to dashboard_path
    end

    it "tests destroy" do
      region = FactoryBot.create(:region)
      
      delete :destroy, params: { id: region.id }
      
      expect(response).to redirect_to dashboard_path
    end
  end

  #### =============================================================================================== ####

  describe 'as an admin' do
    let(:user) { FactoryBot.create(:user, :admin) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to be_successful }

    it {
      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to regions_path
    }

    it {
      # allow_any_instance_of(Region).to receive(:save).and_return(false) # bad, but effective

      # the better way
      region = build(:region)
      allow(Region).to receive(:new).and_return(region)
      allow(region).to receive(:save).and_return(false)

      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to be_successful
    }

    it { expect(get(:new)).to be_successful }

    it { 
      edit_region = FactoryBot.create(:region)

      expect(get(:edit, params: { id: edit_region.id })).to be_successful
    }

    it "tests show" do
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)

      get :show, params: { id: region.id }
      expect(response).to be_successful
    end

    it "tests update PUTS" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }
    
      put :update, params: { id: region.id, region: new_name }
      region.reload
    
      expect(region.name).to eq("Updated Region Name")
      expect(response).to redirect_to region
    end

    it "tests update fail state PUTS" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }

      allow_any_instance_of(Region).to receive(:update).and_return(false)

      put :update, params: { id: region.id, region: new_name }

      expect(response).to be_successful
    end

    it "tests update PATCH" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }
    
      patch :update, params: { id: region.id, region: new_name }
      region.reload
    
      expect(region.name).to eq("Updated Region Name")
      expect(response).to redirect_to region
    end

    it "tests update fail state PATCH" do
      region = FactoryBot.create(:region)
      new_name = { name: "Updated Region Name" }

      allow_any_instance_of(Region).to receive(:update).and_return(false)

      patch :update, params: { id: region.id, region: new_name }

      expect(response).to be_successful
    end

    it "tests destroy" do
      region = FactoryBot.create(:region)
      
      delete :destroy, params: { id: region.id }
      
      expect(response).to redirect_to regions_path
    end
  end
end