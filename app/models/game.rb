class Game < ActiveRecord::Base
  has_many :ladders
  has_many :scenarios, through: :ladders
  has_many :factions
  has_many :possible_results

end
