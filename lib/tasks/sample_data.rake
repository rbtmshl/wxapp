namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_forecasts
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Robert Marshall",
                       email:    "robert.marshallii1@gmail.com",
                       password: "password",
                       password_confirmation: "password")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_forecasts
  users = User.all(limit: 10)
  3.times do
    sensible = "Snow"
    hi_temp = 28
    lo_temp = 22
    ws = 10
    wd = 315
    precip_chance = 80
    qpf = 0.50
    users.each { |user| user.forecasts.create!(sensible: sensible, hi_temp: hi_temp, lo_temp: lo_temp, ws: ws, wd: wd, precip_chance: precip_chance, qpf: qpf) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

