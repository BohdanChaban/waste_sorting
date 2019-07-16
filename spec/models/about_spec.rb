require 'rails_helper'

RSpec.describe About, type: :model do
  context 'check validation of about ' do
    it 'is valid with valid attributes' do
      about = FactoryBot.create(:about)
      expect(about).to be_valid
    end
    it 'is valid with valid attributes' do
      about = FactoryBot.build(:about_invalid)
      expect(about).to_not be_valid
    end
  end
end
