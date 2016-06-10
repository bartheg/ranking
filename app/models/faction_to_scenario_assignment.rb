class FactionToScenarioAssignment < ActiveRecord::Base
  belongs_to :faction
  belongs_to :scenario
end
