FactoryBot.define do
  factory :user do
    email { 'vasia12@gmail.com' }
    role { 'customer' }
    password { '12345678' }

    factory :user_customer do
      email { 'customer@gmail.com' }
      role { 'customer' }
    end

    factory :user_manager do
      email { 'manager@gmail.com' }
      role { 'manager' }
    end

    factory :user_admin do
      email { 'admin@gmail.com' }
      role { 'admin' }
    end
  end
end
