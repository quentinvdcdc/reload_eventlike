# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Attendance.destroy_all
Event.destroy_all
User.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('user')
ActiveRecord::Base.connection.reset_pk_sequence!('event')
ActiveRecord::Base.connection.reset_pk_sequence!('attendance')

i = 0
10.times do
	i += 1
	User.create(first_name: Faker::Games::SonicTheHedgehog.character, last_name: Faker::Name.last_name, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), email: Faker::Name.first_name + "#{i}@yopmail.com", encrypted_password: "password")
end

5.times do
	Event.create(administrator: User.all.sample, start_date: Faker::Date.forward(days: 20), duration: 5 * rand(1..12), title: Faker::Lorem.sentence(word_count: 3), description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: Faker::Number.between(from: 1, to: 1000), location: Faker::Games::SonicTheHedgehog.zone)
end

Event.all.each do |event|
	rand(1..3).times do
		attendance_temp = Attendance.new(attendee: User.all.select {|user| user != event.administrator}.sample, attended_event: event, stripe_customer_id: Faker::Bank.iban(country_code: "fr"))
		attendance_temp.save unless Attendance.all.any? {|attendance| attendance.attendee == attendance_temp.attendee && attendance.attended_event == event}
	end
end

puts "seed completed"