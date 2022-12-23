# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require "json"

puts "Destroying users..."

User.destroy_all

puts "Creating users"
url = "https://jsonplaceholder.typicode.com/users"

user_hash = URI.open(url).read
users = JSON.parse(user_hash)

users.each do |user|
  User.create!(
    email: user["email"],
    nickname: user["username"],
    password: Faker::Internet.password
  )
end

puts "Creating posts"

20.times do
  Post.create!(
    user_id: (rand 1...10),
    title: Faker::Book.title,
    content: File.readlines('db/sample_post.txt', chomp: true).join,
    url: Faker::Internet.url(host: 'example.com')
  )
end
