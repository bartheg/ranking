module PagesHelper
  def find_default_ladder_config
    { id: LadderConfig.find_by(is_default: true) }
  end
end
