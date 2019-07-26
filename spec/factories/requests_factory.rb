FactoryBot.define do
  factory :request do
    association :timeslot, factory: :timeslot_valid_time
    association :user, factory: :user
    factory :request_valid_status do
      status { 'initiated' }
    end
    factory :request_invalid_status do
      status { ' ' }
    end
  end
end
