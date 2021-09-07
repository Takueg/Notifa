require 'faker'
puts "destroy all Notifications"
Notification.destroy_all
puts "destroy all users"
User.destroy_all
puts "destroy all searches"
Search.destroy_all
puts "destroy all posts"
Post.destroy_all
puts "destroy all neighborhoods"
Neighborhood.destroy_all

# ----------------------------------------------------
# Creating Notifications #
# has to be copied and pushed at once in the console:
# ----------------------------------------------------
Search.all.each do |search|
  search.notifications.create(post: Post.all.sample)
end

puts 'Creating Users'
User.create!(
    email: 'tyras.torsten@gmail.com',
    password: '12345678',
    first_name: 'Torsten',
    last_name: 'Tyras'
    )
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

puts 'Creating 20 fake searches...'

frequency = ["Immediately", "Hourly", "Once a day"]
category = ["Studio", "Apartment", "Private room", "Shared room", "House"]
images = []

20.times do
  Search.create!(
    user: User.all.sample,
    city: 'Berlin',
    frequency: frequency.sample,
    category: category.sample,
    max_price: rand(550..2500),
    min_size: rand(8..50),
    room: rand(0..3)
    )
end


puts 'Creating neighborhoods'

Neighborhood.create!(
  name: 'Mitte',
  description: "Mitte literally translates to middle and that is (basically) where it lies. This district is plopped as close to center as possible for the squiggly line mess that is a map of Berlin.",
  image_url: "https://www.tripsavvy.com/thmb/w5xtixWj0tHlqZAvEGFYrs_3bTU=/1250x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Reichstag7-f7065585d75544cb9423aa5365136483.jpg"
  )

Neighborhood.create!(
  name: 'Prenzlauer Berg',
  description: "Prenzlauer Berg is perfect example of the confusion regarding neighborhoods. Though this is one of the most popular areas for visitors and Berliners, it is actually part of the Pankow Bezirk.",
  image_url: "https://www.tripsavvy.com/thmb/4YPUSyFr3f3rPlgxO87tcomglk0=/1250x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Prenzlauer15-337c37c6d8eb48d28498dcc110b5c956.jpg"
  )

Neighborhood.create!(
  name: 'Friedrichshain',
  description: "Friedrichshain is young, punk, industrial, and full of history. It is now part of a combined district of Friedrichshain -Kreuzberg, but these Kiez across the water have distinct personalities.",
  image_url: "https://www.tripsavvy.com/thmb/NvOYaZRMZzrOx7t_S1ckxH9lJKc=/1250x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/RiverSpree-81381d56c32140feadae0f55c9545724.jpg"
  )

Neighborhood.create!(
  name: "Kreuzberg",
  description: "Kreuzberg was once the area for immigrants, then squatters, then artists and students, and is now being taken over by a much richer crowd at a breathtaking pace.",
  image_url: "https://www.tripsavvy.com/thmb/STgTZvTcEalZnPnL3Gu0Amlx8EA=/1250x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Kreuzberg11-7f83229ce382450589a1a5e2ff7f5ff2.jpg"
  )

Neighborhood.create!(
  name: "Charlottenburg",
  description: "Charlottenburg-Wilmersdorf (its title — again uniting two formerly distinct neighborhoods) is the nicer Berlin. It is cleaner and more civilized, but for many people that also means it is more boring.",
  image_url: "https://www.tripsavvy.com/thmb/3q32eMuyoxbFjOjOYvjDM2Z7Us4=/1250x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/charlottenburgkaiserwilhelmchurchGettyImages-654831923DougArmand-599bdde50d327a0011a7b5e5.jpg"
  )

Neighborhood.create!(
  name: "Wedding",
  description: "Wedding (pronounced VED-ding) has a very different reputation than of Mitte. Located just north of central Mitte, the area is still a haven of relatively cheap rents in grand historical buildings.",
  image_url: "https://www.tripsavvy.com/thmb/JqpxrzgHwFdQPq6JWH8eJD8JaLk=/1250x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/HumboldthainFlakturmIanDunster-599d2d3403f402001192ae3c.jpg"
  )

Neighborhood.create!(
  name: "Neukölln",
  description: "Neukölln is a popular neighborhood, changing amidst rampant gentrification. This neighborhood is the current darling of new immigrants and a great place to base yourself for nightlife.",
  image_url: "https://www.tripsavvy.com/thmb/wf0vOUgikrHGpi024rOICY0gl80=/1250x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/TemplehofNeukoellnGettyImages-493550961AxelSchmidt-599bdf84c41244001330f5e8.jpg"
  )

puts 'created neighborhoods'


puts 'Creating posts from posts.json...'


filepath = File.join(Rails.root, 'db', 'posts.json')
serialized_posts = File.read(filepath)
posts = JSON.parse(serialized_posts)


posts.each do |post|
  Post.create!(
    address: post["address"],
    price: post["price"],
    size: post["size"],
    room: post["room"],
    description: post["description"],
    title: post["title"],
    post_url: post["post_url"],
    category: post["category"],
    date_posted: post["date_posted"],
    company: post["company"],
    image_urls: post["image_urls"],
    latitude: post["latitude"],
    longitude: post["longitude"]
  )
end
puts 'Finished!'
