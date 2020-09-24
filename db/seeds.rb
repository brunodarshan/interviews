# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Offer::CreateOfferService.new(
  advertiser_name: 'Foo Ltda.',
  url: 'http://foo.com/buy_it',
  description: 'lorem ipsum dolor sit amet. lorem ipsum dolor sit amet.',
  starts_at: Time.now.utc
).call