# Rowan
require 'rails_helper'

# TYPE         URI Pattern                                    FUNCTION
# POST         /organizations/:id/approve(.:format)           organizations#approve -- DONE
# POST         /organizations/:id/reject(.:format)            organizations#reject -- DONE
# GET          /organizations/:id/resources(.:format)         organizations#resources -- NOT IN ORG_CTRL?
# GET          /organizations(.:format)                       organizations#index -- DONE
# POST         /organizations(.:format)                       organizations#create -- DONE
# GET          /organizations/new(.:format)                   organizations#new -- DONE
# GET          /organizations/:id/edit(.:format)              organizations#edit -- N/A
# GET          /organizations/:id(.:format)                   organizations#show -- N/A
# PATCH        /organizations/:id(.:format)                   organizations#update
# PUT          /organizations/:id(.:format)                   organizations#update
# DELETE       /organizations/:id(.:format)                   organizations#destroy

RSpec.describe OrganizationsController, type: :controller do
  describe 'logged out user' do
    let(:organization) { FactoryBot.create(:organization) }
    let(:user) { create(:user) }

    it "tests approve" do
      post :approve, params: {id: organization.id }

      expect(response).to redirect_to new_user_session_path
    end

    it "tests reject" do
      rejection_reason = "Bad Vibes"

      post :reject, params: { id: organization.id, organization: { rejection_reason: rejection_reason } }

      organization.reload

      expect(response).to redirect_to new_user_session_path
    end

    # it 'logged out user cannot access show' do
    #   get :show, params: { id: organization.id }
    #   expect(response).to redirect_to new_user_session_path
    # end

    it "tests index" do
      expect(get(:index)).to redirect_to new_user_session_path
    end

    it "tests create" do
      admin = FactoryBot.create(:user, :admin)
      
      post :create, params: { organization: FactoryBot.attributes_for(:organization),
                              user: FactoryBot.attributes_for(:user) }

      expect(response).to redirect_to new_user_session_path
    end

    it "tests new" do
      expect(get(:new)).to redirect_to new_user_session_path
    end

    it "tests update PUTS" do
      new_name = { name: "Updated Org Name" }
    
      put :update, params: { id: organization.id, organization: new_name }
      organization.reload
    
      expect(response).to redirect_to new_user_session_path
    end
  end

  #### =============================================================================================== ####

  describe 'logged in user' do
    let(:organization) { FactoryBot.create(:organization) }
    let(:user) { create(:user) }
    let(:approved_organization) { create(:organization, status: :approved) }
    let(:org_user) { create(:user, organization: organization) }
    before(:each) { sign_in user }
    
    it "tests approve" do
      post :approve, params: {id: organization.id }

      expect(response).to redirect_to dashboard_path
    end

    it "tests reject" do
      rejection_reason = "Bad Vibes"

      post :reject, params: { id: organization.id, organization: { rejection_reason: rejection_reason } }

      organization.reload

      expect(response).to redirect_to dashboard_path
    end

    # not sure this is right...? It passes at least
    # it 'disallow user to access show' do
    #   get :show, params: { id: organization.id }
    #   expect(response).to redirect_to dashboard_path
    # end

    it "tests index" do
      expect(get(:index)).to be_successful
    end

    it "tests create" do
      # admin to recieve email, but no idea how to test if email actually gets sent
      admin = FactoryBot.create(:user, :admin)
    
      post :create, params: { organization: FactoryBot.attributes_for(:organization),
                              user: FactoryBot.attributes_for(:user, :organization_unapproved) }
    
      expect(response).to redirect_to organization_application_submitted_path
    end

    it "tests new" do
      expect(get(:new)).to be_successful
    end

    # it "tests update PUTS" do
    #   new_name = { name: "Updated Org Name" }
    
    #   put :update, params: { id: approved_organization.id, approved_organization: new_name }
    #   approved_organization.reload
    
    #   expect(approved_organization.name).to eq("Updated Org Name")
    #   expect(response).to redirect_to organization_path(approved_organization.id)
    # end
  end

  #### =============================================================================================== ####

  describe 'as an admin user' do
    let(:organization) { FactoryBot.create(:organization) }
    let(:user) { create(:user, :admin) }
    before(:each) { sign_in user }
    
    it "tests approve" do
      post :approve, params: {id: organization.id }

      expect(response).to redirect_to organizations_path
    end

    it "tests reject" do
      rejection_reason = "Bad Vibes"

      post :reject, params: { id: organization.id, organization: { rejection_reason: rejection_reason } }

      organization.reload

      expect(organization.rejection_reason).to eq(rejection_reason)
      expect(response).to redirect_to organizations_path
    end

    # feel like this should redirect to dashboard going off all the before_actions
    # not sure I understand those fully
    # it 'allows admin to access show' do
    #   get :show, params: { id: organization.id }
    #   expect(response).to be_successful
    # end

    it "tests index" do
      expect(get(:index)).to be_successful
    end

    it "tests create" do
      admin = FactoryBot.create(:user, :admin)

      post :create, params: { organization: FactoryBot.attributes_for(:organization),
                              user: FactoryBot.attributes_for(:user) }

      expect(response).to redirect_to dashboard_path
    end

    it "tests new" do
      expect(get(:new)).to redirect_to dashboard_path
    end

    it "tests update PUTS" do
      new_name = { name: "Updated Org Name" }
    
      put :update, params: { id: organization.id, organization: new_name }
      organization.reload
    
      expect(response).to redirect_to dashboard_path
    end
    

  end
end
