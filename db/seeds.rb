# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.new(username: "rahul")
user1.password = "qwerty"
user1.save!

resto = Restaurant.create!(name:"testrest", description:"this is a test description", city:"London", postcode: "N51EG", address1: "123 blackstock road", website_url: "https://www.test.com", email: "test@test.com")