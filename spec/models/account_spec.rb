require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'check validation of account ' do
    it 'is valid with valid attributes' do
      account = FactoryBot.create(:account)
      expect(account).to be_valid
    end

    it 'is not valid with invalid attributes' do
      account = FactoryBot.build(:invalid_account)
      expect(account).not_to be_valid
    end

    it 'is not valid with long name' do
      account = FactoryBot.build(:account_with_long_name)
      expect(account).to be_invalid
    end

    it 'is not valid with long surname' do
      account = FactoryBot.build(:account_with_long_surname)
      expect(account).to be_invalid
    end

    it 'is not valid with long adress' do
      account = FactoryBot.build(:account_with_long_address)
      expect(account).to be_invalid
    end

    it 'is not valid with long mobile number' do
      account = FactoryBot.build(:account_with_long_mobile_number)
      expect(account).to be_invalid
    end

    it 'is not valid with short mobile number' do
      account = FactoryBot.build(:account_with_short_mobile_number)
      expect(account).to be_invalid
    end
  end
end
