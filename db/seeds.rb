# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Contact.create(name: 'Head Office Waste Sorting LTD',
               address: 'Shevchenka St, 111A, Lviv',
               email: 'head@office.com',
               mobile_number: '+38000000000',
               facebook: 'http://fb.com/waste_sorting',
               instagram: 'https://instagram.com/waste_sorting',
               other_info: 'Zip Code: 79000')

About.create(content: 'Waste Sorting a company that makes the world cleaner')

district_names = %w[
  Шевченківський Личаківський Сихівський Франківський Залізничний Галицький
]

city = City.create(name: 'Львів')

district_names.each do |name|
  District.create(name: name, city_id: city.id)
end

User.create(email: 'admin@exm.com', password: '123456', password_confirmation: '123456', role: 'admin')
