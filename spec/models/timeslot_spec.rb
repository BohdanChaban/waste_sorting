require 'rails_helper'

RSpec.describe Timeslot, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      timeslot = FactoryBot.build(:timeslot_valid_time)
      expect(timeslot).to be_valid
    end
  end
end
