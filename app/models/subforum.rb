class Subforum < ActiveRecord::Base
  attr_accessible :forum_id, :name
  belongs_to :forum

  validates :forum_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }

  default_scope order: 'subforums.name'
end
