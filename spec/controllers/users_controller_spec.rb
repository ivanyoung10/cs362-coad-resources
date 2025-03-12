RSpec.describe UsersController, type: :controller do
  describe 'as a logged out user' do
    let(:user) { FactoryBot.create(:user) }

    it { expect(get(:index)).to redirect_to new_user_session_path }
  end

  describe 'as a logged in user' do
    let(:user) { FactoryBot.create(:user) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to redirect_to dashboard_path }
  end

  describe 'as an admin' do
    let(:user) { FactoryBot.create(:user, :admin) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to be_successful }
  end
end