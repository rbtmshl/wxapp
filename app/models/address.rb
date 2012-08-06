class Address < ActiveRecord::Base
  attr_accessible :city, :country, :lat, :lng, :locality, :state, :street, :zip
end
