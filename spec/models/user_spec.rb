require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

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

  it 'converts uppercase email to downcase on creation' do
    user = create(:user, email: 'EMAIL@EXAMPLE.COM')
    expect(user.email).to eq 'email@example.com'
  end

   it '#confirmed? returns true for confirmed user' do
    user =  create(:user_confirmed)
    expect(user.confirmed?).to be_truthy
  end

  it '#confirmed? returns false for not confirmed user' do
    expect(user.confirmed?).to be_falsey
  end

  it '#confirm! sets confirmed_at as a datetime' do
    expect(user.confirmed_at).to be_nil
    user.confirm!
    expect(user.confirmed_at).not_to be_nil
  end

  it '#confirm! sets confirmation_token as nullified' do
    expect(user.confirmation_token).not_to be_nil
    user.confirm!
    expect(user.confirmation_token).to be_nil
  end

  context '#send_reset_password!' do
    before do
      user.send_reset_password!
    end
    it 'generates token' do
      expect(user.reset_password_token).not_to be_nil
    end
    it 'sets reset_password_send_at to current time' do
      expect(user.reset_password_sent_at).not_to be_nil
    end
    it 'sends reset password email' do
      expect { user.send_reset_password! }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end


  it '#authenticate! raises error when user not confirmed' do
    expect { user.authenticate!('LetsPlayCatan') }
    .to raise_error(RuntimeError, 'User not confirmed')
  end

  it '#authenticate! raises error when invalid password' do
    user= create(:user_confirmed, password: 'LetsPlayCivilizationVI')
    expect { user.authenticate!('BetterNot!') }
    .to raise_error(RuntimeError, 'Invalid password')
  end

  it '#authenticate! does not raise errors for confirmed user and valid password' do
    user = create(:user_confirmed, password: 'ThisIsNotThePasswordYouAreLookingFor')
    expect { user.authenticate!('ThisIsNotThePasswordYouAreLookingFor') }.not_to raise_error
  end

  it 'generates token on creation' do
    expect(user.confirmation_token).not_to be_nil
  end

  it 'keeps generating token until token is unique' do
    allow(SecureRandom).to receive(:hex).and_return(user.confirmation_token, SecureRandom.hex)
    expect(User).to receive(:where).and_call_original.twice
    create(:user)
  end

  it 'sends confirmation email on creation' do
    expect { create(:user) }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it "doesn't send confirmation email on creation if user confirmed" do
    expect { create(:user_confirmed) }.not_to change { ActionMailer::Base.deliveries.count }
  end

  context '#update_with_password' do
    context 'with valid current password' do
      it 'update password if validation passes' do
        user = create(:user, password: 'breadandbutter')
        user.update_with_password({current_password: 'breadandbutter',
                                   password: 'rollypolly',
                                   password_confirmation: 'rollypolly' })
        expect(user.authenticate('rollypolly')).to be_truthy
      end

      it 'does not update password if validation fails' do
        user = create(:user_confirmed, password: 'breadandbutter')
        user.update_with_password({current_password: 'breadandbutter',
                                   password: 'rollypolly',
                                   password_confirmation: 'jollymolly' })
        user.reload
        expect(user.authenticate('rollypolly')).to be_falsey
        expect(user.authenticate('breadandbutter')).to be_truthy
      end
    end

    context 'with invalid current password' do
      it 'does not update password' do
        user = create(:user, password: 'breadandbutter')
        user.update_with_password({current_password: 'beansontoast',
                                   password: 'rollypolly',
                                   password_confirmation: 'rollypolly' })
        expect(user.authenticate('rollypolly')).to be_falsey
        expect(user.authenticate('breadandbutter')).to be_truthy
      end
    end
  end
end
