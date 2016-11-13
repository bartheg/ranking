class RankingConfig < ActiveRecord::Base
  belongs_to :ranking

  validates :default_score, presence: true
  validates :hours_to_confirm, presence: true

  validate :invalid_when_is_default_and_has_ranking_id
  validate :invalid_when_is_not_default_and_without_ranking_id
  validate :invalid_with_not_existing_ranking_id


  def self.default_config
    RankingConfig.where(is_default: true).first
  end

  private

  def invalid_with_not_existing_ranking_id
    if ranking_id
      unless ranking
        self.errors[:base] << "The given ranking does not exist"
      end
    end
  end

  def invalid_when_is_not_default_and_without_ranking_id
    if !is_default and !ranking_id
      self.errors[:base] << "Default config has to be default or belong to a ranking"
    end
  end

  def invalid_when_is_default_and_has_ranking_id
    if is_default and ranking_id
      self.errors[:base] << "Default config can not belong to any ranking"
    end
  end

end
