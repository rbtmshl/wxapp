class City < ActiveRecord::Base
  attr_accessible :lat, :lon, :name, :state
  default_scope order: 'cities.name'
end
