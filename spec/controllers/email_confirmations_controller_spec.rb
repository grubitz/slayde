require 'rails_helper'

RSpec.describe EmailConfirmationsController, type: :controller do

  describe "GET #confirm" do
    it "returns http success" do
      get :confirm
      expect(response).to have_http_status(:success)
    end
  end

end
