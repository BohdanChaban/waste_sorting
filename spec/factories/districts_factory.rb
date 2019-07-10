FactoryBot.define do
  factory :district do
    association :city, factory: :city_with_valid_name
    factory :district_with_valid_name do
      name { 'Залізничний' }
    end

    factory :district_with_invalid_name do
      name { '' }
    end
    factory :district_name_downcase do
      name { 'франківський' }
    end
    factory :district_name_upcase do
      name { 'Франківський' }
    end
    factory :district_name_with_apostrophe do
      name { "Солом'янський" }
    end
    factory :district_name_with_hyphen do
      name { 'Амур-Нижньодніпровський' }
    end
    factory :district_name_latin do
      name { 'Zaliznychnui' }
    end
    factory :district_name_spec_char do
      name { "!#$%&'()*+,./:;<=>?@[]^_`{|}~" }
    end
    factory :district_name_long do
      name { 'Амур-Нижньодніпровський район‎ (Дніпро)‎' }
    end
    factory :district_name_short do
      name { 'Ба' }
    end
    factory :district_name_with_digits do
      name { '123456' }
    end
  end
end
