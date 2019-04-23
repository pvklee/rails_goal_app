require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryBot.build(:user,
      username: 'username',
      password: 'password')
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  it 'creates a password_digest when password is given' do
    expect(user.password_digest).to_not be(nil)
  end

  it 'creates a session_token before validation' do
    expect(user.session_token).to_not be(nil)
  end

  describe '#is_password?' do
    it 'verifies a password is correct' do
      expect(user.is_password?('password')).to be true
    end
    it 'verifies a password is not correct' do
      expect(user.is_password?('wrong_password')).to be false
    end
  end

  describe '#reset_session_token!' do
    it 'generates a new session token' do
      original_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not be(original_session_token)
    end

    it 'returns session token after creating' do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  describe '::find_by_credentials' do
    before {user.save!}

    it 'returns user if given matching credentials' do
      expect(User.find_by_credentials('username', 'password')).to eq(user)
    end

    it 'returns nil if given wrong credentials' do
      expect(User.find_by_credentials('username', 'wrongpassword')).to eq(nil)
    end
  end

end
