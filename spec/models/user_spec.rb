require 'rails_helper'

RSpec.describe User, type: :model do
  let(:default_role) { 'customer' }
  let(:not_inclusion_role) { 'vasya' }

  context 'check validation of user ' do
    it 'is valid with valid attributes' do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end

    it 'is not valid with invalid attributes' do
      user = FactoryBot.build(:user, email: nil, role: nil, password: nil)
      expect(user).not_to be_valid
    end
  end

  context 'check validation of email ' do
    it 'is not valid with short email' do
      user = FactoryBot.build(:invalid_user_with_short_email)
      expect(user).to be_invalid
    end

    it 'is not valid with long email' do
      user = FactoryBot.build(:invalid_user_with_long_email)
      expect(user).to be_invalid
    end

    it 'is valid with valid attributes' do
      user = FactoryBot.create(:user)
      expect(user.role).to eq default_role
    end
  end

  context 'check already exist of email' do
    it 'should validate uniqueness of email' do
      FactoryBot.create(:user)
      user2 = FactoryBot.build(:user)
      expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context 'check validation of role' do
    it 'is valid with role customer' do
      user = FactoryBot.create(:user_customer)
      expect(user).to be_valid
    end

    it 'is valid with role manager' do
      user = FactoryBot.create(:user_manager)
      expect(user).to be_valid
    end

    it 'is valid with role admin' do
      user = FactoryBot.create(:user_admin)
      expect(user).to be_valid
    end

    it 'is not allow not inclusion value in the role' do
      user = FactoryBot.create(:user)
      expect { user.role = not_inclusion_role }.to raise_error(ArgumentError)
    end
  end
end
