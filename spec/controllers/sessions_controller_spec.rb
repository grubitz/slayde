require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  it 'GET #new renders new template' do
    get :new
    expect(response).to render_template 'new'
  end

  context 'POST #create' do
    let(:user) { create(:user_confirmed, password: 'detective') }
    context 'for valid email' do
      it 'sets session to user.id if password valid' do
        post :create, params: { session: { password: 'detective', email: user.email } }
        expect(session[:user_id]).to eq user.id
      end
      it 'displays alert if password invalid' do
        post :create, params: { session: { password: 'perp', email: user.email } }
        expect(response).to redirect_to root_url
        expect(controller).to set_flash[:alert].to('Invalid password')
      end
      it 'redirects to root_url with proper notice' do
        post :create, params: { session: { password: 'detective', email: user.email } }
        expect(response).to redirect_to root_url
        expect(controller).to set_flash[:notice].to('Logged in')
      end
    end
    context 'for invalid email' do
      it 'redirects to root_url with proper alert' do
        post :create, params: { session: { password: 'detective', email: "#{user.email}#" } }
        expect(response).to redirect_to root_url
        expect(controller).to set_flash[:alert].to('Email not recognised')
      end
    end
  end

  context 'DELETE #destroy' do
    before do
      sign_in
    end

    it 'sets session to nil' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
    it 'redirects to root_url with proper alert' do
      delete :destroy
      expect(response).to redirect_to root_url
      expect(controller).to set_flash[:notice].to('Logged out')
    end
  end
end
