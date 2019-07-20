require 'rails_helper'

RSpec.describe Contact, type: :model do
  context 'check validation of contact' do
    it 'is valid with valid attributes' do
      contact = FactoryBot.create(:valid_attributes)
      expect(contact).to be_valid
    end
    context 'is not valid with invalid attributes' do
      it 'name' do
        contact = FactoryBot.build(:invalid_name)
        expect(contact).not_to be_valid
      end
      it 'address' do
        contact = FactoryBot.build(:invalid_address)
        expect(contact).not_to be_valid
      end
      it 'email' do
        contact = FactoryBot.build(:invalid_email)
        expect(contact).not_to be_valid
      end
      it 'mobile_number' do
        contact = FactoryBot.build(:invalid_mobile_number)
        expect(contact).not_to be_valid
      end
      it 'facebook' do
        contact = FactoryBot.build(:invalid_facebook)
        expect(contact).not_to be_valid
      end
      it 'instagram' do
        contact = FactoryBot.build(:invalid_instagram)
        expect(contact).not_to be_valid
      end
      it 'other_info' do
        contact = FactoryBot.build(:invalid_other_info)
        expect(contact).not_to be_valid
      end
    end
  end
end
