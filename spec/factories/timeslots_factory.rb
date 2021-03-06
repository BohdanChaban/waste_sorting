FactoryBot.define do
  factory :timeslot do
    association :district, factory: :district_valid_name
    association :user, factory: :user
    factory :timeslot_valid_time do
      start_time { Time.new(2019, 0o2, 24, 12, 0, 0, '+09:00') }
    end
    factory :timeslot_invalid_time do
      start_time { ' ' }
    end
  end
end
