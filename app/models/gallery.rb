class Gallery < ActiveRecord::Base
  attr_accessible :name
  has_many :pictographs

  validates :name, presence: true
end
