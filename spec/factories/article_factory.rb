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
  end
end
