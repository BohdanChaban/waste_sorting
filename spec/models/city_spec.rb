require 'rails_helper'

RSpec.describe City, type: :model do
  context 'check validation of city' do
    it 'is valid with valid attributes' do
      city = FactoryBot.create(:valid_city)
      expect(city).to be_valid
    end

    it 'is not valid with invalid attributes' do
      city = FactoryBot.build(:invalid_city)
      expect(city).not_to be_valid
    end
  end

  context 'check validation of city name' do
    it 'is valid with valid name' do
      city = FactoryBot.build(:valid_name)
      expect(city).to be_valid
    end

    it 'is valid with name include apostrophe' do
      city = FactoryBot.build(:valid_name_with_apostrophe)
      expect(city).to be_valid
    end

    it 'is valid with name include hyphen' do
      city = FactoryBot.build(:valid_name_with_hyphen)
      expect(city).to be_valid
    end

    it 'is not valid with latin letters' do
      city = FactoryBot.build(:not_valid_name_with_latin)
      expect(city).to be_invalid
    end

    it 'is not valid with special characters' do
      city = FactoryBot.build(:not_valid_name_with_spec_char)
      expect(city).to be_invalid
    end

    it 'is not valid with too long name' do
      city = FactoryBot.build(:not_valid_name_long)
      expect(city).to be_invalid
    end

    it 'is not valid with too short name' do
      city = FactoryBot.build(:not_valid_name_short)
      expect(city).to be_invalid
    end

    it 'is not valid with digits' do
      city = FactoryBot.build(:not_valid_name_digits)
      expect(city).to be_invalid
    end
  end

  context 'check already exist of city' do
    it 'should validate uniqueness of city name' do
      FactoryBot.create(:valid_city)
      city2 = FactoryBot.build(:valid_city)
      expect { city2.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
