FactoryBot.define do
  factory :article do
    factory :valid_article do
      title { 'Some title' }
      summary { 'This is summary' }
      body { 'Input text here' }
    end
    factory :invalid_article do
      title { 'Some' }
      summary { '' }
      body { '' }
    end
    factory :invalid_article_with_short_text do
      title { 'ffff' }
    end
    factory :invalid_article_with_long_text do
      title { 'f' * 41 }
    end
  end
end
