FactoryBot.define do
  factory :inquiry do
    association :timeslot, factory: :timeslot_valid_time
    association :user, factory: :user
    factory :inquiry_valid_status do
      status { 'initiated' }
    end
    factory :inquiry_invalid_status do
      status { 'new' }
    end
  end
end
