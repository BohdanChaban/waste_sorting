# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    factory :city_with_valid_name do
      name { 'Львів' }
    end
    factory :city_with_invalid_name do
      name { '' }
    end

    factory :city_name_downcase do
      name { 'рівне' }
    end

    factory :city_name_upcase do
      name { 'Рівне' }
    end

    factory :city_name_with_apostrophe do
      name { "Кам'янка" }
    end
    factory :city_name_with_hyphen do
      name { 'Корсунь-Шевченківський' }
    end
    factory :city_name_latin do
      name { 'Lviv' }
    end
    factory :city_name_spec_char do
      name { "!#$%&'()*+,./:;<=>?@[]^_`{|}~" }
    end
    factory :city_name_long do
      name { "Нікополь\tДніпропетровська область" }
    end
    factory :city_name_short do
      name { 'Ба' }
    end
    factory :city_name_with_digits do
      name { '123456' }
    end
  end
end
