joke_categories = [
  "Puns",
  "Programming",
  "Knock Knock",
  "Limericks",
]

if Category.all.length == 0
  joke_categories.each do |category|
    Category.create(name: category)
    puts "created #{category} category"
  end
end

if User.count == 0
  User.create(username: "Ray", email: "ray@test.com", password: "password1", password_confirmation: "password1")
  User.create(username: "Aidan", email: "aidan@test.com", password: "password2", password_confirmation: "password2")
  User.create(username: "Kat", email: "kat@test.com", password: "password3", password_confirmation: "password3")
end

if Joke.count == 0
  Joke.create(user_id: 1, category_id: 1, body: "Why did Adele cross the road? To say hello from the other side.")
  Joke.create(user_id: 1, category_id: 1, body: "What kind of concert only costs 45 cents? A 50 Cent concert featuring Nickelback.")
  Joke.create(user_id: 1, category_id: 1, body: "What did the grape say when it got crushed? Nothing, it just let out a little wine.")
  Joke.create(user_id: 1, category_id: 1, body: "Time flies like an arrow. Fruit flies like a banana.")
  Joke.create(user_id: 2, category_id: 2, body: "Two bytes meet.  The first byte asks, “Are you ill?” The second byte replies, “No, just feeling a bit off.”")
  Joke.create(user_id: 2, category_id: 2, body: "How many programmers does it take to change a light bulb? None – It’s a hardware problem")
  Joke.create(user_id: 2, category_id: 2, body: "There are only 10 kinds of people in this world: those who know binary and those who don’t.")
end
