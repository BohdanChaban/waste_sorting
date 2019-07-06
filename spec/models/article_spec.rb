require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'validations' do
    let!(:article) { FactoryBot.create(:valid_attributes) }
    let(:short_text)    { 'ffff' }
    let(:long_text)     { 'f' * 41 }

    # Errors definition
    let(:short_error)   { 'pick a longer name' }
    let(:long_error)    { 'pick a shorter name' }
    let(:blank) { "can't be blank" }

    it 'is valid with valid attributes' do
      expect(article).to be_valid
    end

    it 'is not valid with too short title' do
      article.title = short_text
      expect(article).not_to be_valid
      expect(article.errors.messages[:title]).to eq [short_error]
    end

    it 'is not valid with too long title' do
      article.title = long_text
      expect(article).not_to be_valid
      expect(article.errors.messages[:title]).to eq [long_error]
    end

    it 'is not valid without a title' do
      article.title = nil
      expect(article).not_to be_valid
      expect(article.errors.messages[:title]).to eq [short_error, blank]
    end
  end
end
