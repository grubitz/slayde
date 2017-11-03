require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without email' do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it 'is invalid with duplicate email' do
    create(:user, email: 'email@example.com')
    expect(build(:user, email: 'email@example.com')).not_to be_valid
  end

  it 'is invalid with duplicate email regardless case' do
    create(:user, email: 'email@example.com')
    expect(build(:user, email: 'EMAIL@EXAMPLE.COM')).not_to be_valid
  end

end