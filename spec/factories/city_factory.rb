# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    factory :valid_city do
      name { 'Львів' }
    end
    factory :invalid_city do
      name { nil }
    end
    factory :valid_name do
      name { 'Бурштин' }
    end
    factory :valid_name_with_apostrophe do
      name { "Кам'янка" }
    end
    factory :valid_name_with_hyphen do
      name { 'Корсунь-Шевченківський' }
    end
    factory :not_valid_name_with_latin do
      name { 'Lviv' }
    end
    factory :not_valid_name_with_spec_char do
      name { "!#$%&'()*+,./:;<=>?@[]^_`{|}~" }
    end
    factory :not_valid_name_long do
      name { "Нікополь\tДніпропетровська область" }
    end
    factory :not_valid_name_short do
      name { 'Ба' }
    end
    factory :not_valid_name_digits do
      name { '123456' }
    end
  end
end
