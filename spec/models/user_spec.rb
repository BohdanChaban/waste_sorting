require 'rails_helper'

RSpec.describe User, type: :model do
  let(:short_email) { 'email' }
  let(:long_email)  { short_email * 30 }
  let(:default_role) { 'customer' }
  let(:inclusion_role) { %w[customer manager admin] }
  let(:not_inclusion_role) { 'vasya' }
  let(:valid_email) { 'bodia@gmail.com' }

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
    it 'is valid with email attributes' do
      user = FactoryBot.build(:user, email: valid_email)
      expect(user).to be_valid
    end

    it 'is not valid with short email' do
      user = FactoryBot.build(:user, email: short_email)
      expect(user).to be_invalid
    end

    it 'is not valid with long email' do
      user = FactoryBot.build(:user, email: long_email)
      expect(user).to be_invalid
    end

    it 'is valid with valid attributes' do
      user = FactoryBot.create(:user)
      expect(user.role).to eq default_role
    end

    it 'is allow inclusion value in the role' do
      user = FactoryBot.create(:user)
      inclusion_role.each do |role|
        user.role = role
        expect(user).to be_valid
      end
    end
    it 'is not allow not inclusion value in the role' do
      user = FactoryBot.create(:user)
      expect { user.role = not_inclusion_role }.to raise_error(ArgumentError)
    end
  end

  context 'check already exist of email' do
    it 'should validate uniqueness of email' do
      user1 = FactoryBot.create(:user, email: valid_email)
      user1.save
      user2 = FactoryBot.build(:user, email: valid_email)
      expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
