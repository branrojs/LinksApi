3.times do
  Link.create({
    title: Faker::Book.title,
    url: Faker::Book.title,
    short_url: Faker::Book.title,
    visites: Faker::Number.number(3)
              })
end
