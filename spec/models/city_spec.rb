require 'rails_helper'

RSpec.describe City, type: :model do
  context 'check validation of city' do
    it 'is valid with valid attributes' do
      city = FactoryBot.create(:city_with_valid_name)
      expect(city).to be_valid
    end

    it 'is not valid with invalid attributes' do
      city = FactoryBot.build(:city_with_invalid_name)
      expect(city).not_to be_valid
    end
  end

  context 'check validation of city name' do
    it 'is valid with name include apostrophe' do
      city = FactoryBot.build(:city_name_with_apostrophe)
      expect(city).to be_valid
    end

    it 'is valid with name include hyphen' do
      city = FactoryBot.build(:city_name_with_hyphen)
      expect(city).to be_valid
    end

    it 'is not valid with latin letters' do
      city = FactoryBot.build(:city_name_latin)
      expect(city).to be_invalid
    end

    it 'is not valid with special characters' do
      city = FactoryBot.build(:city_name_spec_char)
      expect(city).to be_invalid
    end

    it 'is not valid with too long name' do
      city = FactoryBot.build(:city_name_long)
      expect(city).to be_invalid
    end

    it 'is not valid with too short name' do
      city = FactoryBot.build(:city_name_short)
      expect(city).to be_invalid
    end

    it 'is not valid with digits' do
      city = FactoryBot.build(:city_name_with_digits)
      expect(city).to be_invalid
    end
  end

  context 'check capitalize city name' do
    it 'is valid with capitalized letter' do
      FactoryBot.create(:city_name_downcase)
      city = FactoryBot.build(:city_name_upcase)
      expect { city.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'check already exist of city' do
    it 'is validate uniqueness of city name' do
      FactoryBot.create(:city_with_valid_name)
      city = FactoryBot.build(:city_with_valid_name)
      expect { city.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
