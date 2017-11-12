require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  context 'for unauthorized user' do
    context 'GET #new' do
      before do
        get :new
      end
      it 'assigns @user' do
        expect(assigns(:user)).to be_a_kind_of User
      end

      it 'renders new template' do
        expect(response).to render_template 'new'
      end
    end

    context 'POST #create' do
      context 'with valid attributes' do
        let(:valid_attributes) {
          { user: {
              email: 'jane@eleven.net',
              password: 'killdemodogs',
              password_confirmation: 'killdemodogs'
          } }
        }

        it 'creates a User record' do
          expect {
            post :create, params: valid_attributes
          }.to change {
            User.count
          }.by(1)
        end

        it 'redirects to login screen' do
          post :create, params: valid_attributes
          expect(response).to redirect_to new_session_url
        end

        it 'shows flash message containing email' do
          post :create, params: valid_attributes
          expect(controller).to set_flash[:notice].to(/jane@eleven\.net/)
        end
      end

      context 'with invalid attributes' do
        let(:invalid_attributes) {
          { user: {
              email: 'demogorgon',
              password: 'upside',
              password_confirmation: 'down'
          } }
        }
        it "doesn't create User record" do
          expect { post :create, params: invalid_attributes }.not_to change { User.count }
        end

        it 'renders registration form' do
          post :create, params: invalid_attributes
          expect(response).to render_template 'new'
        end
      end
    end
  end

  context 'for authorized user' do
    before do
      user = create(:user)
      session[:user_id] = user.id
    end

    it 'GET #new redirects to root_url' do
      get :new
      expect(response).to redirect_to root_url
    end

    it 'POST #create redirects to root_url' do
      post :create
      expect(response).to redirect_to root_url
    end
  end
end
