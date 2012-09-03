# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  attr_protected :admin
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :forecasts, dependent: :destroy
  has_many :pictographs, dependent: :destroy
  has_many :discussions, dependent: :destroy

  has_many :evaluations, class_name: "RSEvaluation", as: :source

  has_many :comments
  has_many :piccomments
  

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  VALID_USERNAME_REGEX = /^[\w+\.-]+$/
  validates :name, presence: true, 
	           length: { maximum: 20, minimum: 3 }, 
		   format: { with: VALID_USERNAME_REGEX },
		   uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    Micropost.from_users_followed_by(self)
  end

  def ffeed
    Forecast.from_users_followed_by(self)
  end


  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def voted_for?(pictograph)
    evaluations.where(target_type: pictograph.class, target_id: pictograph.id).present?
  end
  
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end

