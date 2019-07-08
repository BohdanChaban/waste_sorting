require 'rails_helper'

RSpec.describe City, type: :model do
  context 'check validation of city' do
    it 'is valid with valid attributes' do
      city = FactoryBot.create(:valid_city)
      expect(city).to be_valid
    end

    it 'is not valid with invalid attributes' do
      city = FactoryBot.build(:valid_city, name: nil)
      expect(city).not_to be_valid
    end
  end

  context 'check validation of city name' do
    it 'is valid with name attributes' do
      city = FactoryBot.build(:valid_city, name: 'Бурштин')
      expect(city).to be_valid
    end

    it 'is valid with name include apostrophe' do
      city = FactoryBot.build(:valid_city, name: "Кам'янка")
      expect(city).to be_valid
    end

    it 'is valid with name include hyphen' do
      city = FactoryBot.build(:valid_city, name: 'Корсунь-Шевченківський')
      expect(city).to be_valid
    end

    it 'is not valid with latin letters' do
      city = FactoryBot.build(:valid_city, name: 'Lviv')
      expect(city).to be_invalid
    end

    it 'is not valid with special characters' do
      city = FactoryBot.build(:valid_city, name: "!#$%&'()*+,./:;<=>?@[]^_`{|}~")
      expect(city).to be_invalid
    end

    it 'is not valid with too long name' do
      city = FactoryBot.build(:valid_city, name: "Нікополь\tДніпропетровська область")
      expect(city).to be_invalid
    end

    it 'is not valid with too short name' do
      city = FactoryBot.build(:valid_city, name: 'Ба')
      expect(city).to be_invalid
    end

    it 'is not valid with digits' do
      city = FactoryBot.build(:valid_city, name: '123456')
      expect(city).to be_invalid
    end
  end

  context 'check already exist of city' do
    it 'should validate uniqueness of city name' do
      city1 = FactoryBot.create(:valid_city, name: 'Конотоп')
      city2 = FactoryBot.build(:valid_city, name: 'Конотоп')
      expect { city2.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
