class Ranking < ActiveRecord::Base
  before_create :build_default_config

  belongs_to :game
  has_many :scenarios
  has_many :reports, through: :scenarios
  has_many :calculated_positions
  has_one :ranking_config
  has_many :ranked_positions


  validates :name, presence: true
  validates :description, presence: true
  validates :game_id, presence: true

  resourcify

  private
  def build_default_config
    default_config = RankingConfig.default_config.dup
    # default_config
    self.ranking_config = default_config
    self.ranking_config.is_default = false
    # RankingConfig.new(is_default: false, hours_to_confirm: 49, default_score: 233)
    # self.ranking_config.save
    true
  end

end
