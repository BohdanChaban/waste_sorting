FactoryBot.define do
  factory :article do
    factory :valid_attributes do
      title { 'Some title' }
      summary { 'This is summary' }
      body { 'Input text here' }
    end
  end
end
