require 'rails_helper'

RSpec.describe District, type: :model do
  context 'Associations' do
    it 'belongs to city' do
      assc = described_class.reflect_on_association(:city)
      expect(assc.macro).to eq :belongs_to
    end
  end

  context 'check validation of district' do
    it 'is valid with valid attributes' do
      district = FactoryBot.create(:district_valid_name)
      expect(district).to be_valid
    end

    it 'is not valid with invalid attributes' do
      district = FactoryBot.build(:district_invalid_name)
      expect(district).not_to be_valid
    end
  end

  context 'check validation of district name' do
    it 'is valid with name include apostrophe' do
      district = FactoryBot.build(:district_name_with_apostrophe)
      expect(district).to be_valid
    end

    it 'is valid with name include hyphen' do
      district = FactoryBot.build(:district_name_with_hyphen)
      expect(district).to be_valid
    end

    it 'is not valid with latin letters' do
      district = FactoryBot.build(:district_name_latin)
      expect(district).to be_invalid
    end

    it 'is not valid with special characters' do
      district = FactoryBot.build(:district_name_spec_char)
      expect(district).to be_invalid
    end

    it 'is not valid with too long name' do
      district = FactoryBot.build(:district_name_long)
      expect(district).to be_invalid
    end

    it 'is not valid with too short name' do
      district = FactoryBot.build(:district_name_short)
      expect(district).to be_invalid
    end

    it 'is not valid with digits' do
      district = FactoryBot.build(:district_name_with_digits)
      expect(district).to be_invalid
    end
  end

  context 'check capitalize district name' do
    it 'is valid with capitalized letter' do
      district = FactoryBot.create(:district_name_downcase)
      district = FactoryBot.build(:district_name_upcase, city_id: district.city_id)
      expect { district.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'check already exist of district' do
    it 'is validate uniqueness of district name' do
      district = FactoryBot.create(:district_valid_name)
      district = FactoryBot.build(:district_valid_name, city_id: district.city_id)
      expect { district.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
