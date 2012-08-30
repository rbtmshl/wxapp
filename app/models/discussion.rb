class Discussion < ActiveRecord::Base
  attr_accessible :name, :opencomment, :subforum_id, :forum_id
  belongs_to :subforum
  belongs_to :user

  validates :user_id, presence: true
  validates :subforum_id, presence: true
  validates :name, presence: true, length: { maximum: 90, minimum: 3 }
  validates :opencomment, presence: true, length: { maximum: 2000 }

  default_scope order: 'discussions.updated_at DESC'
end