FactoryBot.define do
  factory :contact do
    factory :valid_attributes do
      name { 'Head Office Waste Sorting LTD' }
      address { 'Shevchenka St, 111A, Lviv' }
      email { 'head@office.com' }
      mobile_number { '+38000000000' }
      facebook { 'http://fb.com/waste_sorting' }
      instagram { 'instagram.com/waste_sorting' }
      other_info { 'Zip Code: 79000' }
    end
    factory :invalid_attributes do
      name { '' }
    end
  end
end
