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
end
