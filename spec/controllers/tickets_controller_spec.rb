require 'rails_helper'
# POST   /tickets(.:format)                                                                       tickets#create  --DONE
# GET    /tickets/new(.:format)                                                                   tickets#new --DONE
# GET    /tickets/:id(.:format)                                                                   tickets#show
# GET    /ticket_submitted(.:format)                                                              static_pages#ticket_submitted
# GET    /organization_expectations(.:format)                                                     static_pages#organization_expectations
# POST   /tickets/:id/capture(.:format)                                                           tickets#capture
# POST   /tickets/:id/release(.:format)                                                           tickets#release
# PATCH  /tickets/:id/close(.:format)                                                             tickets#close

RSpec.describe TicketsController, type: :controller do
  describe 'as a logged out user' do
    let (:ticket) {FactoryBot.create(:ticket)}
    let(:user) { create(:user) }
    

    it { expect(get(:new)).to be_successful }

    it {
      post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
      expect(response).to be_successful
    }
  end

  describe 'as a logged in user' do
    let(:ticket) { FactoryBot.create(:ticket) }
    let(:user) { create(:user) }
    before(:each) { sign_in user }

    it { expect(get(:new)).to be_successful }

    # it {
    #   get :show, params: { id: ticket.id }
    #   expect(response).to redirect_to dashboard_path
    # }

    it {
      post(:create, params: { ticket: FactoryBot.attributes_for(:ticket) })
      expect(response).to be_successful
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

    # it {
    #   get :show, params: { id: ticket.id }
    #   expect(response).to be_successful
    # }
  end
end
