class Report < ActiveRecord::Base
  belongs_to :scenario
  belongs_to :reporter, foreign_key: 'reporter_id', class_name: 'Profile'
  belongs_to :confirmer, foreign_key: 'confirmer_id', class_name: 'Profile'
  belongs_to :reporters_faction, foreign_key: 'reporters_faction_id', class_name: 'Faction'
  belongs_to :confirmers_faction, foreign_key: 'confirmers_faction_id', class_name: 'Faction'
  has_many :rankings
  has_many :report_comments

  attr_accessor :confirmers_name, :result_description


  # COLOR_REGEX = /\A#([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?\z/
  # validates :user_id, presence: true
  # validates :color, format: COLOR_REGEX, allow_nil: true
  #
  #
  # NAME_REGEX = /\A(\w|\.|-)+\z/
  # MUST_HAVE_LETTER_REGEX = /[a-zA-Z]+/
  # # validates :profile_id, presence: true
  # validates :name, presence: true
  # validates :name, format: NAME_REGEX
  # validates :name, format: MUST_HAVE_LETTER_REGEX
  # validates :name, length: { maximum: 24, minimum: 3 }


end
