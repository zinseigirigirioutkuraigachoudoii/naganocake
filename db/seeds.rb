# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin User Data
Admin.create!(
   email: 'test@test.com',
   password: 'testtest'
)

# Genre Data
Genre.create!(name: 'ケーキ')
Genre.create!(name: 'プリン')
Genre.create!(name: '焼き菓子')
Genre.create!(name: 'キャンディ')

# Item Data
# genre = Genre.find_by(name: 'ケーキ')
# Item.create!(
# name: 'cake',
# genre_id: genre.id,
# description: 'Cake1',
# price_without_tax: 1000,
# is_on_sale: true)