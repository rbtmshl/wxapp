class Comment < ActiveRecord::Base
  attr_accessible :content, :discussion_id
  belongs_to :user
  belongs_to :discussion

  validates :content, presence: true, length: { maximum: 2000 }
  validates :user_id, presence: true
  validates :discussion_id, presence: true

  default_scope order: 'comments.created_at ASC'

end
