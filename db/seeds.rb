# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
puts 'Cleaning up database'
Tool.destroy_all
User.destroy_all

puts 'Creating users and tools'

tools = %w(hammer drill chainsaw pliers showel)
5.times do
  user = User.new(
    password: '123456',
    email: Faker::Internet.email
  )
  user.save!
  puts "User #{user.email} created"
  rand(1..5).times do
    tool = Tool.new(
      description: Faker::Hipster.sentence,
      title: tools.sample,
      price: rand(5..100),
      user_id: user.id
    )
    tool.save!
    puts "#{tool.title} tool created"
  end
end
puts 'Seeding completed'
