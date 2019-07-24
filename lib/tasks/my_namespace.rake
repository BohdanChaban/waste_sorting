namespace :db do
  desc "TODO"
  task my_task: :environment do
user = User.create!(email: 'manager@example.com', password: '123456', role: 'manager')
user1 = User.create!(email: 'admin@example.com', password: '123456', role: 'admin')
user2 = User.create!(email: 'customer@example.com', password: '123456', role: 'customer')
user3 = User.create!(email: 'manager1@example.com', password: '123456', role: 'manager')
city = City.create!(name: 'Львів')
city2 = City.create!(name: 'Київ')
district = District.create!(name: 'Львівський', city: city)
Account.create!(name: 'Pivo1', surname: 'Rak1', address: 'str1', mobile_number: '1234567890', user: user1, city: city)
Account.create!(name: 'Pivo2', surname: 'Rak2', address: 'str2', mobile_number: '1234567890', user: user2, city: city)
Account.create!(name: 'Pivo3', surname: 'Rak4', address: 'str3', mobile_number: '1234567890', user: user3, city: city)
Account.create!(name: 'Pivo4', surname: 'Rak3', address: 'str4', mobile_number: '1234567890', user: user, city: city2)
Timeslot.create!(start_time: Time.now, district_id: district.id, user: user)
Timeslot.create!(start_time: Time.now + 1, district_id: district.id, user: user)
Timeslot.create!(start_time: Time.now + 2, district_id: district.id, user: user1)
Timeslot.create!(start_time: Time.now + 3, district_id: district.id, user: user2)
Timeslot.create!(start_time: Time.now + 4, district_id: district.id, user: user3)
  end
end
