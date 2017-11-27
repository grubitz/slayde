require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  let(:user) { create(:user, password: 'milkstout') }

  before do
    sign_in
  end

  it '#edit render user update template' do
    get :edit
    expect(response).to render_template 'edit'
  end

  context 'for correct password' do

    it 'redirect to edit template' do

    end

    it 'displays alert' do

    end
  end

  it 'for incorrect password render edit template' do

  end
end
