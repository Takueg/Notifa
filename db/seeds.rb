require 'faker'

puts "destroy all users"
User.destroy_all
puts "destroy all searches"
Search.destroy_all
puts "destroy all posts"
Post.destroy_all

# ----------------------------------------------------
# Creating Notifications #
# has to be copied and pushed at once in the console:
# ----------------------------------------------------
# Search.all.each do |search|
#   search.notifications.create(post: Post.all.sample)
# end

puts 'Creating Users'

User.create!(
    email: 'lena.oberherr@gmail.com',
    password: '12345678',
    first_name: 'Lena',
    last_name: 'Oberherr'
    )
User.create!(
    email: 'takueg@gmail.com',
    password: '12345678',
    first_name: 'Takudzwa',
    last_name: 'Gwindingwi'
    )
User.create!(
    email: 'jcasoya@gmail.com',
    password: '12345678',
    first_name: 'Jorge',
    last_name: 'Cases'
    )
# User.create!(
#     email: '????',
#     password: '12345678',
#     first_name: 'Jonathan',
#     last_name: 'Scheffbuch'
#     )
User.create!(
    email: 'tyras.torsten@gmail.com',
    password: '12345678',
    first_name: 'Torsten',
    last_name: 'Tyras'
    )
# 20.times do
#   User.create!(
#     email: Faker::Internet.email,
#     password: Faker::Alphanumeric.alpha(number: 10),
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name
#     )
# end

puts 'Creating 20 fake searches...'

frequency = ["Immediately", "Hourly", "Once a day"]
category = ["Studio", "Apartment", "Private room", "Shared room", "House"]
images = []

20.times do
  Search.create!(
    user: User.all.sample,
    city: 'Berlin',
    frequency: frequency.sample,
    category: category.sample
    )
end

puts 'Creating 20 fake posts...'

20.times do
  Post.create!(
    address: Faker::Address.street_name,
    price: rand(350..1750),
    size: rand(20..220),
    room: rand(1..5),
    description: Faker::Lorem.sentence,
    )

end

puts 'Finished!'
