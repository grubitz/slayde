require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  let(:user) { create(:user, password: 'milkstout') }

  before do
    sign_in(user)
  end
  context 'GET #edit' do
    before do
      get :edit
    end
    it 'assigns @profile' do
      expect(assigns(:profile)).to eq user
    end

    it 'renders edit template' do
      expect(response).to render_template 'edit'
    end
  end

  context 'PATCH #update' do
    context 'for valid params' do
      it "redirect to edit template with 'changes saved' notice" do
        patch :update, params:
            { user: { email: user.email, current_password: 'milkstout',
                      password: 'doubleIPA', password_confirmation: 'doubleIPA'} }
        expect(response).to redirect_to edit_profile_url
        expect(controller).to set_flash[:notice]
      end
    end
    context 'for invalid params' do
      it 'renders edit template' do
        patch :update, params:
            { user: { email: user.email, current_password: 'porter',
                      password: 'rubyale', password_confirmation: 'lager'} }
        expect(response).to render_template 'edit'
      end
    end
  end
end
