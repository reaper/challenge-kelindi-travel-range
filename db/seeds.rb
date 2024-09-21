# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

url = 'https://raw.githubusercontent.com/Ginden/capitals/master/europe.json'
response = HTTParty.get(url)
cities = JSON.parse(response.parsed_response)

cities.each do |city|
  city = city.with_indifferent_access

  longitude, latitude = city.dig(:geometry, :coordinates)
  capital = city.dig(:properties, :capital)
  country = city.dig(:properties, :country)

  city = City.find_or_create_by!(
    longitude: longitude,
    latitude: latitude,
    capital: capital,
    country: country
  )
end
