class Forecast < ActiveRecord::Base
  attr_accessible :hi_temp, :lo_temp, :precip_chance, :qpf, :sensible, :wd, :ws
  belongs_to :user

  validates :user_id, presence: true
  validates :sensible, presence: true, length: { maximum: 20 } 
  validates :hi_temp, presence: true
  validates :lo_temp, presence: true
  validates :ws, presence: true
  validates :wd, presence: true
  validates :precip_chance, presence: true
  validates :qpf, presence: true

  default_scope order: 'forecasts.created_at DESC'

  def getWindDir(int)
    dirStr = ["N","NE","E","SE","S","SW","W","NW"]
    dirDeg = [0, 45, 90, 135, 180, 225, 270, 315]
    (0..7).each do |i|
      if int == dirDeg[i]
	return dirStr[i]
      end      
    end
    return "N"
  end

  def precipStr(int)
    pCat = [1, 2, 3, 4, 5, 6, 7]
    pStr = ["0.00\" or trace", "0.01\" - 0.24\"", "0.25\" - 0.49\"", "0.50\" - 0.74\"", "0.75\" - 0.99\"", "1.00\" - 1.50\"", "1.50\" - 1.99\"", "2.00\" +"]
    (0..6).each do |i|
      if int == pCat[i]
        return pStr[i]
      end
    end
    return "0.00\" or trace"
  end

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
