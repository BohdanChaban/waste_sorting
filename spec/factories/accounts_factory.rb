FactoryBot.define do
  factory :account do
    association :user, factory: :user

    association :district, factory: :district_valid_name

    name { 'Name' }
    surname { 'Surname' }
    address { 'Шевченка, 77' }
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
      address { 'Шевченка, 77' * 20 }
    end

    factory :account_with_long_mobile_number do
      mobile_number { '380996548874' * 20 }
    end

    factory :account_with_short_mobile_number do
      mobile_number { '38099' }
    end

    factory :account_with_role_customer do
      association :user, factory: :user_customer
    end

    factory :account_with_role_customer_without_district do
      district { nil }
    end

    factory :account_with_role_admin do
      association :user, factory: :user_admin
      district { nil }
    end
    factory :account_with_manager_role do
      association :user, factory: :user_manager
      name { 'Manager' }
      district { nil }
      mobile_number { '380996548874' }
    end
  end
end
