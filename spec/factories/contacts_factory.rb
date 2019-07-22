FactoryBot.define do
  factory :contact do
    factory :contact_valid_attributes do
      name { 'Head Office Waste Sorting LTD' }
      address { 'Shevchenka St, 111A, Lviv' }
      email { 'head@office.com' }
      mobile_number { '+38000000000' }
      facebook { 'http://fb.com/waste_sorting' }
      instagram { 'instagram.com/waste_sorting' }
      other_info { 'Zip Code: 79000' }
    end
    factory :contact_invalid_attributes do
      factory :contact_invalid_name do
        name { 'Head Office Waste Sorting LTD and Local Office Waste Sorting LTD' }
      end
      factory :contact_invalid_address do
        address { 'Shevchenka St, 111A, Lviv' * 5 }
      end
      factory :contact_invalid_email do
        email { 'head@office.com' * 4 }
      end
      factory :contact_invalid_mobile_number do
        mobile_number { '+38000000000' * 3 }
      end
      factory :contact_invalid_facebook do
        facebook { 'http://fb.com/waste_sorting' * 3 }
      end
      factory :contact_invalid_instagram do
        instagram { 'http://instagram.com/waste_sorting' * 3 }
      end
      factory :contact_invalid_other_info do
        other_info { 'Zip Code: 79000' * 5 }
      end
    end
  end
end
