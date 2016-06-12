class DefaultLadderConfig < ActiveRecord::Base
  belongs_to :ladder

  validates :default_ranking, presence: true
  validates :hours_to_confirm, presence: true


end
