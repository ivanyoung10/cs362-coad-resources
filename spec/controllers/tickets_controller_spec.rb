require 'rails_helper'
# POST   /tickets(.:format)                                                                       tickets#create  --DONE
# GET    /tickets/new(.:format)                                                                   tickets#new --DONE
# GET    /tickets/:id(.:format)                                                                   tickets#show --DONE
# GET    /ticket_submitted(.:format)                                                              static_pages#ticket_submitted -- N/A
# GET    /organization_expectations(.:format)                                                     static_pages#organization_expectations -- N/A
# POST   /tickets/:id/capture(.:format)                                                           tickets#capture -- DONE
# POST   /tickets/:id/release(.:format)                                                           tickets#release --DONE
# PATCH  /tickets/:id/close(.:format)                                                             tickets#close --DONE

RSpec.describe TicketsController, type: :controller do
  describe 'as a logged out user' do
    let (:ticket) {FactoryBot.create(:ticket)}
    let(:user) { create(:user) }
    

    it { expect(get(:new)).to be_successful }

    it {
      post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
      expect(response).to be_successful
    }

    it {
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)\

      post(:capture, params: { id: ticket.id})
      expect(response).to redirect_to dashboard_path
    }

    it {
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)\

      post(:release, params: { id: ticket.id})
      expect(response).to redirect_to dashboard_path
    }



  end

  describe 'as a logged in user' do
    let(:ticket) { FactoryBot.create(:ticket) }
    let(:user) { create(:user) }
    before(:each) { sign_in user }

    it { expect(get(:new)).to be_successful }

    it {
      post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
      expect(response).to be_successful
    }

    it { 
        region = FactoryBot.create(:region)
        resource_category = FactoryBot.create(:resource_category)
        ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)

        get :show, params: { id: ticket.id }
        expect(response).to redirect_to dashboard_path
    }

    it {
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)
      patch :close, params: { id: ticket.id}
    
      expect(response).to redirect_to dashboard_path
    } 

    it {
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)\

      post(:capture, params: { id: ticket.id})
      expect(response).to redirect_to dashboard_path
    }

    it {
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)\

      post(:release, params: { id: ticket.id})
      expect(response).to redirect_to dashboard_path
    }
    
  end

  describe 'as an admin' do
    let(:ticket) { FactoryBot.create(:ticket) }
    let(:user) { create(:user, :admin) }
    before(:each) { sign_in user }

    it { expect(get(:new)).to be_successful }

    it {
      post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
      expect(response).to be_successful
    }

    it { 
        region = FactoryBot.create(:region)
        resource_category = FactoryBot.create(:resource_category)
        ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)

        get :show, params: { id: ticket.id }
        expect(response).to be_successful
    }

    it {
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)
      patch :close, params: { id: ticket.id}
    
      expect(response).to redirect_to dashboard_path << '#tickets:open'
    }

    it {
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)\

      post(:capture, params: { id: ticket.id})
      expect(response).to redirect_to dashboard_path
    }

    it {
      region = FactoryBot.create(:region)
      resource_category = FactoryBot.create(:resource_category)
      ticket = FactoryBot.create(:ticket, region: region, resource_category: resource_category)\

      post(:release, params: { id: ticket.id})
      expect(response).to redirect_to dashboard_path
    }
  end

  
end
