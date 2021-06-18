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
