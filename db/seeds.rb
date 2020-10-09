# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "管理者",
             email: "admin@gmail.com",
             password:  "adminsan",
             password_confirmation: "adminsan",
             admin: true)
<<<<<<< HEAD




10.times do |n|
  labels = Label.create!([name: "ラベル#{n + 1}"])
end
=======
>>>>>>> edd2e86bf039d0634cae4e8556178e5cd93d808b
