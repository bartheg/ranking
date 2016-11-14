module PagesHelper
  def find_default_ranking_config
    { id: RankingConfig.find_by(is_default: true) }
  end
end
