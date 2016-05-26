class Report < ActiveRecord::Base
  belongs_to :scenario
  belongs_to :reporter, foreign_key: 'reporter_id', class_name: 'Profile'
  belongs_to :confirmer, foreign_key: 'confirmer_id', class_name: 'Profile'
  belongs_to :reporters_faction, foreign_key: 'reporters_faction_id', class_name: 'Faction'
  belongs_to :confirmers_faction, foreign_key: 'confirmers_faction_id', class_name: 'Faction'
  has_many :rankings
  has_many :report_comments

  attr_accessor :confirmers_name, :result_description
end
