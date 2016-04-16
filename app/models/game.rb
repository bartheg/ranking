class Game < ActiveRecord::Base
  has_many :ladders
  has_many :factions

end
