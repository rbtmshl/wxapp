namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_forecasts
    make_relationships
    make_galleries
    make_forums
    make_subforums
    make_cities
  end
end

def make_users
  admin = User.create!(name:     "Weatherman",
                       email:    "robert.marshallii1@gmail.com",
                       password: "password",
                       password_confirmation: "password")
  admin.toggle!(:admin)

  adminn = User.create!(name:     "WeatherThug",
                       email:    "brittanylmarshall@gmail.com",
                       password: "password",
                       password_confirmation: "password")
  adminn.toggle!(:admin)

  99.times do |n|
    name  = "weatherNerd#{n+1}"
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
  followed_users = users[1..40]
  followers      = users[1..50]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_galleries
  Gallery.create!(name: "Sunrise and Sunset")
  Gallery.create!(name: "Clouds")
  Gallery.create!(name: "Snow")
  Gallery.create!(name: "Rain") 
end

def make_forums
  Forum.create!(name: "Main Forums")
  Forum.create!(name: "Regional Forums")
  Forum.create!(name: "Event Forums")
end

def make_subforums
  Subforum.create!(forum_id: 2, name: "US - Oregon")
  Subforum.create!(forum_id: 2, name: "US - Washington")
  Subforum.create!(forum_id: 2, name: "US - Colorado")
  Subforum.create!(forum_id: 2, name: "US - California")
  Subforum.create!(forum_id: 2, name: "US - Montana")
  Subforum.create!(forum_id: 2, name: "US - Idaho")
  Subforum.create!(forum_id: 2, name: "US - Wyoming")
  Subforum.create!(forum_id: 2, name: "US - Nevada")
  Subforum.create!(forum_id: 2, name: "US - Utah")
  Subforum.create!(forum_id: 2, name: "US - Arizona")
  Subforum.create!(forum_id: 2, name: "US - New Mexico")
  Subforum.create!(forum_id: 2, name: "US - Alaska")
end

def make_cities
  require 'open-uri'
  sta = ["OR","WA","CO","ID","UT","MT","NV","CA","AZ","NM","KS","NE","IA","ND","SD","MI","WI","TX","OK","AR","AK","HI","MO","FL","LA","AL","MS","GA","TN","OH","NC","SC","PA","NY","NJ","MN","IL","IN","KY","VT","NH","ME","RI","MA","CT","MD","VA","WV","WY","DE"]
  (1..sta.length).each do |j|
    st = sta[j-1]
    docname = "http://api.sba.gov/geodata/city_links_for_state_of/" + st + ".xml"
    doc = Nokogiri::XML(open(docname))
    cityname = doc.xpath("//name")
    citylat = doc.xpath("//primary_latitude")
    citylon = doc.xpath("//primary_longitude")
  
    (1..cityname.length).each do |i|
      cname = cityname[i-1].content.to_s + ", " + st
      clat = citylat[i-1].content.to_s
      clon = citylon[i-1].content.to_s
      City.create!(name: cname, state: st, lat: clat, lon: clon)
    end
  end
  
end 
  
