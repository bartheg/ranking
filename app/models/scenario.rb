class Scenario < ActiveRecord::Base
  belongs_to :ladder
  has_many :faction_to_scenario_assignments
  has_many :factions, through: :faction_to_scenario_assignments
  has_many :reports
  belongs_to :game
end
