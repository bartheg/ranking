class Ladder < ActiveRecord::Base
  belongs_to :game
  has_many :scenarios
  has_many :ratings
  has_many :reports, through: :scenario
end
