class Scenario < ActiveRecord::Base
  belongs_to :ranking
  has_many :reports
  has_many :faction_to_scenario_assignments
  has_many :factions, through: :faction_to_scenario_assignments
  belongs_to :game
end
