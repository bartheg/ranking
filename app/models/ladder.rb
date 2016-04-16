class Ladder < ActiveRecord::Base
  belongs_to :game
  has_many :scenarios
end
