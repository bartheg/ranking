class Faction < ActiveRecord::Base
  belongs_to :game
  has_many :faction_to_scenario_assignments
  has_many :scenarios, through: :faction_to_scenario_assignments
  has_many :reports_as_reporters_faction, class_name: 'Report', foreign_key: 'reporters_faction_id'
  has_many :reports_as_opponents_faction, class_name: 'Report', foreign_key: 'opponents_faction_id'
end
