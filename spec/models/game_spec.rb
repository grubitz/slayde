require 'rails_helper'

RSpec.describe Game, type: :model do

  it '#solution returns array of 9 elements' do
    expect(Game.riddle).to be_a_kind_of Array
    expect(Game.riddle.size).to eq 9
  end

  it '#check returns true for correct user_solution' do
    expect(Game.check(Game::SOLUTION)).to be_truthy
  end

  it '#check returns false for incorrect user_solution' do
    expect(Game.check(Game::SOLUTION.reverse)).to be_falsey
  end

end
