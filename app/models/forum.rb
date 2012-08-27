class Forum < ActiveRecord::Base
  attr_accessible :name
  has_many :subforums

  validates :name, presence: true, length: { maximum: 30 }
end
