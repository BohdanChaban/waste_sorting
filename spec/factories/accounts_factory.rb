FactoryBot.define do
  factory :account do
    association :user, factory: :user
    association :city, factory: :city_with_valid_name
    
    name { 'Name' }
    surname { 'Surname' }
    address { 'Львів' }
    mobile_number { '+380998494555' }

    factory :invalid_account do
      name { ' ' }
      surname { ' ' }
      address { ' ' }
      mobile_number { ' ' }
    end

    factory :account_with_long_name do
      name { 'Name' * 20 }
    end

    factory :account_with_long_surname do
      surname { 'Surname' * 20 }
    end

    factory :account_with_long_address do
      address { 'Львів' * 20 }
    end

    factory :account_with_long_mobile_number do
      mobile_number { '380996548874' * 20 }
    end

    factory :account_with_short_mobile_number do
      mobile_number { '38099' }
    end
  end
end
