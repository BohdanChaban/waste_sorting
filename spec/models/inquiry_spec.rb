require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  context 'Associations' do
    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
    it 'belongs to timeslot' do
      assc1 = described_class.reflect_on_association(:timeslot)
      expect(assc1.macro).to eq :belongs_to
    end
  end

  context 'validations' do
    let(:inquiry) { FactoryBot.build(:inquiry_valid_status) }
    it 'with valid attributes' do
      expect(inquiry).to be_valid
    end
  end
end
