class Station < ActiveRecord::Base
  attr_accessible :city, :identifier, :lat, :lon, :state
  default_scope order: 'stations.identifier'
end
