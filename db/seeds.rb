# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p 'Seeding Draft...'

User.create(email: 'wazery@ubuntu.com', password: '123456789')
Project.create(name: 'TopCoder', scale: '1', unit: 'pt', color_format: 'Hex', user_id: 1)
Project.create(name: 'Apple Pay', scale: '2', unit: 'px', color_format: 'HRGBA', user_id: 1)

p 'Seeding Finished!'
