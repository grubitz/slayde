require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  it 'finds currently logged in user' do
    user = create(:user_confirmed)
    sign_in(user)
    expect(current_user).to eq(user)
  end

end
