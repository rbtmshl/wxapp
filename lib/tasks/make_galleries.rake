namespace :db do
  desc "Fill database with sample data"
  task gallerypopulate: :environment do
    make_galleries
  end
end

def make_galleries
  Gallery.create!(name:     "Sunset and Sunrise")
end

