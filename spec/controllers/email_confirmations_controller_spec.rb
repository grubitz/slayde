require 'rails_helper'

RSpec.describe EmailConfirmationsController, type: :controller do

  context 'for correct token' do
    let(:user) { create(:user) }

    it 'confirms email' do
      expect_any_instance_of(User).to receive(:confirm!)
      get :confirm, params: { token: user.confirmation_token }
    end

    it 'redirects to root' do
      get :confirm, params: { token: user.confirmation_token }
      expect(response).to redirect_to root_url
    end

    it 'shows notice' do
      get :confirm, params: { token: user.confirmation_token }
      expect(controller).to set_flash[:notice].to(/#{Regexp.escape(user.email)}/)
    end
  end


  context 'for incorrect token' do
    it 'raises exception' do
      get :confirm, params: { token: 'mindflyer' }
      expect(response).to redirect_to root_url
    end
  end
end
