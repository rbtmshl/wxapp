class Comment < ActiveRecord::Base
  attr_accessible :content, :discussion_id
  belongs_to :user
  belongs_to :discussion

  validates :content, presence: true, length: { maximum: 2000 }
 
  default_scope order: 'comments.created_at DESC'

end
