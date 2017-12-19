require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

  it 'GET #new renders new template' do
    get :new
    expect(response).to render_template 'new'
  end
  context 'POST #create' do
    context 'for valid email' do
      let(:user) { create(:user_confirmed) }
      it 'sends reset password email' do
        expect { post :create, params: { email: user.email } }
            .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
      it 'redirects to root_url with proper alert' do
        post :create, params: { email: user.email }
        expect(response).to redirect_to root_url
        expect(controller).to set_flash[:notice].to(/#{user.email}/)
      end
    end
    context 'for invalid email' do
      it 'does not send reset password email' do
        expect { post :create, params: { email: 'jake.peralta@nypd.com' } }
            .not_to change { ActionMailer::Base.deliveries.count }
      end
      it 'redirects to root_url with proper alert' do
        post :create, params: { email: 'jake.peralta@nypd.com' }
        expect(response).to redirect_to root_url
        expect(controller).to set_flash[:notice].to(/jake.peralta@nypd.com/)
      end
    end
  end
end
