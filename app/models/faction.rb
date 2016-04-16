class Faction < ActiveRecord::Base
  belongs_to :game
  has_many :scenarios, through: :faction_to_scenario_assignments
end
