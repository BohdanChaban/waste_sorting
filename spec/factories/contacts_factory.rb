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
      factory :invalid_name do
        name { 'Head Office Waste Sorting LTD and Local Office Waste Sorting LTD' }
      end
      factory :invalid_address do
        address { 'Shevchenka St, 111A, Lviv' * 5 }
      end
      factory :invalid_email do
        email { 'head@office.com' * 4 }
      end
      factory :invalid_mobile_number do
        mobile_number { '+38000000000' * 3 }
      end
      factory :invalid_facebook do
        facebook { 'http://fb.com/waste_sorting' * 3 }
      end
      factory :invalid_instagram do
        instagram { 'http://instagram.com/waste_sorting' * 3 }
      end
      factory :invalid_other_info do
        other_info { 'Zip Code: 79000' * 5 }
      end
    end
  end
end
