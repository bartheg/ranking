class Scenario < ActiveRecord::Base
  belongs_to :ladder
  has_many :factions, through: :faction_to_scenario_assignments
end
