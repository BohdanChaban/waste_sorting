require 'rails_helper'

RSpec.describe User, type: :model do
  context 'check validation of user ' do
    let(:user) { build(:user) }

    it 'return invalid user' do
      expect(user).to be_valid
    end
  end

  context 'check validation of email ' do
    let(:user) { build(:user, email: 'bodia31@gmail.com') }
    let(:user_invalid_empty) { build(:user, email: '') }
    let(:user_invalid_short) { build(:user, email: 'qwe') }
    let(:user_invalid_format) { build(:user, email: '@vasiaa') }

    it 'return invalid email' do
      expect(user).to be_valid
    end

    it 'return invalid empty' do
      expect(user_invalid_empty).to be_invalid
    end

    it 'return invalid short' do
      expect(user_invalid_short).to be_invalid
    end

    it 'return invalid format' do
      expect(user_invalid_format).to be_invalid
    end
  end

  context 'check validation of role' do
    let(:user) { build(:user, role: 'admin') }
    let(:user_invalid_role) { build(:user, role: 'vasya') }

    it 'return invalid user' do
      expect(user).to be_valid
    end

    it 'return invalid role' do
      expect { build(user_invalid_role) }.to raise_error(ArgumentError)
    end
  end
end
