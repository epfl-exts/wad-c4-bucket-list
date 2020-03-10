# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create!(name: "Admin", email: "admin@epfl.ch", password: "password", role: "admin")
kurt = User.create!(name: "Kurt", email: "kurt@epfl.ch", password: "password")
dave = User.create!(name: "Dave", email: "dave@epfl.ch", password: "password")
krist = User.create!(name: "Krist", email: "krist@epfl.ch", password: "password")

5.times do |i|
  Idea.create!(title: "Great idea from #{admin.name}", user: admin)
  Idea.create!(title: "Great idea from #{kurt.name}", user: kurt)
  Idea.create!(title: "Great idea from #{dave.name}", user: dave)
  Idea.create!(title: "Great idea from #{krist.name}", user: krist)
end
