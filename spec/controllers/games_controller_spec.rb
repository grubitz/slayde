require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  before do
    sign_in
  end
  it '#new responds with correct json' do
    get :new
    expect(JSON.parse(response.body)).to be_a_kind_of Array
    expect(JSON.parse(response.body).size).to eq 9
  end

  it '#check http status ok for correct solution' do
    post :check, params: { solution: Game::SOLUTION }
    expect(response).to have_http_status :ok
  end

  it '#check http status 422 for incorrect solution' do
    post :check, params: { solution: Game::SOLUTION.reverse }
    expect(response).to have_http_status :unprocessable_entity
  end
end
