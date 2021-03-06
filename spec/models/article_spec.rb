require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'validations' do
    let!(:article) { FactoryBot.create(:valid_article) }

    # Errors definition
    let(:short_error)   { 'is too short (minimum is 5 characters)' }
    let(:long_error)    { 'is too long (maximum is 40 characters)' }
    let(:blank) { "can't be blank" }

    it 'is valid with valid attributes' do
      expect(article).to be_valid
    end

    it 'is not valid with too short title' do
      article = FactoryBot.build(:invalid_article_with_short_text)
      expect(article).not_to be_valid
      expect(article.errors.messages[:title]).to eq [short_error]
    end

    it 'is not valid with too long title' do
      article = FactoryBot.build(:invalid_article_with_long_text)
      expect(article).not_to be_valid
      expect(article.errors.messages[:title]).to eq [long_error]
    end

    it 'is not valid without a title' do
      article.title = nil
      expect(article).not_to be_valid
      expect(article.errors.messages[:title]).to eq [short_error, blank]
    end
    it 'is not valid without a summary' do
      article.summary = nil
      expect(article).not_to be_valid
      expect(article.errors.messages[:summary]).to eq [blank]
    end
    it 'is not valid without a body' do
      article.body = nil
      expect(article).not_to be_valid
      expect(article.errors.messages[:body]).to eq [blank]
    end
  end
end
