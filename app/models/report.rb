class Report < ActiveRecord::Base
  belongs_to :scenario
  belongs_to :reporter, foreign_key: 'reporter_id', class_name: 'Profile'
  belongs_to :confirmer, foreign_key: 'confirmer_id', class_name: 'Profile'
  belongs_to :reporters_faction, foreign_key: 'reporters_faction_id', class_name: 'Faction'
  belongs_to :confirmers_faction, foreign_key: 'confirmers_faction_id', class_name: 'Faction'
  has_many :rankings
  has_many :report_comments
  belongs_to :result, foreign_key: 'result_id', class_name: 'PossibleResult'

  attr_accessor :confirmers_name, :was_just_confirmation

  enum status: { unconfirmed: 0, confirmed: 1, to_calculate: 2, calculated:3 }

  validates :scenario_id, presence: true
  validates :reporter_id, presence: {message: "Your name can't be blank"}
  validates :confirmer_id, presence: {message: "Name of your opponent can't be blank"}
  validates :reporters_faction_id, presence: {message: "Your faction can't be blank"}
  validates :confirmers_faction_id, presence: {message: "Faction of your opponent can't be blank"}
  validates :result_id, presence: true

  validate :profiles_are_from_different_users

  def profiles_are_from_different_users
    if reporter_id and confirmer_id
      if self.reporter.user_id == self.confirmer.user_id
        # self.errors.add(:confirmer, "profile belongs to you. Are you trying to cheat?")
        self.errors[:base] << "Your opponent's profile belongs to YOU!"
      end
    end

  end

  def handle_possible_confirmation
    @was_just_confirmation = false
    report_to_confirm = original_report

    if report_to_confirm
      report_to_confirm.confirmed!
      report_to_confirm.was_just_confirmation = true
      report_to_confirm.save
      return report_to_confirm
    end
    self
  end

  def was_just_confirmation?
    @was_just_confirmation
  end

  def previous(player)
    Report.where(scenario_id: scenario.id).where(["reporter_id = ? OR confirmer_id = ?", player.id, player.id]).where(["id < ?", id]).last
  end

  def self.by_profile(profile)
    Report.where(["reporter_id = ? OR confirmer_id = ?", profile.id, profile.id])
  end

  private

  def original_report
    number_of_hours = scenario.ladder.ladder_config.hours_to_confirm
    opposite_results = PossibleResult.where(game_id: scenario.ladder.game).where(score_factor: add_inv(result.score_factor))

    Report.where(status: "unconfirmed").where(scenario_id: scenario_id).where("created_at > ?", number_of_hours.hours.ago).where({reporter_id: confirmer_id, confirmer_id: reporter_id}).where({reporters_faction_id: confirmers_faction_id, confirmers_faction_id: reporters_faction_id}).where(result: opposite_results).first
  end

  def add_inv(number)
    hundred_percent = 100
    hundred_percent - number
  end

end
