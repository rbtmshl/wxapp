class Pictograph < ActiveRecord::Base
  attr_accessible :description, :gallery_id, :name, :image
  belongs_to :user
  belongs_to :gallery
  mount_uploader :image, ImageUploader

  validates :user_id, presence: true
  validates :gallery_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 140 }
  validates :image, presence: true

  default_scope order: 'pictographs.created_at DESC'
end