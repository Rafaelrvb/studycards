# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

puts "cleaning the database"
Deck.destroy_all
User.destroy_all
puts "database cleaned"
puts "seeding database..."

user = User.new(
      name: 'admin',
      nickname: 'admin_nickname',
      email: 'admin@gmail.com',
      password: '123456'
    )
user.save!
puts "#{user.id} - #{user.name} created"

10.times do
  user = User.new(
    nickname: Faker::Internet.user_name,
    email: Faker::Internet.email,
    name: Faker::Name.name,
    password: '123456'
  )
  user.save
  puts "#{user.id} - #{user.name} created"

  (5..10).to_a.sample.times do
    deck = Deck.new(
      title: Faker::Educator.course_name ,
      description: Faker::Educator.subject,
      user_id: user.id
    )
    deck.save
    puts "#{deck.id} - #{deck.title} created"
  end
end
