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
DeckReview.destroy_all
DeckCommunity.destroy_all
Card.destroy_all
Deck.destroy_all
User.destroy_all
puts "database cleaned"
puts "seeding database..."

user = User.new(
      name: 'Pedro',
      nickname: 'pedro_braga',
      email: 'pedro@gmail.com',
      password: '123456'
    )
user.save!
puts "#{user.id} - #{user.name} created"

70.times do
  user = User.new(
    nickname: Faker::Internet.user_name,
    email: Faker::Internet.email,
    name: Faker::Name.name,
    password: '123456'
  )
  user.save
  puts "#{user.id} - #{user.name} created"

  # seeding with Trivia API:

  amount = rand(20..50)
  category = [9,10,11,12,14,15,16,17,18,21,22,23,27,28,29,31,32].sample
  url = "https://opentdb.com/api.php?amount=#{amount}&category=#{category}&type=multiple&encode=base64"
  read_api = URI.open(url).read
  trivia = JSON.parse(read_api)

  deck = Deck.new(
    title: Base64.decode64(trivia['results'][0]['category']),
    description: "Trivia about #{Base64.decode64(trivia['results'][0]['category'])} with #{amount-1} questions!",
    availability: ["Public","Public","Public","Commercial"].sample,
    user_id: user.id
  )
  deck.save
  if deck.availability == "Commercial"
    deck.price = 10
  end
  deck.sku = deck.id
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

@user = User.all
@user.each do |user|
  5.times do
    deck = Deck.all.sample
    until deck.user_id != user.id
      deck = Deck.all.sample
    end
    deck_community = DeckCommunity.new(
      deck_id: deck.id,
      user_id: user.id
    )
    deck_community.save!
    puts "Community #{deck_community.id} saved"

    options = ["Great cards","Excellent!", "Nice job", "Chuck Norris wrote this cards", "Very good","I learned a lot","It helped me a lot","Difficult cards but very well structured. I liked it a lot",
              "Good", "I really can study whit that","Nice Price",
              "It could be better","I appreciated some cards","I liked it but it could be more difficult", "Complex but funccional",
              "I couldn`t learn well", "Need to be more hard",
              "Terrible", "it´s random", "It´s bad", "try again :(","Too bad, too many cards, and they are repeated","Too expensive","Incomplete"]
    content = options.sample
    review = DeckReview.new(
      deck_id: deck.id,
      user_id: user.id,
      review_content: content,
      rating: if options.find_index(content) < 11
                rand(4..5)
              elsif options.find_index(content) > 16
                rand(1..2)
              else
                3
              end,
    )
    review.save!
  end
end
