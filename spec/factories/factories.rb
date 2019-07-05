FactoryBot.define do
  factory :user do
    email { 'vasia12@gmail.com' }
    role { 'customer' }
    password { '12345678' }
  end
end
