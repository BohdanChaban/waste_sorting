require 'rails_helper'

RSpec.describe Request, type: :model do
  context 'validations' do
    let(:status) { FactoryBot.create(:request_valid_status) }
    it 'is valid with valid attributes' do
      request = FactoryBot.build(:request_valid_status)
      expect(request).to be_valid
    end
  end
end
