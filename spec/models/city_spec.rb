require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'Associations' do
  	xit { should have_many(:districts) }
  	xit { should have_many(:users) }
  end

  describe 'Validate' do
  	xit { should validate_presence_of(:name) }
  	xit { should validate_length_of(:name).is_at_most(MAX_NAME_LENGTH) }
  end
end
