require 'rails_helper'

RSpec.describe Contact, type: :model do
  context 'check validation of contact' do
    it 'is valid with valid attributes' do
      contact = FactoryBot.create(:valid_attributes)
      expect(contact).to be_valid
    end

    it 'is not valid with invalid attributes' do
      contact = FactoryBot.build(:invalid_attributes)
      expect(contact).not_to be_valid
    end
  end
end
