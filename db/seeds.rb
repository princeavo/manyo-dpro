# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb

require 'faker'


# Create 50 users, with some as admins
50.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password123",  # Replace with a secure password hashing mechanism
    password_confirmation: "password123",
    admin: rand(0..1) == 1  # Randomly assign admin role
  )
end

# Create 100 tasks, assigning them to random users
500.times do
  Task.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem::paragraph(sentence_count: 2),
    deadline_on: Faker::Date.forward(days: 14),
    priority: [:low, :medium, :high].sample,
    status: ["Not Started", "In Process", :Complete].sample,
    user: User.all.sample
  )
end

puts "Created #{User.count} users and #{Task.count} tasks."