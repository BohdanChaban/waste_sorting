require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
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
      email { 'admin123@gmail.com' }
      role { 'admin' }
    end

    factory :invalid_user_with_long_email do
      email { 'vasia12@gmail.com' * 20 }
    end

    factory :invalid_user_with_short_email do
      email { 'a@c.' }
    end
  end
end
