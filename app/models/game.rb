class Game < ActiveRecord::Base
  has_many :ladders
  has_many :scenarios, through: :ladders
  has_many :factions
  has_many :possible_results

  accepts_nested_attributes_for :possible_results, reject_if: :all_blank, allow_destroy: true

  resourcify
end
