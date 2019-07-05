# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    factory :valid_city do
      name { 'Lviv' }
    end
  end
end
