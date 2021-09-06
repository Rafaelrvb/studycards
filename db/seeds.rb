# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
require 'json'
require 'open-uri'
require "base64"

puts "cleaning the database"
Card.destroy_all
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

30.times do
  user = User.new(
    nickname: Faker::Internet.user_name,
    email: Faker::Internet.email,
    name: Faker::Name.name,
    password: '123456'
  )
  user.save
  puts "#{user.id} - #{user.name} created"

  # seeding with Trivia API:

  amount = rand(30..50)
  category = [9,10,11,12,14,15,16,17,18].sample
  url = "https://opentdb.com/api.php?amount=#{amount}&category=#{category}&type=multiple&encode=base64"
  read_api = URI.open(url).read
  trivia = JSON.parse(read_api)

  deck = Deck.new(
    title: Base64.decode64(trivia['results'][0]['category']),
    description: "Trivia about #{Base64.decode64(trivia['results'][0]['category'])} with #{amount-1} questions!",
    user_id: user.id
  )
  deck.save
  puts "#{deck.id} - #{deck.title} created"

  i = 0
  (amount-1).times do
    card = Card.new(
      front_page: Base64.decode64(trivia['results'][i]['question']),
      back_page: Base64.decode64(trivia['results'][i]['correct_answer']),
      deck_id: deck.id
    )
    i += 1
    card.save
    puts "#{i} Card #{card.id}-> Q:#{Base64.decode64(trivia['results'][i]['question'])} - A:#{Base64.decode64(trivia['results'][i]['correct_answer'])} created"
  end
  puts "#{amount} cards expected and #{i} created"

end
