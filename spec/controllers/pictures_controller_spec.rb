require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  let(:valid_params) {
    { picture: { image: fixture_file_upload('files/saul.jpg'), name: 'test-picture' } }
  }

  it 'GET #new renders new template' do
    sign_in
    get :new
    expect(response).to render_template 'new'
  end

  context '#POST create' do

    context 'for user' do
      let (:user) { create(:user) }
      before do
        sign_in(user)
      end
      it 'redirects to root_url with proper alert' do
        post :create, params: valid_params
        expect(response).to redirect_to root_url
        expect(controller).to set_flash[:notice]
      end

      it 'creates picture record' do
        expect{ post :create, params: valid_params }.to change { Picture.count }.by(1)
      end

      it 'creates record associated with current user' do
        post :create, params: valid_params
        picture = Picture.last
        expect(picture.user).to eq user
      end

      it 'renders new template for invalid params' do
        post :create, params: { picture:
                                     { image: fixture_file_upload('files/taxationistheft.jpg'),
                                       name: 'test-picture-fail' } }
        expect(response).to render_template 'new'
      end

    end

    context 'for admin' do
      let(:admin) { create(:admin) }

      before do
        sign_in(admin)
      end

      it 'redirects to root_url with proper alert' do
        post :create, params: valid_params
        expect(response).to redirect_to root_url
        expect(controller).to set_flash[:notice]
      end

      it 'creates picture record' do
        expect{ post :create, params: valid_params }.to change { Picture.count }.by(1)
      end

      it 'creates record not associated with any user' do
        post :create, params: valid_params
        picture = Picture.last
        expect(picture.user).to be_nil
      end

      it 'renders new template for invalid params' do
        post :create, params: { picture:
                                    { image: fixture_file_upload('files/taxationistheft.jpg'),
                                      name: 'test-picture-fail' } }
        expect(response).to render_template 'new'
      end

    end

  end
end
