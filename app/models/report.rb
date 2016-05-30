class Report < ActiveRecord::Base
  belongs_to :scenario
  belongs_to :reporter, foreign_key: 'reporter_id', class_name: 'Profile'
  belongs_to :confirmer, foreign_key: 'confirmer_id', class_name: 'Profile'
  belongs_to :reporters_faction, foreign_key: 'reporters_faction_id', class_name: 'Faction'
  belongs_to :confirmers_faction, foreign_key: 'confirmers_faction_id', class_name: 'Faction'
  has_many :rankings
  has_many :report_comments

  attr_accessor :confirmers_name, :result_description

  validates :scenario_id, presence: true
  validates :reporter_id, presence: {message: "Your name can't be blank"}
  validates :confirmer_id, presence: {message: "Name of your opponent can't be blank"}
  validates :reporters_faction_id, presence: {message: "Your faction can't be blank"}
  validates :confirmers_faction_id, presence: {message: "Faction of your opponent can't be blank"}
  validates :result, presence: true

  validate :profiles_are_from_different_users


  def profiles_are_from_different_users
    if reporter_id and confirmer_id
      if self.reporter.user_id == self.confirmer.user_id
        # self.errors.add(:confirmer, "profile belongs to you. Are you trying to cheat?")
        self.errors[:base] << "Your opponent's profile belongs to YOU!"
      end
    end
  end

end
