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
# PATCH        /organizations/:id(.:format)                   organizations#update -- DONE
# PUT          /organizations/:id(.:format)                   organizations#update -- DONE
# DELETE       /organizations/:id(.:format)                   organizations#destroy -- NOT IN ORG_CTRL?

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
      approved_user = FactoryBot.create(:user, :organization_approved)

      approved_organization = FactoryBot.create(:organization, :organization_approved)

      new_name = { name: "Updated Org Name" }
    
      put :update, params: { id: approved_organization.id, organization: new_name }
      approved_organization.reload
    
      expect(approved_organization.name).to redirect_to new_user_session_path
    end

    it "tests update PATCH" do
      approved_user = FactoryBot.create(:user, :organization_approved)

      approved_organization = FactoryBot.create(:organization, :organization_approved)

      new_name = { name: "Updated Org Name" }
    
      patch :update, params: { id: approved_organization.id, organization: new_name }
      approved_organization.reload
    
      expect(approved_organization.name).to redirect_to new_user_session_path
    end
  end

  #### =============================================================================================== ####

  describe 'logged in user' do
    let(:organization) { FactoryBot.create(:organization) }
    let(:user) { create(:user) }
    
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
      admin = FactoryBot.create(:user, :admin)

      # region = build(:region)
      # allow(Region).to receive(:new).and_return(region)
      # allow(region).to receive(:save).and_return(false) 

      # admin = build(:user, :admin)
      # organization = build(:organization)
      # allow(UserMailer).to receive(:with).and_return(admin)
      # allow(UserMailer).to receive(:new_organization_application).and_return(organization)
    
      post :create, params: { organization: FactoryBot.attributes_for(:organization),
                              user: FactoryBot.attributes_for(:user, :organization_unapproved) }
    
      expect(response).to redirect_to organization_application_submitted_path
    end

    it "tests new" do
      expect(get(:new)).to be_successful
    end

    it "tests update PUTS" do
      approved_user = FactoryBot.create(:user, :organization_approved)
      sign_in approved_user

      approved_organization = FactoryBot.create(:organization, :organization_approved)

      new_name = { name: "Updated Org Name" }
    
      put :update, params: { id: approved_organization.id, organization: new_name }
      approved_organization.reload
    
      expect(approved_organization.name).to eq("Updated Org Name")
      expect(response).to redirect_to organization_path(approved_organization.id)
    end

    it "tests update PATCH" do
      approved_user = FactoryBot.create(:user, :organization_approved)
      sign_in approved_user

      approved_organization = FactoryBot.create(:organization, :organization_approved)

      new_name = { name: "Updated Org Name" }
    
      patch :update, params: { id: approved_organization.id, organization: new_name }
      approved_organization.reload
    
      expect(approved_organization.name).to eq("Updated Org Name")
      expect(response).to redirect_to organization_path(approved_organization.id)
    end
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
      approved_user = FactoryBot.create(:user, :admin, :organization_approved)
      sign_in approved_user

      approved_organization = FactoryBot.create(:organization, :organization_approved)

      new_name = { name: "Updated Org Name" }
    
      put :update, params: { id: approved_organization.id, organization: new_name }
      approved_organization.reload
    
      expect(approved_organization.name).to eq("Updated Org Name")
      expect(response).to redirect_to organization_path(approved_organization.id)
    end

    it "tests update PATCH" do
      approved_user = FactoryBot.create(:user, :admin, :organization_approved)
      sign_in approved_user

      approved_organization = FactoryBot.create(:organization, :organization_approved)

      new_name = { name: "Updated Org Name" }
    
      patch :update, params: { id: approved_organization.id, organization: new_name }
      approved_organization.reload
    
      expect(approved_organization.name).to eq("Updated Org Name")
      expect(response).to redirect_to organization_path(approved_organization.id)
    end
  end
end
