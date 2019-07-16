FactoryBot.define do
  factory :about do
    content { 'MyString' }

    factory :about_invalid do
      content { ' ' }
    end
  end
end
